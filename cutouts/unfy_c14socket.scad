// - Under construction - Not yet fully functional
//
// UnfyOpenSCADLib Copyright Leif Burrow 2024
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

body_x = 31.8;
body_y = 24;
ear_x = 9.1;
screw_d = 3.5;
screw_x = 4.1;
cutout_x = 27.2;
cutout_y = 19.2;
hood_thickness = 2;
cutaway_thickness = 6;
cutaway_bottom_x = 27.2;
cutaway_bottom_y = 13.33;
cutaway_top_x = 15;
cutaway_y = 20;


$fn = $preview ? 15 : 360;

module C14SocketCutout(body_x, body_y, ear_x, screw_d, screw_x, cutout_x, hood_thickness, cutaway_bottom_x, cutaway_bottom_y, cutaway_top_x, cutaway_y){

  translate([0, 0, -hood_thickness]){
    linear_extrude(hood_thickness){
      hull(){
	//body
	square([body_x, body_y]);

	//ears
	for (x = [-screw_x, body_x + screw_x]){
	  translate([x, body_y/2]){
	    circle(r = ear_x - screw_x);
	  }
	}
      }
    }
  }
  translate([0, 0, -cutaway_thickness]){
    linear_extrude(cutaway_thickness){
      //body
      bottom_y = (body_y - cutaway_y)/2;
      mid_y = bottom_y + cutaway_bottom_y;
      top_y = bottom_y + cutaway_y;
      left_x = (body_x - cutaway_bottom_x) /2;
      top_left_x = left_x + ((cutaway_bottom_x - cutaway_top_x)/2);
      top_right_x = top_left_x + cutaway_top_x;
      right_x = left_x + cutaway_bottom_x;
      polygon([[left_x, bottom_y], [left_x, mid_y], [top_left_x, top_y], [top_right_x, top_y], [right_x, mid_y], [right_x, bottom_y]]);

      //screw holes
      for (x = [-screw_x, body_x + screw_x]){
	translate([x, body_y/2]){
	  circle(d = screw_d);
	}
      }
    }
  }
}

difference()
{
  translate([16,12, 0]) cylinder(d=60, h=3.9);
  translate([0, 0, 4]){
    C14SocketCutout(body_x = body_x,
		     body_y = body_y,
		     ear_x = ear_x,
		     screw_d = screw_d,
		     screw_x = screw_x,
		     cutout_x = cutout_x,
		     hood_thickness = hood_thickness,
		     cutaway_bottom_x = cutaway_bottom_x,
		     cutaway_bottom_y = cutaway_bottom_y,
		     cutaway_top_x = cutaway_top_x,
		     cutaway_y = cutaway_y);
  }
}
