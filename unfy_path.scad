// LibFile: unfy_path.scad
//   UnfyOpenSCADLib Copyright Leif Burrow 2026
//   kc8rwr@unfy.us
//   unforgettability.net
//   .
//   This file is part of UnfyOpenSCADLib.
//   .
//   unfy_path contains modules for sweeping 2d shapes along a path.
//   .
//   Written with help from Claude (Anthropic)

// Module: unf_path_extrude
// Synopsis: Sweep a 2d child along a polyline
// Usage:
//   unf_path_extrude(path, &lt;args&gt;) child2d();
// Description:
//   Sweep a 2D child along a polyline that starts at the origin.
//   .
//   Orientation: the child starts in the XY plane at the origin, as with linear_extrude, and is turned to face the first segment with its X axis kept horizontal (if the first segment is straight up, nothing turns). At each corner it is rotated about the axis of that turn, so its orientation is carried along the path without any added roll.
//   .
//   Fillets: with no twist and no scale, each filleted corner is an exact rotate_extrude. With twist or scale, arcs are cut into straight mitered pieces; the piece count is what $fn/$fa/$fs would give a full circle of that radius, times (turn angle / 360).
//   .
//   Twist and scale are spread over the total path length, arcs included.
//   .
//   Limits:
//   * Non-uniform scale combined with twist is only approximate at joints.
//   * The module can't see the child's size, so it can't check that a fillet radius exceeds the profile's reach toward the inside of the turn. Too small a radius makes rotate_extrude fail (no twist/scale) or produces self-intersecting geometry (twist/scale).
//   .
//   All helpers are defined inside unf_path_extrude(), so they are private to it.
// Arguments:
//   path = [[x,y,z], [x,y,z,r], ...] Points to extrude to, in order. The extrusion always starts at [0,0,0]. The optional 4th value is the fillet radius for the corner at that point; 0 or omitted gives a sharp, mitered corner. The last point's radius is ignored.
//   ---
//   twist = Total twist in degrees over the whole path. Same sense as linear_extrude (left-hand rule about the direction of travel). (0)
//   scale = Scale at the end of the path: a number or [sx, sy]. Applied linearly with distance along the path. (1)
//   profile_r = Upper bound on how far the 2D child reaches from its origin. Only used to size the cuts for mitered joints. It must be at least the real value, or sharp corners will have gaps. Keep it close to the real value when using twist or scale through fillets: a much larger value can leave hairline internal voids (CGAL reports extra "Volumes") from the oversized cuts. (100)
// Figure(Spin;VPD=180;VPT=[20,20,20];NoAxes): filleted corners
//   $fn = 36;
//   use <unfy_path.scad>;
//   unf_path_extrude([[0,0,20,10], [40,0,20,10], [40,40,40]]) circle(3);
// Figure(Spin;VPD=180;VPT=[20,20,20];NoAxes): twist=180, profile_r=5
//   $fn = 36;
//   use <unfy_path.scad>;
//   unf_path_extrude([[0,0,20], [40,0,20,10], [40,40,40]], twist = 180, profile_r = 5) square([6,3], center = true);
module unf_path_extrude(path, twist = 0, scale = 1, profile_r = 100) {

    // ---- input checks -----------------------------------------------------

    function check_path(path) =
        assert(is_list(path) && len(path) > 0,
               "unf_path_extrude: path must be a non-empty list of points")
        assert(len([for (p = path)
                    if (!(is_list(p) && (len(p) == 3 || len(p) == 4)
                          && len([for (c = p) if (!is_num(c)) 1]) == 0)) 1]) == 0,
               "unf_path_extrude: each point must be [x,y,z] or [x,y,z,r] (numbers only)")
        assert(len([for (p = path) if (len(p) == 4 && p[3] < 0) 1]) == 0,
               "unf_path_extrude: corner radius must be >= 0")
        path;

    // ---- vector helpers ---------------------------------------------------

    eps = 1e-9;

    function unit(v) = v / norm(v);
    function angle(a, b) = acos(max(-1, min(1, a * b)));
    function perp(v) = unit(abs(v[0]) < 0.9 ? cross(v, [1, 0, 0]) : cross(v, [0, 1, 0]));

    function frame_mat(x, y, z, p) =
        [[x[0], y[0], z[0], p[0]],
         [x[1], y[1], z[1], p[1]],
         [x[2], y[2], z[2], p[2]],
         [0,    0,    0,    1]];

    function cumsum(v) =
        [for (i = 0, a = 0; i <= len(v); a = a + (i < len(v) ? v[i] : 0), i = i + 1) a];

    // Child X horizontal and perpendicular to t; identity when t is vertical.
    function init_frame(t) =
        let(h = cross(t, [0, 0, 1]),
            x = norm(h) < 1e-9 ? [1, 0, 0] : h / norm(h))
        [x, cross(t, x)];

    // Rodrigues rotation of v about unit axis k by angle a.
    function rot(v, k, a) = v * cos(a) + cross(k, v) * sin(a) + k * (k * v) * (1 - cos(a));

    // Carry frame F along the minimal rotation from direction t1 to t2.
    function transport(F, t1, t2) =
        let(c = cross(t1, t2), s = norm(c))
        s < 1e-12 ? F
        : let(k = c / s, a = atan2(s, t1 * t2)) [rot(F[0], k, a), rot(F[1], k, a)];

    // ---- arc slicing ------------------------------------------------------

    // Same piece count rule as OpenSCAD's circles, scaled by the turn angle.
    function arc_frags(r, a) =
        let(f = ($fn > 0) ? max($fn, 3) : ceil(max(min(360 / $fa, r * 2 * PI / $fs), 5)))
        max(1, ceil(f * a / 360));

    function arc_points(P, tin, tout, r, a, N) =
        let(nIn = unit(tout - tin * (tin * tout)), O = P + nIn * r)
        [for (m = [0:N]) let(b = a * m / N) O + r * (-nIn * cos(b) + tin * sin(b))];

    // Element -> straight pieces: [start, end, is_arc, element index, first piece].
    function densify(e, ei) =
        e[0] == "L" ? [[e[1], e[2], false, ei, true]]
        : let(N = slow ? arc_frags(e[4], e[5]) : 1,
              q = arc_points(e[1], e[2], e[3], e[4], e[5], N))
          [for (m = [0:N-1]) [q[m], q[m+1], true, ei, m == 0]];

    // ---- geometry ---------------------------------------------------------

    // One straight piece from A along t, length L, with optional miter cuts.
    module piece(A, t, F, L, g0, aS, mS, aE, mE) {
        sc0 = [1, 1] + (sv - [1, 1]) * (g0 / G);
        sc1 = [1, 1] + (sv - [1, 1]) * ((g0 + L) / G);
        th0 = twist * g0 / G;
        th1 = twist * (g0 + L) / G;
        ratio = [sc1[0] / sc0[0], sc1[1] / sc0[1]];
        M  = frame_mat(F[0], F[1], t, A);
        B  = A + t * L;
        eS = aS > 1e-6 ? profile_r * tan(aS / 2) + 1 : 0;
        eE = aE > 1e-6 ? profile_r * tan(aE / 2) + 1 : 0;
        sz = 4 * (profile_r + L + eS + eE) + 10;

        if (eS > 0 || eE > 0)
            intersection() {
                body(M, L, th1 - th0, ratio, th0, th1, sc0, sc1, eS, eE) children();
                halfspace(eS > 0 ? A : A - t, eS > 0 ? mS : t, sz);
                halfspace(eE > 0 ? B : B + t, eE > 0 ? -mE : -t, sz);
            }
        else
            body(M, L, th1 - th0, ratio, th0, th1, sc0, sc1, 0, 0) children();
    }

    // The extruded piece plus constant-section extensions that get cut to the
    // miter planes. The extensions of two neighbors meet exactly on the bisector.
    module body(M, L, tw, ratio, th0, th1, sc0, sc1, eS, eE) {
        multmatrix(M) {
            linear_extrude(height = L, twist = tw, scale = ratio)
                rotate(-th0) scale(sc0) children();
            if (eS > 0)
                translate([0, 0, -eS]) linear_extrude(height = eS)
                    rotate(-th0) scale(sc0) children();
            if (eE > 0)
                translate([0, 0, L]) linear_extrude(height = eE)
                    rotate(-th1) scale(sc1) children();
        }
    }

    // Exact fillet: rotate_extrude of the child, remapped so it lands in the
    // frame F at the arc's start point P.
    module arc(P, tin, tout, r, a, F) {
        k   = unit(cross(tin, tout));
        nIn = unit(tout - tin * (tin * tout));
        O   = P + nIn * r;
        x = F[0];
        y = F[1];
        multmatrix(frame_mat(-nIn, tin, k, O))
            rotate_extrude(angle = a)
                multmatrix([[-(x * nIn), -(y * nIn), 0, r],
                            [  x * k,      y * k,    0, 0],
                            [  0,          0,        1, 0],
                            [  0,          0,        0, 1]])
                    children();
    }

    // Everything on the +nrm side of the plane through p, out to size sz.
    module halfspace(p, nrm, sz) {
        x = perp(nrm);
        multmatrix(frame_mat(x, cross(nrm, x), nrm, p))
            translate([-sz / 2, -sz / 2, 0]) cube(sz);
    }

    // ---- main -------------------------------------------------------------

    p3 = check_path(path);
    sv = assert(is_num(twist), "unf_path_extrude: twist must be a number")
         assert(is_num(scale) ? scale >= 0
                : (is_list(scale) && len(scale) == 2 && is_num(scale[0]) && is_num(scale[1])
                   && scale[0] >= 0 && scale[1] >= 0),
                "unf_path_extrude: scale must be a number >= 0 or [sx, sy]")
         assert(is_num(profile_r) && profile_r > 0, "unf_path_extrude: profile_r must be > 0")
         is_num(scale) ? [scale, scale] : scale;
    slow = twist != 0 || sv != [1, 1];

    // pts[0] is the implied origin; pts[j] is path[j-1].
    pts = concat([[0, 0, 0]], [for (p = p3) [p[0], p[1], p[2]]]);
    n = len(pts) - 1;
    slen = [for (i = [0:n-1])
        let(l = norm(pts[i+1] - pts[i]))
        assert(l > eps, str("unf_path_extrude: zero-length segment ending at path[", i, "]"))
        l];
    sdir = [for (i = [0:n-1]) (pts[i+1] - pts[i]) / slen[i]];
    rad  = [for (j = [0:n]) (j == 0 || j == n || len(p3[j-1]) < 4) ? 0 : p3[j-1][3]];
    phi  = [for (j = [0:n]) (j == 0 || j == n) ? 0 :
        let(a = angle(sdir[j-1], sdir[j]))
        assert(a < 180 - 1e-6, str("unf_path_extrude: path reverses direction at path[", j-1, "]"))
        a];
    // How far each fillet eats into the segments on either side of its corner.
    sb = [for (j = [0:n]) (rad[j] > 0 && phi[j] > 1e-6) ? rad[j] * tan(phi[j] / 2) : 0];

    // Elements: ["L", start, end] and ["A", start, t_in, t_out, radius, angle].
    elems = [for (i = [0:n-1])
        let(S = pts[i] + sdir[i] * sb[i],
            E = pts[i+1] - sdir[i] * sb[i+1],
            _ = assert(sb[i] + sb[i+1] <= slen[i] + 1e-9,
                str("unf_path_extrude: fillets don't fit on the segment ending at path[", i,
                    "]: they need ", sb[i] + sb[i+1], " but it is ", slen[i], " long")))
        each concat(
            norm(E - S) > eps ? [["L", S, E]] : [],
            (i < n - 1 && sb[i+1] > 0) ? [["A", E, sdir[i], sdir[i+1], rad[i+1], phi[i+1]]] : [])];

    dense  = [for (ei = [0:len(elems)-1]) each densify(elems[ei], ei)];
    ns     = len(dense);
    ld     = [for (d = dense) norm(d[1] - d[0])];
    td     = [for (s = [0:ns-1]) (dense[s][1] - dense[s][0]) / ld[s]];
    gd     = cumsum(ld);
    G      = gd[ns];
    F0     = transport(init_frame(sdir[0]), sdir[0], td[0]);
    frames = [for (s = 0, f = F0; s < ns;
                   f = (s < ns - 1) ? transport(f, td[s], td[s+1]) : f, s = s + 1) f];

    for (s = [0:ns-1]) let(d = dense[s]) {
        if (slow || !d[2]) {
            // A joint is mitered unless it's the tangent point of an exact arc.
            let(aS = (s > 0 && (slow || !dense[s-1][2])) ? angle(td[s-1], td[s]) : 0,
                aE = (s < ns - 1 && (slow || !dense[s+1][2])) ? angle(td[s], td[s+1]) : 0,
                mS = s > 0 ? unit(td[s-1] + td[s]) : td[s],
                mE = s < ns - 1 ? unit(td[s] + td[s+1]) : td[s])
            piece(d[0], td[s], frames[s], ld[s], gd[s], aS, mS, aE, mE) children();
        } else if (d[4]) {
            let(e = elems[d[3]])
            arc(e[1], e[2], e[3], e[4], e[5], transport(frames[s], td[s], e[2])) children();
        }
    }
}

// Section: Licensing
//   UnfyOpenSCADLib is free software: you can redistribute it and/or modify it under the terms of the
//   GNU General Public License as published by the Free Software Foundation, either version 3 of
//   the License, or (at your option) any later version.
//   .
//   UnfyOpenSCADLib is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
//   without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
//   See the GNU General Public License for more details.
//   .
//   You should have received a copy of the GNU General Public License along with UnfyOpenSCADLib.
//   If not, see <https://www.gnu.org/licenses/>.
//   
