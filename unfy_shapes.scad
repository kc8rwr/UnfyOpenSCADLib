// LibFile: unfy_shapes.scad
//   UnfyOpenSCADLib Copyright Leif Burrow 2026
//   kc8rwr@unfy.us
//   unforgettability.net
//   .
//   This file is part of UnfyOpenSCADLib.
//   .
//   unfy_shapes contains a collection of modules for generating geometric shapes with an emphasis on rounded corners and edges.

use <unfy_fasteners.scad>
use <unfy_math.scad>

test_shape="unf_roundedCuboid"; //["unf_roundedRectangle", "unf_roundedCuboid", "unf_roundedCylinder", "oval", "star", "bezier_wedge_2d", "bezier_wedge_3d", "bezier_frustrum"]

$fn = $preview ? 36 : 360;
$over = 0.1;

/* [ unf_roundedRectangle ] */
rectangle_size=[50, 25];
rectangle_corners=[0, 1, 2, 3];

/* [ unf_RoundedCuboid ] */
cube_size=[20, 10, 5];
cube_corners=[1, 1, 1, 1];
cube_edge_r=[1, 2, 1, 2, 1, 2, 1, 2];
cube_bend_r=0; //[-100:0.5:100]
cube_bend_plane="xy"; //["xy":"xy - x bends into a rainbow", "yz":"yz - y arches like a bridge", "xz":"xz - x arches like a bridge", "custom":"custom - use the vectors below"]
cube_bend_along=[1, 0, 0];
cube_bend_up=[0, 1, 0];

/* [ unf_roundedCylinder ] */
cylinder_r1 = 10;
cylinder_r2 = 5;
cylinder_edge_r = 1;
cylinder_h = 15;

/* [ Oval ] */
oval_xdiameter = 20;
oval_ydiameter = 10;

/* [ Star ] */
star_od = 20;
star_id = 10;
star_p = 5; //[2:1:24]

/* [ Bezier Wedge 2d] */
bez2d_size=[5, 15];
bez2d_use_custom_v = false;
bez2d_custom_v = [1.25, 3.75];

/* [ Bezier Wedge 3d ] */
bez3d_size=[5, 15, 15];
bez3d_rounded_edges = [1, 2];

/* [ Bezier Frustrum ] */
bezfr_base_dx = 8; //[1:10]
bezfr_base_dy = 6; //[1:10]
bezfr_base_edge_r = 0; //[0:0.01:4]
bezfr_end_dx = 3; //[1:10]
bezfr_end_dy = 5; //[1:10]
bezfr_end_edge_r = 0; //[0:0.01:4]
bezfr_control_height_pct = 50; //[0:100]
bezfr_control_pinch_pct = 50; //[0:200]
bezfr_length = 15; //[1:30]

// One ring of points around a rounded rectangle slice, s = [x_offset, y_offset, x_size, y_size, z, corners], counterclockwise viewed from above starting at the [0,0] corner.
// arcs = point count for each corner, 1 for a sharp corner, sides = segment count for [front & back, right & left]
// Corners too large to fit along their sides are reduced to fit, where both corners on a side are too large they shrink in proportion.
// Every ring made with the same arcs and sides has the same number of points so rings can be stitched together.
function _unf_rounded_ring(s, arcs, sides) = let(
    x0 = s[0], y0 = s[1], x1 = s[0] + s[2], y1 = s[1] + s[3], z = s[4],
    eps = $over / 10, //keeps every point distinct - corners never quite reach 0 or meet across a side
    side_len = [s[2], s[3], s[2], s[3]], //front, right, back, left - side k runs from corner k to corner k+1
    wanted = [ for (k = [0 : 3]) 1 == arcs[k] ? 0 : min(s[5][k], s[2] - eps, s[3] - eps) ],
    // where a side's two corners don't fit along it both shrink in proportion, each corner takes the tighter of its two sides
    fit = [ for (k = [0 : 3]) let(both = wanted[k] + wanted[(k + 1) % 4]) both > side_len[k] - eps ? (side_len[k] - eps) / both : 1 ],
    c = [ for (k = [0 : 3]) 1 == arcs[k] ? 0 : max(eps, wanted[k] * min(fit[k], fit[(k + 3) % 4])) ],
    centers = [[x0 + c[0], y0 + c[0]], [x1 - c[1], y0 + c[1]], [x1 - c[2], y1 - c[2]], [x0 + c[3], y1 - c[3]]],
    arc = function(k) [ for (j = [0 : arcs[k] - 1]) let(angle = (180 + (90 * k)) + (1 == arcs[k] ? 0 : 90 * j / (arcs[k] - 1)))
			  [centers[k].x + (c[k] * cos(angle)), centers[k].y + (c[k] * sin(angle)), z] ],
    side = function(p, q, count) [ for (j = [1 : 1 : count - 1]) p + ((q - p) * j / count) ],
    arc_points = [ for (k = [0 : 3]) arc(k) ])
  [ for (k = [0 : 3]) each concat(arc_points[k], side(arc_points[k][arcs[k] - 1], arc_points[(k + 1) % 4][0], sides[k % 2])) ];

// Point count for each corner arc of a rounded rectangle, 1 for a sharp corner, at least min_points for a rounded one
function _unf_corner_arcs(corners, min_points=2) = [ for (c = corners) 0 == c ? 1 : max(2, min_points, unf_effective_fn(radius=c, angle=90) + 1) ];

// Module: unf_roundedRectangle
// Usage:
//   unf_roundedRectangle(<args>);
// Description:
//   Creates a 2d rectangle with rounded corners.
//   .
//   Corners too large to fit along their sides are reduced to fit, where both corners on a side are too large they shrink in proportion.
// Arguments:
//   ---
//   size = may be a 2d vector [x, y] or a single number creating a square equivalent to [x, x] ([18, 5])
//   corners = a vector containing the radiuses of each rounded corner (0 for no-rounding) [(0, 0), (x, 0), (x, y), (0, y)] or a single number to make all corners the same ([1, 1, 1, 1])
// Figure(Spin;VPD=100;NoAxes): defaults
//   $over = 0.1;
//   $fn = 36;
//   use <unfy_shapes.scad>;
//   unf_roundedRectangle();
// Figure(Spin;VPD=150;NoAxes): custom
//   $over = 0.1;
//   $fn = 36;
//   use <unfy_shapes.scad>;
//   unf_roundedRectangle(size=[40, 20], corners=[0, 4, 8, 12]);
module unf_roundedRectangle(size=[18, 5], corners=[1, 1, 1, 1]){
  let (size = is_num(size) ? [size, size] : size,
       corners = is_num(corners) ? [corners, corners, corners, corners] : corners){

    if (!is_list(size) || 2 != len(size) || 0 >=size.x || 0 >= size.y){
      assert(false, "size must be a positive number or a vector of 2 positive numbers");
    }
    
    if (!is_list(corners) || 4 != len(corners) || 0 > corners[0] || 0 > corners[1] || 0 > corners[2] || 0 > corners[3]){
      assert(false, "corners must be zero, a positive number or a vector of 4 such numbers");
    }

    polygon([ for (p = _unf_rounded_ring([0, 0, size.x, size.y, 0, corners], _unf_corner_arcs(corners), [1, 1])) [p.x, p.y] ]);
  }
}

// Module: unf_roundedCuboid
// Usage:
//   unf_roundedCuboid(<args>);
// Description:
//   Creates a 3d cuboid with rounded corners.
//   .
//   Where rounded edges meet a rounded corner the corner radius shrinks along with the edge so the two blend. Opposite edge radiuses together may not exceed that side's length, and the largest top edge radius plus the largest bottom edge radius may not exceed size.z.
//   .
//   Optionally the cuboid may be bent around a cylinder of radius bend_r whose axis passes through the origin perpendicular to bend_plane. The cuboid's distance along bend_plane[0] becomes distance around the cylinder (0 at the top, positive going clockwise when viewed down the axis), its distance along bend_plane[1] becomes extra distance outward from the cylinder's surface, and its distance along the axis is unchanged. With the default plane a cuboid lying along x bends into a rainbow over the origin, with [[0, 1, 0], [0, 0, 1]] a cuboid lying along y arches over the x axis like a bridge. A negative bend_r bends the other way, wrapping the cuboid around the inside of the cylinder.
//   .
//   The cuboid is built as a single polyhedron. Corners too large to fit along their sides are reduced to fit, where both corners on a side are too large they shrink in proportion.
// Arguments:
//   ---
//   size = may be a 3d vector [x, y, z] or a single number creating a cube equivalent to [x, x, x] ([20, 10, 5])
//   corners = a vector containing the radiuses of each rounded corner ordered [[0,0], [x,0], [x,y], [0,y]] or a single number making all corners the same ([1, 1, 1, 1])
//   edge_r = an 8-dimensional vector containing the radiuses of each rounded edge [FT, RT, BT, LT, FB, RB, BB, LB], or 4-dim [F, R, B, L], 2-dim [T, B], or single number ([1, 2, 1, 2, 1, 2, 1, 2])
//   bend_r = radius of the cylinder to bend around, 0 for no bend (0)
//   bend_plane = 2 vectors [along, up] defining the plane the cuboid bends in, along is wrapped around the cylinder, up points away from it and need not be exactly perpendicular to along ([[1, 0, 0], [0, 1, 0]])
// Figure(Spin;VPD=100;NoAxes): defaults
//   $over = 0.1;
//   $fn = 36;
//   use <unfy_shapes.scad>;
//   unf_roundedCuboid();
// Figure(Spin;VPD=150;NoAxes): custom
//   $over = 0.1;
//   $fn = 36;
//   use <unfy_shapes.scad>;
//   unf_roundedCuboid(size=[30, 20, 10], corners=2, edge_r=3);
// Figure(Spin;VPD=200;NoAxes): bent into a rainbow
//   $over = 0.1;
//   $fn = 36;
//   use <unfy_shapes.scad>;
//   unf_roundedCuboid(size=[60, 8, 5], corners=2, edge_r=1, bend_r=25);
// Figure(Spin;VPD=200;NoAxes): bent into a bridge
//   $over = 0.1;
//   $fn = 36;
//   use <unfy_shapes.scad>;
//   unf_roundedCuboid(size=[30, 60, 3], corners=2, edge_r=1, bend_r=25, bend_plane=[[0, 1, 0], [0, 0, 1]]);
module unf_roundedCuboid(size=[20, 10, 5], corners=[1, 1, 1, 1], edge_r=[1, 2, 1, 2, 1, 2, 1, 2], bend_r=0, bend_plane=[[1, 0, 0], [0, 1, 0]]){
  // Slices of one rounded band (top or bottom), from where it meets the middle (z=0) out to the flat face (z=r_max).
  // r = edge radiuses [F, R, B, L], c = corner radiuses, min_slices = fewest slices to use
  // Each slice is [x_offset, y_offset, x_size, y_size, z, corners], slices are kept at least 2*$over apart
  function calc(base_x, base_y, r, c, min_slices=1) = let(r_max = max(r),
							   slices = max(min_slices, 1, min(unf_effective_fn(radius=r_max, angle=90), floor(r_max/(2*$over)))))
    [ for (i = [0 : slices])
	let(z = r_max * i / slices, //integer index so the last slice lands exactly on r_max
	    d = [ for (j = [0 : 3]) let(start = r_max - r[j]) z <= start ? 0 : r[j] - sqrt(max(0, pow(r[j], 2) - pow(z - start, 2))) ],
	    x_size = base_x - (d[1] + d[3]),
	    y_size = base_y - (d[0] + d[2]))
	[ d[3] - (max(0, $over - x_size) / 2), //fully rounded sides shrink to a $over wide centered sliver rather than vanishing
	  d[0] - (max(0, $over - y_size) / 2),
	  max($over, x_size),
	  max($over, y_size),
	  z,
	  [ max(0, c[0] - min(d[0], d[3])), //shrink corners with the edges so the two roundings blend
	    max(0, c[1] - min(d[0], d[1])),
	    max(0, c[2] - min(d[2], d[1])),
	    max(0, c[3] - min(d[2], d[3])) ] ] ];

  function with_z(s, z) = [s[0], s[1], s[2], s[3], z, s[5]];

  // Ring shrunk by scale t toward point center, for filling the flat top and bottom faces
  function scale_ring(points, center, t) = [ for (p = points) center + ((p - center) * t) ];

  // [along, out, axis] unit vectors for the bend, out is straightened to be perpendicular to along
  function bend_frame(plane) = let(u = plane[0] / norm(plane[0]),
				   n = cross(plane[0], plane[1]) / norm(cross(plane[0], plane[1])))
    [u, cross(n, u), n];

  function bend_point(p, frame, r) = let(angle = ((p * frame[0]) / r) * (180 / PI))
    ((r + (p * frame[1])) * ((sin(angle) * frame[0]) + (cos(angle) * frame[1]))) + ((p * frame[2]) * frame[2]);

  let (size = is_num(size) ? [size, size, size] : size,
       corners = is_num(corners) ? [corners, corners, corners, corners] : corners,

       edge_r = is_num(edge_r) ? [edge_r, edge_r, edge_r, edge_r, edge_r, edge_r, edge_r, edge_r] : (
	 (!is_list(edge_r)) ? edge_r : (
	   8==len(edge_r) ? edge_r : (
	     4==len(edge_r) ? [edge_r[0], edge_r[1], edge_r[2], edge_r[3], edge_r[0], edge_r[1], edge_r[2], edge_r[3]] : (
	       2==len(edge_r) ? [edge_r[0], edge_r[0], edge_r[0], edge_r[0], edge_r[1], edge_r[1], edge_r[1], edge_r[1]] : edge_r
	     )
	   )
	 )
       )
  ){
    
    if (!is_list(size) || 3 != len(size) || 0 >=size.x || 0 >= size.y || 0 >= size.z){
      assert(false, "size must be a positive number or a vector of 3 positive numbers");
    }
    
    if (!is_list(corners) || 4 != len(corners) || 0 > corners[0] || 0 > corners[1] || 0 > corners[2] || 0 > corners[3]){
      assert(false, "corners must be zero, a positive number or a vector of 4 such numbers");
    }

    if (!is_list(edge_r) || 8 != len(edge_r) || 0 > edge_r[0] || 0 > edge_r[1] || 0 > edge_r[2] || 0 > edge_r[3] || 0 > edge_r[4] || 0 > edge_r[5] || 0 > edge_r[6] || 0 > edge_r[7]){
      assert(false, "edge_r must be zero, a positive number or a vector of 2, 4 or 8 such numbers");
    }

    if (size.y < edge_r[0] + edge_r[2] || size.y < edge_r[4] + edge_r[6]){
      assert(false, str("front and back edge_r together must not exceed size.y (", size.y, ")"));
    }

    if (size.x < edge_r[1] + edge_r[3] || size.x < edge_r[5] + edge_r[7]){
      assert(false, str("right and left edge_r together must not exceed size.x (", size.x, ")"));
    }

    if (size.z < max(edge_r[0], edge_r[1], edge_r[2], edge_r[3]) + max(edge_r[4], edge_r[5], edge_r[6], edge_r[7])){
      assert(false, str("largest top edge_r plus largest bottom edge_r must not exceed size.z (", size.z, ")"));
    }

    if (!is_num(bend_r)){
      assert(false, "bend_r must be a number");
    }

    let (top_r = [edge_r[0], edge_r[1], edge_r[2], edge_r[3]],
	 bottom_r = [edge_r[4], edge_r[5], edge_r[6], edge_r[7]],
	 top_height = max(top_r),
	 bottom_height = max(bottom_r),
	 middle_height = size.z - (top_height + bottom_height),
	 bent = 0 != bend_r){

      if (bent && (!is_list(bend_plane) || 2 != len(bend_plane) || !is_list(bend_plane[0]) || 3 != len(bend_plane[0]) || !is_list(bend_plane[1]) || 3 != len(bend_plane[1])
		   || 0 == norm(bend_plane[0]) || 0 == norm(cross(bend_plane[0], bend_plane[1])))){
	assert(false, "bend_plane must be 2 non-zero, non-parallel 3d vectors [along, up]");
      }

      let (frame = bent ? bend_frame(bend_plane) : [[1, 0, 0], [0, 1, 0], [0, 0, 1]],
	   u = frame[0],
	   box = [ for (x = [0, size.x], y = [0, size.y], z = [0, size.z]) [x, y, z] ],
	   a_min = min([ for (p = box) p * frame[0] ]),
	   a_max = max([ for (p = box) p * frame[0] ]),
	   b_min = min([ for (p = box) p * frame[1] ]),
	   b_max = max([ for (p = box) p * frame[1] ]),
	   span = bent ? ((a_max - a_min) / abs(bend_r)) * (180 / PI) : 0, //degrees of the cylinder covered
	   outer_r = max(abs(bend_r + b_min), abs(bend_r + b_max))){

	if (bent && (0 >= (bend_r + b_min) / bend_r || 0 >= (bend_r + b_max) / bend_r)){
	  assert(false, str("bend_r (", bend_r, ") is too small, the cuboid would pass through the bend's axis"));
	}

	if (360 < span){
	  assert(false, str("bend_r (", bend_r, ") is too small, the cuboid would wrap ", span, " degrees around the cylinder"));
	}

	// The bend is linear across and out of the plane so only distance along it needs dividing, into steps no longer than step.
	// Unbent, flat faces need no dividing at all.
	let (step = bent ? (a_max - a_min) / unf_effective_fn(radius=outer_r, angle=span) : 0,
	     divide = function(length) bent ? max(1, ceil(length / step)) : 1,
	     sides = [divide(size.x * abs(u.x)), divide(size.y * abs(u.y))],
	     arcs = [ for (k = [0 : 3]) _unf_corner_arcs(corners, divide(corners[k] * (PI / 2) * norm([u.x, u.y])) + 1)[k] ],
	     top_calcs = 0 < top_height ? calc(size.x, size.y, top_r, corners, divide(top_height * abs(u.z))) : [],
	     bottom_calcs = 0 < bottom_height ? calc(size.x, size.y, bottom_r, corners, divide(bottom_height * abs(u.z))) : [],
	     middle_steps = divide(middle_height * abs(u.z)),
	     full = [0, 0, size.x, size.y, 0, corners],
	     // side wall slices from bottom face to top face, each band's slice where it meets the middle is left to the middle
	     slices = concat(0 < bottom_height ? [ for (i = [len(bottom_calcs) - 1 : -1 : 1]) with_z(bottom_calcs[i], bottom_height - bottom_calcs[i][4]) ] : [],
			     [ for (j = [0 : (0 < middle_height ? middle_steps : 0)]) with_z(full, bottom_height + (middle_height * j / middle_steps)) ],
			     0 < top_height ? [ for (i = [1 : len(top_calcs) - 1]) with_z(top_calcs[i], bottom_height + middle_height + top_calcs[i][4]) ] : []),
	     walls = [ for (s = slices) _unf_rounded_ring(s, arcs, sides) ],
	     bottom = slices[0],
	     top = slices[len(slices) - 1],
	     bottom_center = [bottom[0] + (bottom[2] / 2), bottom[1] + (bottom[3] / 2), bottom[4]],
	     top_center = [top[0] + (top[2] / 2), top[1] + (top[3] / 2), top[4]],
	     cap_steps = divide(((abs(u.x) * size.x) + (abs(u.y) * size.y)) / 2),
	     // every ring from the middle of the bottom face, out, up the sides and in to the middle of the top face
	     rings = concat([ for (j = [1 : 1 : cap_steps - 1]) scale_ring(walls[0], bottom_center, j / cap_steps) ],
			    walls,
			    [ for (j = [cap_steps - 1 : -1 : 1]) scale_ring(walls[len(walls) - 1], top_center, j / cap_steps) ]),
	     ring_count = len(rings),
	     ring_len = len(rings[0]),
	     points = concat([bottom_center], [ for (r = rings) each r ], [top_center]),
	     index = function(i, k) 1 + (i * ring_len) + (k % ring_len),
	     faces = concat([ for (k = [0 : ring_len - 1]) [0, index(0, k), index(0, k + 1)] ],
			    [ for (i = [0 : ring_count - 2], k = [0 : ring_len - 1]) each [[index(i, k), index(i + 1, k), index(i + 1, k + 1)],
											  [index(i, k), index(i + 1, k + 1), index(i, k + 1)]] ],
			    [ for (k = [0 : ring_len - 1]) [index(ring_count - 1, k), len(points) - 1, index(ring_count - 1, k + 1)] ])){
	  polyhedron(points=bent ? [ for (p = points) bend_point(p, frame, bend_r) ] : points, faces=faces, convexity=bent ? 10 : 2);
	}
      }
    }
  }
}

// Stitches rings of points into a single closed polyhedron. Every ring must have the same number of points, run
// counterclockwise viewed from the last ring's end, and the rings must run from the first end to the last.
// The end faces are fanned from a point at the middle of each end ring, or with fan=true from each ring's first
// point, for ends that aren't convex but whose whole edge can be seen from their first point.
module _unf_loft(rings, fan=false, convexity=2){
  let (ring_count = len(rings),
       ring_len = len(rings[0]),
       mean = function(r) ([ for (p = r) 1 ] * r) / len(r),
       first = fan ? 0 : 1,
       points = concat(fan ? [] : [mean(rings[0])], [ for (r = rings) each r ], fan ? [] : [mean(rings[ring_count - 1])]),
       index = function(i, k) first + (i * ring_len) + (k % ring_len),
       last = ring_count - 1,
       faces = concat(fan ? [ for (k = [1 : ring_len - 2]) [index(0, 0), index(0, k), index(0, k + 1)] ]
			  : [ for (k = [0 : ring_len - 1]) [0, index(0, k), index(0, k + 1)] ],
		      [ for (i = [0 : ring_count - 2], k = [0 : ring_len - 1]) each [[index(i, k), index(i + 1, k), index(i + 1, k + 1)],
										    [index(i, k), index(i + 1, k + 1), index(i, k + 1)]] ],
		      fan ? [ for (k = [1 : ring_len - 2]) [index(last, k), index(last, 0), index(last, k + 1)] ]
			  : [ for (k = [0 : ring_len - 1]) [index(last, k), len(points) - 1, index(last, k + 1)] ])){
    polyhedron(points=points, faces=faces, convexity=convexity);
  }
}

// Module: unf_roundedCylinder
// Usage:
//   unf_roundedCylinder(<args>);
// Description:
//   Creates a cylinder with rounded top and/or bottom edges.
// Arguments:
//   ---
//   r = radius of cylinder (0)
//   d = diameter of cylinder (0)
//   r1 = bottom radius (0)
//   r2 = top radius (0)
//   d1 = bottom diameter (0)
//   d2 = top diameter (0)
//   h = height of cylinder (1)
//   edge_r = general edge radius for both ends (0)
//   edge1_r = bottom edge radius (0)
//   edge2_r = top edge radius (0)
// Figure(Spin;VPD=100;NoAxes): defaults
//   $over = 0.1;
//   $fn = 36;
//   use <unfy_shapes.scad>;
//   unf_roundedCylinder(r=10, h=20, edge_r=2);
// Figure(Spin;VPD=150;NoAxes): custom
//   $over = 0.1;
//   $fn = 36;
//   use <unfy_shapes.scad>;
//   unf_roundedCylinder(r1=15, r2=5, h=25, edge1_r=3, edge2_r=1);
module unf_roundedCylinder(r=0, d=0, r1=0, r2=0, d1=0, d2=0, h=1, edge_r=0, edge1_r=0, edge2_r=0) {
	// number of whole steps across a rounded edge of radius r, each at least $over thick
	function steps(r) = max(1, min(unf_effective_fn(radius=r, angle=90), floor(r/$over)));
	// how far out from the inset (base_r - e) the curve of an edge of radius e reaches at distance t from the flat face
	function reach(e, t) = sqrt(max(0, pow(e, 2) - pow(e - t, 2)));

    let(
        // 1. Resolve primary radii/diameters
        has_individual = (r1 > 0 || r2 > 0 || d1 > 0 || d2 > 0),
        
        r1 = has_individual ? (r1 > 0 ? r1 : d1 / 2) : (r > 0 ? r : (d > 0 ? d / 2 : 1)),
        r2 = has_individual ? (r2 > 0 ? r2 : d2 / 2) : (r > 0 ? r : (d > 0 ? d / 2 : 1)),
        
        d1 = r1 * 2,
        d2 = r2 * 2,
        
        r = (r1 == r2) ? r1 : 0,
        d = r * 2,

        // 2. Resolve edge radii with constraints
        has_edge_individual = (edge1_r > 0 || edge2_r > 0),
        
        raw_edge1 = has_edge_individual ? (edge1_r > 0 ? edge1_r : edge_r) : edge_r,
        raw_edge2 = has_edge_individual ? (edge2_r > 0 ? edge2_r : edge_r) : edge_r,

        edge1_r = (raw_edge1 > 0) ? min(raw_edge1, h / 2, r1) : 0,
        edge2_r = (raw_edge2 > 0) ? min(raw_edge2, h / 2, r2) : 0,
        
        edge_r = (edge1_r > 0) ? edge1_r : edge2_r,

		  base_r = function(z) r1 + ((r2-r1) * (z / h))
    ) {
		 // The side profile, from the bottom face out, up the side and in across the top face, spun around z.
		 // Rounded edges are points on the curve, the middle is the straight (or tapered) side between them.
		 let (n1 = 0 < edge1_r ? steps(edge1_r) : 0,
		      n2 = 0 < edge2_r ? steps(edge2_r) : 0,
		      bottom = 0 < edge1_r ? [ for (i = [0 : n1]) let(z = edge1_r * i / n1) [max(0, base_r(z) - edge1_r + reach(edge1_r, z)), z] ] : [[r1, 0]],
		      // where there's no straight side the top edge starts where the bottom one ends, don't repeat that point
		      top_from = (0 < edge1_r && 0 < edge2_r && edge1_r + edge2_r >= h) ? 1 : 0,
		      top = 0 < edge2_r ? [ for (i = [top_from : n2]) let(z = h - edge2_r + (edge2_r * i / n2)) [max(0, base_r(z) - edge2_r + reach(edge2_r, h - z)), z] ] : [[r2, h]],
		      side = concat(bottom, top)){
		   rotate_extrude(){
		     polygon(concat(0 < side[0].x ? [[0, 0]] : [], side, 0 < side[len(side) - 1].x ? [[0, h]] : []));
		   }
		 }
    }
}


// Module: unf_oval
// Usage:
//   unf_oval(<args>);
// Description:
//   Draw an oval by size.
// Arguments:
//   ---
//   size = 2d vector [x, y] for oval dimensions ([8, 4])
// Figure(Spin;VPD=100;NoAxes): defaults
//   $over = 0.1;
//   $fn = 36;
//   use <unfy_shapes.scad>;
//   unf_oval();
// Figure(Spin;VPD=150;NoAxes): custom
//   $over = 0.1;
//   $fn = 36;
//   use <unfy_shapes.scad>;
//   unf_oval(size=[30, 10]);
module unf_oval(size = [8, 4]){
	if (size.x == size.y){
		circle(d=size.x);
	} else {
		resize(size){
			circle(1);
		}
	}
}

// Module: unf_star
// Usage:
//   unf_star(<args>);
// Description:
//   Draws a 2d star centered on the origin with its first point straight up along the y axis. The points touch a circle of diameter od and the dips between them touch a circle of diameter id.
// Arguments:
//   ---
//   od = outer diameter, of the circle around the points (20)
//   id = inner diameter, of the circle around the dips between the points, must not exceed od (10)
//   p = number of points, a whole number of at least 2 (5)
// Figure(Spin;VPD=100;NoAxes): defaults
//   $over = 0.1;
//   $fn = 36;
//   use <unfy_shapes.scad>;
//   unf_star();
// Figure(Spin;VPD=100;NoAxes): custom
//   $over = 0.1;
//   $fn = 36;
//   use <unfy_shapes.scad>;
//   unf_star(od=30, id=22, p=8);
module unf_star(od=20, id=10, p=5){
  if (!is_num(od) || 0 >= od){
    assert(false, "od must be a positive number");
  }

  if (!is_num(id) || 0 >= id || od < id){
    assert(false, str("id must be a positive number no larger than od (", od, ")"));
  }

  if (!is_num(p) || 2 > p || p != floor(p)){
    assert(false, "p must be a whole number of at least 2");
  }

  //alternating point and dip, counterclockwise from the point at the top
  polygon([ for (i = [0 : (2 * p) - 1]) let(angle = 90 + (180 * i / p), r = (0 == i % 2) ? od / 2 : id / 2)
	    [r * cos(angle), r * sin(angle)] ]);
}

// Module: unf_bezierWedge2d
// Usage:
//   unf_bezierWedge2d(<args>);
// Description:
//   Sort of a right-triangle but the hypotenuse is a bezier curve pulled in rather than a straight line. Good for inside-corners.
// Arguments:
//   ---
//   size = a 2d vector [x, y] or a single number ([5, 15])
//   v = a vector to affect the shape of the bezier curve (false)
// Figure(Spin;VPD=100;NoAxes): defaults
//   $over = 0.1;
//   $fn = 36;
//   use <unfy_shapes.scad>;
//   unf_bezierWedge2d();
// Figure(Spin;VPD=150;NoAxes): custom
//   $over = 0.1;
//   $fn = 36;
//   use <unfy_shapes.scad>;
//   unf_bezierWedge2d(size=[10, 20], v=[2, 8]);
module unf_bezierWedge2d(size=[5, 15], v=false){
  let (size = is_num(size) ? [size, size] : size,
       v = is_list(v) ? v : (is_list(size) && 2 <= len(size) ? [size.x/4, size.y/4] : false)){

    if (!is_list(size) || 2 != len(size) || 0 >=size.x || 0 >= size.y){
      assert(false, "size must be a positive number or a vector of 2 positive numbers");
    }
    
    if (!is_list(v) || 2 != len(v)){
      assert(false, "v must be a number or a vector of 2 numbers");
    }

    
    h = concat([[0, size.y]], [v], [[size.x, 0]]);
    bez = unfy_bezier(h);
    polygon(concat([[0, 0]], bez, [[0, 0]]));
  }
}

// Module: unf_bezierWedge3d
// Usage:
//   unf_bezierWedge3d(<args>);
// Description:
//   A 3-dimensional wedge shape, fits inside a right-angle with a bezier curve along the hypotenuse.
// Arguments:
//   ---
//   size = a 3d vector [x, y, z] or a single number ([5, 15, 15])
//   rounded_edges = vector or number for edge rounding ([1, 1])
// Figure(Spin;VPD=100;NoAxes): defaults
//   $over = 0.1;
//   $fn = 36;
//   use <unfy_shapes.scad>;
//   unf_bezierWedge3d();
// Figure(Spin;VPD=150;NoAxes): custom
//   $over = 0.1;
//   $fn = 36;
//   use <unfy_shapes.scad>;
//   unf_bezierWedge3d(size=[10, 20, 20], rounded_edges=[2, 3]);
module unf_bezierWedge3d(size=[5, 15, 15], rounded_edges=[1, 1]){
	// number of whole steps across a rounded edge of radius r, each at least $over thick
	function steps(r) = max(1, min(unf_effective_fn(radius=r, angle=90), floor(r/$over)));
	// how far a rounded edge of radius r is inset at distance t from where it meets the middle
	function inset(r, t) = r - sqrt(max(0, pow(r, 2) - pow(t, 2)));

	let(size = is_num(size) ? [size, size, size] : size,
		 rounded_edges = is_num(rounded_edges) ? [rounded_edges, rounded_edges] : rounded_edges){
    
		if (!is_list(size) || 3 != len(size) || 0 >=size.x || 0 >= size.y || 0 >= size.z){
			assert(false, "size must be a positive number or a vector of 3 positive numbers");
		}
    
		if (!is_list(rounded_edges) || 2 != len(rounded_edges) || 0 > rounded_edges.x || 0 > rounded_edges.y){
			assert(false, str("rounded_edges, '", rounded_edges, "' must be zero, a positive number or a vector of 2 such numbers"));
		}

		if (min(size.x, size.y) < max(rounded_edges.x, rounded_edges.y)){
			assert(false, str("rounded_edges, '", rounded_edges, "' may not exceed size.x or size.y"));
		}

		if (size.z < rounded_edges.x + rounded_edges.y){
			assert(false, str("rounded_edges, '", rounded_edges, "' together may not exceed size.z (", size.z, ")"));
		}

		let(top_r = rounded_edges.x,
			 bottom_r = rounded_edges.y,
			 middle_height = size.z - (top_r + bottom_r),
			 middle_top = bottom_r + middle_height,
			 // unf_bezierWedge2d's outline for a 1x1 wedge, it only ever scales, counterclockwise from the right angle's corner
			 count = unf_effective_fn(radius=norm([size.x, size.y]), angle=90),
			 unit = concat([[0, 0]], [ for (j = [count : -1 : 0]) let(t = j / count)
				 [(2 * t * (1 - t) / 4) + pow(t, 2), pow(1 - t, 2) + (2 * t * (1 - t) / 4)] ]),
			 // [z, inset] of every ring from the bottom face to the top face
			 nb = 0 < bottom_r ? steps(bottom_r) : 0,
			 nt = 0 < top_r ? steps(top_r) : 0,
			 levels = concat(0 < bottom_r ? [ for (i = [0 : nb]) [bottom_r * i / nb, inset(bottom_r, bottom_r * (nb - i) / nb)] ] : [[0, 0]],
					 0 < middle_height ? [[middle_top, 0]] : [],
					 0 < top_r ? [ for (i = [1 : nt]) [middle_top + (top_r * i / nt), inset(top_r, top_r * i / nt)] ] : []),
			 rings = [ for (l = levels) let(sx = max($over, size.x - l[1]), sy = max($over, size.y - l[1]))
				 [ for (p = unit) [p.x * sx, p.y * sy, l[0]] ] ]){

			translate([0, size.z, 0]){
				rotate([90, 0, 0]){
					_unf_loft(rings, fan=true);
				}
			}
		}
	}
}

// Module: unf_bezier_frustrum
// Usage:
//   unf_bezier_frustrum(<args>);
// Description:
//   Creates a 3D frustum shaped object transitioning via bezier curves with optional edge rounding.
// Arguments:
//   ---
//   base_d = uniform base diameter (0)
//   base_dx = base x dimension (80)
//   base_dy = base y dimension (60)
//   base_edge_r = base edge rounding radius (0)
//   end_d = uniform end diameter (0)
//   end_dx = end x dimension (20)
//   end_dy = end y dimension (40)
//   end_edge_r = end edge rounding radius (0)
//   control_height_pct = height percentage for bezier control point (50)
//   control_pinch_pct = pinch percentage for bezier control point (50)
//   length = total length along z axis (300)
// Figure(Spin;VPD=150;NoAxes): defaults
//   $over = 0.1;
//   $fn = 36;
//   use <unfy_shapes.scad>;
//   unf_bezier_frustrum(base_dx=40, base_dy=30, end_dx=10, end_dy=20, length=100);
module unf_bezier_frustrum(
	base_d = 0,
	base_dx = 80,
	base_dy = 60,
	base_edge_r = 0,
	end_d = 0,
	end_dx = 20,
	end_dy = 40,
	end_edge_r = 0,
	control_height_pct = 50,
	control_pinch_pct = 50,
	length = 300,
) {
	let (
		base_dx = 0 < base_d ? base_d : base_dx,
		base_dy = 0 < base_d ? base_d : base_dy,
		end_dx = 0 < end_d ? end_d : end_dx,
		end_dy = 0 < end_d ? end_d : end_dy,
		base_edge_r = min(base_edge_r, (base_dx/2), (base_dy/2), (length/2)),
		end_edge_r = min(end_edge_r, (end_dx/2), (end_dy/2), (length/2))
	){
		assert(0 < base_dx, "Either base_d or base_dx must be greater than zero");
		assert(0 < base_dy, "Either base_d or base_dy must be greater than zero");
		assert(0 <= base_edge_r, "Base_edge_r must not be below zero");
		assert(0 < end_dx, "Either end_d or end_dx must be greater than zero");
		assert(0 < end_dy, "Either end_d or end_dy must be greater than zero");
		assert(0 <= end_edge_r, "End_edge_r must not be below zero");
		assert(0 < length, "Length must be greater than zero");

		control_z = length * control_height_pct / 100;
		control_x = (base_dx + ((end_dx-base_dx)*control_height_pct/100)) * control_pinch_pct / 100;
		control_y = (base_dy + ((end_dy-base_dy)*control_height_pct/100)) * control_pinch_pct / 100;
		bez_x = unfy_bezier([[base_dx, 0], [control_x, control_z], [end_dx, length]]);
		bez_y = unfy_bezier([[0, base_dy], [control_z, control_y], [length, end_dy]]);

		// rings at every point of the curve, plus enough within each rounded edge to follow its curve
		steps = function(r) max(1, min(unf_effective_fn(radius=r, angle=90), floor(r/$over)));
		nb = 0 < base_edge_r ? steps(base_edge_r) : 0;
		ne = 0 < end_edge_r ? steps(end_edge_r) : 0;
		zs = concat(0 < base_edge_r ? [ for (i = [0 : nb]) base_edge_r * i / nb ] : [0],
			    [ for (p = bez_x) if (p.y > base_edge_r && p.y < length - end_edge_r) p.y ],
			    0 < end_edge_r ? [ for (i = [((base_edge_r + end_edge_r >= length) ? 1 : 0) : ne]) length - end_edge_r + (end_edge_r * i / ne) ] : [length]);
		bez_xz = [ for (p = bez_x) [p.y, p.x] ];
		lip = function(z) (z < base_edge_r) ? base_edge_r - sqrt(max(0, pow(base_edge_r, 2) - pow(base_edge_r - z, 2))) :
				   (z > length - end_edge_r) ? end_edge_r - sqrt(max(0, pow(end_edge_r, 2) - pow(z - (length - end_edge_r), 2))) : 0;
		segments = unf_effective_fn(radius=max(base_dx, base_dy, end_dx, end_dy, control_x, control_y) / 2);
		rings = [ for (z = zs) let(dx = max($over, lookup(z, bez_xz) - (2 * lip(z))), dy = max($over, lookup(z, bez_y) - (2 * lip(z))))
			   [ for (j = [0 : segments - 1]) let(a = 360 * j / segments) [(dx / 2) * cos(a), (dy / 2) * sin(a), z] ] ];
		_unf_loft(rings);
	}
}

// Module: unf_mount_tab
// Usage:
//   unf_mount_tab(<args>);
// Description:
//   Creates a mounting tab with an integrated bolt hole, washer recess, and reinforcing web supports.
// Arguments:
//   ---
//   tab_length = length dimension of the mounting tab
//   tab_height = thickness/height of the tab
//   bolt_d = diameter of the bolt hole
//   washer_v = washer definition vector for the recess
//   wall = wall thickness parameter
// Figure(Spin;VPD=150;NoAxes): sample
//   $over = 0.1;
//   $fn = 36;
//   use <unfy_shapes.scad>;
//   unf_mount_tab(tab_length=20, tab_height=5, bolt_d=4.5, washer_v=[8, 1], wall=3);
module unf_mount_tab(tab_length, tab_height, bolt_d, washer_v, wall){
  difference(){
    unf_roundedCuboid([tab_length+(4*wall), tab_length, tab_height], edge_r=[wall, wall, 0, wall, 0, 0, 0, 0], corners=[wall, wall, 0, 0]);
    translate([(tab_length/2)+(2*wall), tab_length/2, -$over]){
      cylinder(d=bolt_d, h=tab_height+(2*$over));
      translate([0, 0, wall+(2*$over)]){
	unf_wsh(size=washer_v, ext=$over);
      }
    }
  }
  translate([wall, tab_length, tab_height]){
	  rotate([0, 0, -90]){
		  unf_bezierWedge3d(size=[wall, wall, tab_length+(2*wall)]);
		  for(y=[0, tab_length+wall]){
			  translate([0, y, 0]){
				  unf_bezierWedge3d(size=[tab_length-wall, tab_length-wall, wall], rounded_edges=wall/2);
			  }
		  }
	  }
  }
}

if ("unf_roundedRectangle" == test_shape){
  unf_roundedRectangle(size=rectangle_size, corners=rectangle_corners);
}

if ("unf_roundedCuboid" == test_shape){
  unf_roundedCuboid(size=cube_size, corners=cube_corners, edge_r=cube_edge_r, bend_r=cube_bend_r,
		    bend_plane=("xy" == cube_bend_plane) ? [[1, 0, 0], [0, 1, 0]] :
			       ("yz" == cube_bend_plane) ? [[0, 1, 0], [0, 0, 1]] :
			       ("xz" == cube_bend_plane) ? [[1, 0, 0], [0, 0, 1]] :
			       [cube_bend_along, cube_bend_up]);
}

if ("unf_roundedCylinder" == test_shape){
	unf_roundedCylinder(r1=cylinder_r1, r2=cylinder_r2, edge_r=cylinder_edge_r, h=cylinder_h);
}

if ("oval" == test_shape){
	unf_oval([oval_xdiameter, oval_ydiameter]);
 }

if ("star" == test_shape){
  unf_star(od=star_od, id=star_id, p=star_p);
}

if ("bezier_wedge_2d" == test_shape){
  let (v = bez2d_use_custom_v ? bez2d_custom_v : [bez2d_size.x/4, bez2d_size.y/4]){
    unf_bezierWedge2d(size=bez2d_size, v=v);
  }
}

if ("bezier_wedge_3d" == test_shape){
  unf_bezierWedge3d(size=bez3d_size, rounded_edges=bez3d_rounded_edges);
}

if ("bezier_frustrum" == test_shape){
	unf_bezier_frustrum(
		base_dx = bezfr_base_dx,
		base_dy = bezfr_base_dy,
		base_edge_r = bezfr_base_edge_r,
		end_dx = bezfr_end_dx,
		end_dy = bezfr_end_dy,
		end_edge_r = bezfr_end_edge_r,
		length = bezfr_length,
		control_height_pct = bezfr_control_height_pct,
		control_pinch_pct = bezfr_control_pinch_pct
	);
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
