// LibFile: unfy_motors.scad
//   UnfyOpenSCADLib Copyright Leif Burrow 2026
//   kc8rwr@unfy.us
//   unforgettability.net
//   .
//   This file is part of UnfyOpenSCADLib.
//   .
//   unfy_motors contains modules for working with motors and servos.

use <unfy_fasteners.scad>

$fn = $preview ? 36 : 360;
$over = 1;

// Module: unf_servo_arm
// Usage:
//   unf_servo_arm(&lt;args&gt;);
// Description:
//   Creates the shape of a servo arm (horn) including the coupler which fits over the servo shaft. Intended for subtracting from a part to create a pocket that a servo arm fits into.
// Arguments:
//   ---
//   length = length of each arm measured from the center of the shaft to the far end
//   thickness = thickness of the arm
//   coupler_height = height of the coupler that fits over the servo shaft, extending beyond the arm
//   shaft_end_radius = radius of the arm at the shaft end, also the radius of the coupler
//   end_radius = radius of the arm at the far end
//   sides = number of arms, evenly spaced, or a vector of the angles at which to place each arm (1)
//   distorted = distort the coupler hole to compensate for sagging when printed horizontally, see unf_shaft() in unfy_fasteners.scad (false)
// Figure(Spin;VPD=100;VPT=[8,0,0];NoAxes): single arm
//   $over = 1;
//   $fn = 36;
//   use <unfy_motors.scad>;
//   unf_servo_arm(length=22.25, thickness=2.5, coupler_height=2, shaft_end_radius=3.75, end_radius=2.5);
// Figure(Spin;VPD=100;NoAxes): sides=4
//   $over = 1;
//   $fn = 36;
//   use <unfy_motors.scad>;
//   unf_servo_arm(length=22.25, thickness=2.5, coupler_height=2, shaft_end_radius=3.75, end_radius=2.5, sides=4);
module unf_servo_arm(length, thickness, coupler_height, shaft_end_radius, end_radius, sides=1, distorted = false){
  let (sides = is_list(sides) ? sides : (is_num(sides) ? [ for (i=[0:360/sides:360 - (360/sides)]) i ] : [0]) ){
    unf_shaft(diameter = shaft_end_radius*2, length = thickness + coupler_height, distorted = distorted);
    for(clock = sides){
      rotate([0, 0, clock]){
	linear_extrude(thickness){
	  hull(){
	    circle(r=shaft_end_radius);
	    translate([length - (shaft_end_radius + end_radius), 0, 0]){
	      circle(r = end_radius);
	    }
	  }
	}
      }
    }
  }
}


rotate([-90, 180, 0]){
  difference(){
    cube([30, 10, 4.5]);
    translate([7, 5, 0]){
      translate([0, 0, -$over]){
	unf_servo_arm(length=22.25, thickness=2.5+$over, coupler_height=2+(2*$over), shaft_end_radius=3.75, end_radius=2.5, distorted = false);
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
