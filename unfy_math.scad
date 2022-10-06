//
// UnfyOpenSCADLib Copyright Leif Burrow 2022
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

//A rounding function that allows rounding to places other than ones
function unf_round(num, place=0) = round(num / pow(10, place)) * pow(10, place);

function unf_signum(x) = x < 0 ? -1 : (x ==0 ? 0 : 1);

// convert any angle to an equivalent positive (or 0) angle within a single circle
function unf_normalize_angle(angle) = 0 < angle ? (angle % 360) : (360 - (angle % 360));

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
      a = pow(tt, 2) + 1,,
      b = 2 * alpha * tt,
      c = pow(alpha, 2) - pow(radius, 2),
      x = max(unf_quadratic(a, b, c)),
      length = (x-e) / cos(angle)
    ) length
  );

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
 }

