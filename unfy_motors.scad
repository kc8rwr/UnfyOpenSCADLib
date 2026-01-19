//
// UnfyOpenSCADLib Copyright Leif Burrow 2026
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

use <unfy_fasteners.scad>

$fn = $preview ? 36 : 360;
$over = 1;

module unf_servo_arm(length, thickness, coupler_height, shaft_end_radius, end_radius, length, sides=1, distorted = false){
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
