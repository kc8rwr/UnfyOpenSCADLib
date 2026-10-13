// LibFile: unfy_math.scad
//   UnfyOpenSCADLib Copyright Leif Burrow 2026
//   kc8rwr@unfy.us
//   unforgettability.net
//   .
//   This file is part of UnfyOpenSCADLib.
//   .
//   unfy_math contains math functions for rounding, angles, regular polygons, circles, curve resolution and bezier curves.
demonstrate_unf_distance_to_bounding_circle = false; //grapgical demo of unf_distance_to_bounding_circle() 

$fn = $preview ? 36 : 360;

// Section: Basic Math

// Function: unf_INF
// Synopsis: Infinity
// Description:
//   Returns positive infinity. Adapted from https://forums.openscad.org/is-nan-td28336.html
// Usage:
//   unf_INF()
function unf_INF() = 1/0;

// Function: unf_is_nan
// Synopsis: Test for NaN
// Description:
//   Returns true if x is NaN (not a number). NaN is the only value which is not equal to itself. Adapted from https://forums.openscad.org/is-nan-td28336.html
// Usage:
//   unf_is_nan(x)
// Arguments:
//   x = the value to test
function unf_is_nan(x) = x!=x;

// Function: unf_round
// Synopsis: Round to any decimal place
// Description:
//   A rounding function that allows rounding to places other than ones. The place is given as a power of 10, so place=0 rounds to the ones place, place=1 rounds to the tens place and place=-2 rounds to the hundredths place.
//   .
//   For example unf_round(52.43, 1) returns 50 and unf_round(52.43, -1) returns 52.4.
// Usage:
//   unf_round(num, [place])
// Arguments:
//   num = the number to round
//   place = the power of 10 to round to (0)
function unf_round(num, place=0) = round(num / pow(10, place)) * pow(10, place);

// Function: unf_signum
// Synopsis: Sign of a number
// Description:
//   Returns -1 if x is negative, 0 if x is zero or 1 if x is positive.
// Usage:
//   unf_signum(x)
// Arguments:
//   x = the input number
function unf_signum(x) = x < 0 ? -1 : (x ==0 ? 0 : 1);

// Function: unf_normalize_angle
// Synopsis: Normalize an angle to [0, 360)
// Description:
//   Convert any angle to an equivalent positive (or 0) angle within a single circle. For example -90 becomes 270 and 450 becomes 90.
// Usage:
//   unf_normalize_angle(angle)
// Arguments:
//   angle = the angle in degrees
function unf_normalize_angle(angle) = let(a = angle % 360) 0 > a ? 360 + a  : a;

// Function: unf_quadratic
// Synopsis: Solve a quadratic equation
// Description:
//   Use the quadratic formula to solve the equation ax² + bx + c = 0. Returns a vector containing both answers, [(-b - √(b²-4ac)) / 2a, (-b + √(b²-4ac)) / 2a].
// Usage:
//   unf_quadratic(a, b, c)
// Arguments:
//   a = the coefficient of x²
//   b = the coefficient of x
//   c = the constant term
function unf_quadratic(a, b, c) = let(m = sqrt(pow(b, 2) - (4 * a * c)),
				      one = (-b - m) / (2 * a),
				      two = (-b + m) / (2 * a)) [one, two];

// Section: Regular Polygons

// Function: unf_calc_polygon_diameter
// Synopsis: Regular polygon diameter from distance across flats
// Description:
//   Calculate the diameter of a regular polygon (the diameter of the circle passing through its vertices) from the distance between opposite sides. Useful for sizing a circle() with a low $fn, such as a hexagonal nut trap.
// Usage:
//   unf_calc_polygon_diameter(f, n)
// Arguments:
//   f = distance between flats
//   n = number of sides
function unf_calc_polygon_diameter(f, n) = f / cos(180 / n);

// Function: unf_calc_polygon_interior_angle
// Synopsis: Regular polygon interior angle
// Description:
//   Calculate the interior angles of a regular polygon given the number of sides.
// Usage:
//   unf_calc_polygon_interior_angle(n)
// Arguments:
//   n = number of sides
function unf_calc_polygon_interior_angle(n) = 180 * (n-2) / n;

// Function: unf_calc_polygon_exterior_angle
// Synopsis: Regular polygon exterior angle
// Description:
//   Calculate the exterior angles of a regular polygon given the number of sides.
// Usage:
//   unf_calc_polygon_exterior_angle(n)
// Arguments:
//   n = number of sides
function unf_calc_polygon_exterior_angle(n) = 360 / n;

// Function: unf_calc_polygon_central_angle
// Synopsis: Regular polygon central angle
// Description:
//   Calculate the central angle of a regular polygon (the angle between two adjacent vertices, as seen from the center) given the number of sides.
// Usage:
//   unf_calc_polygon_central_angle(n)
// Arguments:
//   n = number of sides
function unf_calc_polygon_central_angle(n) = 360 / n;

// Section: Circles

// Function: unf_distance_to_bounding_circle
// Synopsis: Distance from a point inside a circle to its edge
// Description:
//   Calculate the distance from a point within a circle to it's circumference along a given angle.
//   .
//   Set demonstrate_unf_distance_to_bounding_circle to true and open this file in OpenSCAD for a graphical demonstration. Set steps to 360 to animate it.
// Usage:
//   unf_distance_to_bounding_circle(radius, point, angle, [focus])
// Arguments:
//   radius = radius of the circle
//   point = [x, y] location of the point within the circle
//   angle = direction in degrees in which to measure, counter-clockwise from the X axis
//   focus = [x, y] location of the center of the circle ([0, 0])
function unf_distance_to_bounding_circle(radius, point, angle, focus=[0, 0]) =
  focus.x != 0 || focus.y != 0 ? unf_distance_to_bounding_circle(radius=radius, point=[point.x-focus.x, point.y-focus.y], angle=angle, focus=[0, 0]) : // shift so point is origin, simplifies rotation
  360 <= angle || 0 > angle ? unf_distance_to_bounding_circle(radius=radius, point=point, focus=focus, angle=(0 < angle ? (angle % 360) : (360 + (angle % 360)))) : //ensure angle is between 0, 360
  90 == angle ? sqrt(pow(radius,2)-pow(point.x, 2))-point.y : // 90 degrees is special
  90 < angle ? let(rot=(angle%90)-angle, cr=cos(rot), sr=sin(rot)) unf_distance_to_bounding_circle(radius=radius, focus=focus, angle=angle%90, point=[point.x*cr-point.y*sr, cr*point.y+sr*point.x]) : // rotate into quadrant I if not already there
  let(
    e = point.x,
    f = point.y,
    tt = tan(angle)
  )
  0 > e
  ?
  unf_distance_to_bounding_circle(radius, [0, f - (e*tan(angle))], angle, [0, 0]) - (e/cos(angle))
  :
  (
    let (
      alpha = f - (e * tt),
      a = pow(tt, 2) + 1,
      b = 2 * alpha * tt,
      c = pow(alpha, 2) - pow(radius, 2),
      x = max(unf_quadratic(a, b, c)),
      length = (x-e) / cos(angle)
    ) length
  );

// Section: Curve Resolution
//   Since which of $fa, $fs, $fn determines curve resolution varies depending on their respective values these functions allow one to calculate one which will be correct for use within modules.
//   .
//   Adapted from Post by MichaelAtOz https://openscad.rocklinux.narkive.com/jhqIIcOm/fn-fa-and-fs

// Function: unf_effective_fn
// Synopsis: Effective $fn
// Description:
//   Determine which of $fa, $fs or $fn currently takes precidence, calculate and return an equivalent $fn value.
// Usage:
//   unf_effective_fn(radius, [angle])
// Arguments:
//   radius = radius of the circle or arc
//   angle = angle in degrees covered by the arc, 360 for a full circle (360)
function unf_effective_fn(radius, angle=360) = 0 < $fn ? $fn : let (
  pfa = 360 / $fa,
  pfs = (2*PI*radius)/$fs) ceil(max(min(pfa, pfs), 5) * (angle/360));

// Function: unf_effective_fa
// Synopsis: Effective $fa
// Description:
//   Determine which of $fa, $fs or $fn currently takes precidence, calculate and return an equivalent $fa value.
// Usage:
//   unf_effective_fa(radius)
// Arguments:
//   radius = radius of the circle
function unf_effective_fa(radius) = 360 / unf_effective_fn(radius);

// Function: unf_effective_fs
// Synopsis: Effective $fs
// Description:
//   Determine which of $fa, $fs or $fn currently takes precidence, calculate and return an equivalent $fs value.
// Usage:
//   unf_effective_fs(radius)
// Arguments:
//   radius = radius of the circle
function unf_effective_fs(radius) = 2*PI*radius / unf_effective_fn(radius);

// Section: Curves

// Function: unfy_bound_size2
// Synopsis: Bounding size of 2d points
// Description:
//   Determine the bounding size of a vector of 2 dimensional vectors. Returns [width, height], or 0 if fewer than 2 points are given.
// Usage:
//   unfy_bound_size2(v)
// Arguments:
//   v = vector of [x, y] points
function unfy_bound_size2(v) =
  len(v) < 2 ? 0 :
    let (
      mnx = min([for(i=v)i.x]),
      mxx = max([for(i=v)i.x]),
      mny = min([for(i=v)i.y]),
      mxy = max([for(i=v)i.y])
    )
	[mxx - mnx, mxy - mny];

// Function: unfy_bezier
// Synopsis: Points along a bezier curve
// Description:
//   Take a vector of control points, return a vector of points on the curve. Linear, quadratic and cubic curves (2, 3 or 4 control points) are supported. The number of points is determined by the current $fn, $fa and $fs.
// Usage:
//   unfy_bezier(v)
// Arguments:
//   v = vector of 1 to 4 [x, y] control points
function unfy_bezier(v) =
  assert(len(v) < 5, "Sorry, curves with order > 3 are not yet supported")
  assert(len(v) > 0, "Empty vector!")
    1 == len(v) ? [v[0]] :
    let(
      bounds = unfy_bound_size2(v), //not necessarily accurate as control points may be outside
      radius = sqrt(pow(bounds.x, 2) + pow(bounds.y, 2)),
      count = unf_effective_fn(radius, 90),
      steps = [0: 1/count: 1]
    )
  len(v) == 2 ? v : //[for(t = steps) [((1-t)*v[0].x)+(t*v[1].x), ((1-t)*v[0].y)+(t*v[1].y)]] :
  3 == len(v) ? [for(t = steps) [
    (pow((1-t),2)*v[0].x) + (2*(1-t)*t*v[1].x) + (pow(t, 2)*v[2].x),
    (pow((1-t),2)*v[0].y) + (2*(1-t)*t*v[1].y) + (pow(t, 2)*v[2].y)]] :
  4 == len(v) ? [for(t = steps) [
    (pow(1-t, 3)*v[0].x) + (3*pow(1-t, 2)*t*v[1].x) + (3*(1-t)*pow(t, 2)*v[2].x) + (pow(t, 3)*v[3].x),
    (pow(1-t, 3)*v[0].y) + (3*pow(1-t, 2)*t*v[1].y) + (3*(1-t)*pow(t, 2)*v[2].y) + (pow(t, 3)*v[3].y)]] :
    [[0, 0]];

// Function: unf_cartesian_from_polar
// Synopsis: Convert polar coordinates to cartesian
// Description:
//   Convert a polar coordinate to an [x, y] cartesian coordinate.
// Usage:
//   unf_cartesian_from_polar([r], [theta])
// Arguments:
//   r = distance from the origin (1)
//   theta = angle in degrees, counter-clockwise from the X axis (90)
function unf_cartesian_from_polar(r=1, theta=90) = let (theta=unf_normalize_angle(theta)) [r*cos(theta), r*sin(theta)];

// Function: unf_chord_distance
// Synopsis: Chord length from distance to center
// Description:
//   Returns the length of a chord given it's distance from the vertex and the radius.
// Usage:
//   unf_chord_distance([r], [d])
// Arguments:
//   r = radius of the circle (1)
//   d = distance of the chord from the center of the circle (0.5)
function unf_chord_distance(r=1, d=0.5) = 2 * sqrt(pow(r, 2) - pow(d, 2));

// Function: unf_chord_angle
// Synopsis: Chord length from angle
// Description:
//   Returns the length of a chord given the angle the chord forms with the vertex and the radius.
// Usage:
//   unf_chord_angle([r], [a])
// Arguments:
//   r = radius of the circle (1)
//   a = angle in degrees between the two ends of the chord, as seen from the center (45)
function unf_chord_angle(r=1, a=45) = 2*r*sin(a/2);

// ******************************* Demo Stuff

if (demonstrate_unf_distance_to_bounding_circle) {
  echo("Set steps to 360 to animate");

  angle = (360 * $t) + 0;
  radius = 10;
  for (point = [[0, 0, 0], [2, 4, 45], [-2, 4, 135], [-2, -4, 225], [2, -4, -45]]){
    let(ang = angle+point.z){
      cylinder(r = radius, h=0.1);
      length = unf_distance_to_bounding_circle(radius=radius, point=[point.x, point.y], angle=ang);
      translate([point.x, point.y, 0]){
	rotate([0, 0, ang]){
	  color("blue") cube([length, 0.2, 0.2]);
	}
      }
    }
  }

  translate([-10, -18, 0]){
    linear_extrude(1){
      text(text=str("Angle: ", angle), size=4);
    }
  }
} else {
  echo(str("unf_round(52.43, 3)=", unf_round(52.43, 3)));
  echo(str("unf_round(52.43, 2)=", unf_round(52.4, 2)));
  echo(str("unf_round(52.43, 1)=", unf_round(52.4, 1)));
  echo(str("unf_round(52.43)=", unf_round(52.43)));
  echo(str("unf_round(52.43, -1)=", unf_round(52.43, -1)));
  echo(str("unf_round(52.43, -2)=", unf_round(52.43, -2)));
  echo(str("unf_round(52.43, -3)=", unf_round(52.43, -3)));
  
  control = [[0, 5],  [5, 1], [14, 15],[20, 8]];
  bez=unfy_bezier(v=control);
  v = concat([[0, 0]], bez, [[20, 0]]);
  echo(str(v));
  linear_extrude(0.5) polygon(v);
  color("red"){
    for(p = control){
      translate(p){
	cylinder(d=0.5, h=1);
      }
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
