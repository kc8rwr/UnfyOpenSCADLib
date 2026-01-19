/**
 * @file   unfy_math.scad
 * @author  Leif Burrow <kc8rwr@unfy.us>
 * @date   %a %b %d %H:%M:%S
 * 
 * @brief  Math functions for UnfyOpenSCADLib
 * 
 * /copyright {© 2023-%Y Leif Burrow unforgettability.net}
 */


//
// UnfyOpenSCADLib Copyright Leif Burrow 2025
// kc8rwr@unfy.us
// unforgettability.net
//
// This file is part of UnfyOpenSCADLib.
//
// UnfyOpenSCADLib is free software: you can redistribute it and/or modify it under the terms of the
// GNU General Public License as published by the Free Software Foundation, either version 3 of
// the License, or (at your option) any later version.
//
// UnfyOpenSCADLib is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
// without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
// See the GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along with UnfyOpenSCADLib.
// If not, see <https://www.gnu.org/licenses/>.
//

demonstrate_unf_distance_to_bounding_circle = false; //grapgical demo of unf_distance_to_bounding_circle() 

$fn = $preview ? 36 : 360;

// adapted from https://forums.openscad.org/is-nan-td28336.html
function unf_INF() = 1/0;
function unf_ia_nan(x) = x!=x;

//A rounding function that allows rounding to places other than ones
function unf_round(num, place=0) = round(num / pow(10, place)) * pow(10, place);

function unf_signum(x) = x < 0 ? -1 : (x ==0 ? 0 : 1);

// convert any angle to an equivalent positive (or 0) angle within a single circle
function unf_normalize_angle(angle) = let(a = angle % 360) 0 > a ? 360 + a  : a;

//Use quadratic formula to solve a quadratic equation, returns vector with both answers
function unf_quadratic(a, b, c) = let(m = sqrt(pow(b, 2) - (4 * a * c)),
				      one = (-b - m) / (2 * a),
				      two = (-b + m) / (2 * a)) [one, two];

//Calculate the distance from a point within a circle to it's circumference along a given angle
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

// Adapted from Post by MichaelAtOz https://openscad.rocklinux.narkive.com/jhqIIcOm/fn-fa-and-fs
// Since which of $fa, $fs, $fn determines curve resolution varies depending on their respective values these methods allow one to calculate one which will be correct for use within modules

//Determine which of $fa, $fs or $fn currently takes precidence, calculate and return an equivalent $fn value
function unf_effective_fn(radius, angle=360) = 0 < $fn ? $fn : let (
  pfa = 360 / $fa,
  pfs = (2*PI*radius)/$fs) ceil(max(min(pfa, pfs), 5) * (angle/360));

//Determine which of $fa, $fs or $fn currently takes precidence, calculate and return an equivalent $fa value
function unf_effective_fa(radius) = 360 / unf_effective_fn(radius);

//Determine which of $fa, $fs or $fn currently takes precidence, calculate and return an equivalent $fs value
function unf_effective_fs(radius) = 2*PI*radius / unf_effective_fn(radius);

//Determine the bounding size of a vector of 2 dimensional vectors
function unfy_bound_size2(v) =
  len(v) < 2 ? 0 :
    let (
      mnx = min([for(i=v)i.x]),
      mxx = max([for(i=v)i.x]),
      mny = min([for(i=v)i.y]),
      mxy = max([for(i=v)i.y])
    )
	[mxx - mnx, mxy - mny];

//take a vector of control points, return a vector of points on the curve
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

function unf_cartesian_from_polar(r=1, theta=90) = let (theta=unf_normalize_angle(theta)) [r*cos(theta), r*sin(theta)];

// returns the length of a chord given it's distance from the vertex and the radius
function unf_chord_distance(r=1, d=0.5) = 2 * sqrt(pow(r, 2) - pow(d, 2));

//returns the length of a chord given the angle the chord forms with the vertex and the radius
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
