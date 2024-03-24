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

screw_d = 3.5;
hood_thickness = 2;
wall = 3;

bolt = "M4"; //["M3", "M4", "#4", "#5", "#6", "#8"]
slope = 45; //[45,0]
fastener = "Heatset"; //["Heatset", "HexNut", "PlainHole"]
heatset_length = "Medium"; //["Small", "Medium", "Large"]

support_skin = "none"; //["none", "horizontal", "vertical"]
support_skin_t = 0.02;

$over = 0.01;

use <../unfy_fasteners.scad>
use <../unfy_lists.scad>

$fn = $preview ? 15 : 360;

module unf_C14Socket(screw_d, fastener="plainhole", heatset_length="Medium", support_skin="none", support_skin_t=0.2, wall=4){
  body_x = 26;
  body_y = 22.7;
  body_depth=18;
  screw_separation = 40;
  let(fastener = unf_stToLower(fastener), support_skin = unf_stToLower(support_skin)) {

    //fastener pillars  
    difference(){
      if ("plainhole" != unf_stToLower(fastener)){
	for (x = [-screw_separation/2, screw_separation/2]){
	  translate([x, body_y/2]){
	    rotate([0, 180, 0]){
	      unf_pillar(fastener=fastener, heatset_length=heatset_length, bolt=bolt, slope=slope, length=5);
	    }
	  }
	}
      }
      translate([-screw_separation/2, 0, $over]){
	unf_C14Body(depth=body_depth+$over);
      }
    }

    //support skin
    if ("none" != support_skin && 0 < support_skin_t){
      color("LightGrey", alpha=0.5){
	translate([0, 0, wall-support_skin_t]){
	  unf_C14Cape(hood_thickness=support_skin_t);
	}
	translate([-screw_separation/2, 0, 0]){
	  unf_C14Body(depth=support_skin_t);
	}
      }
    }
    
    //vertical support (bar between screw holes for supporting pillars when printed on end)
    if ("vertical" == support_skin && "none" != fastener && 0 < support_skin_t) {
      color("LightGrey", alpha=0.5){
	hull(){
	  intersection() {
	    unf_C14Socket(screw_d=screw_d, fastener=fastener, heatset_length=heatset_length, support_skin="none", support_skin_t=0, wall=wall);
	    translate([-screw_separation/2, (body_y/2)-(support_skin_t/2), -body_depth]){
	      cube([screw_separation, support_skin_t, body_depth]);
	    }
	  }
	}
      }
    }
    
  }
}

module unf_C14SocketCutout(screw_d=3, hood_thickness=3, wall=4){  
  body_x = 26;
  body_y = 22.7;
  unf_C14Cape(hood_thickness=hood_thickness);
  body_depth = 18;
  ear_x=13;
  screw_separation=40;
  translate([-screw_separation/2, 0, -$over]){
    unf_C14Body(depth=body_depth+$over);
  }
  translate([0, 0, -(wall+body_depth)]){
    //screw holes
  for (x = [screw_separation/2, -screw_separation/2]){
      translate([x, body_y/2]){
	cylinder(d=screw_d, h=body_depth+wall);
      }
    }
  }
}

module unf_C14Cape(hood_thickness=3){
  body_x = 26;
  body_y = 22.7;
  screw_separation = 40;
  ear_x = 13;
  translate([-ear_x, 0, -hood_thickness]){
    linear_extrude(hood_thickness){
      hull(){
	//body
	square([body_x, body_y]);

	//ears
	for (x = [(body_x/2)-(screw_separation/2), (body_x/2)+(screw_separation/2)]){
	  translate([x, body_y/2]){
	    circle(r = ear_x - ((screw_separation/2)-(body_x/2)));
	  }
	}
      }
    }
  }  
}

module unf_C14Body(depth=18){
  body_x = 26;
  body_y = 22.7;
  ear_x=13;
  cutaway_bottom_x = 27.2;
  cutaway_bottom_y = 13.33;
  cutaway_top_x = 21;
  cutaway_y = 20;
  translate([ear_x/2, 0, -depth]){
    linear_extrude(depth){
      //body
      bottom_y = (body_y - cutaway_y)/2;
      mid_y = bottom_y + cutaway_bottom_y;
      top_y = bottom_y + cutaway_y;
      left_x = (body_x - cutaway_bottom_x) /2;
      top_left_x = left_x + ((cutaway_bottom_x - cutaway_top_x)/2);
      top_right_x = top_left_x + cutaway_top_x;
      right_x = left_x + cutaway_bottom_x;
      polygon([[left_x, bottom_y], [left_x, mid_y], [top_left_x, top_y], [top_right_x, top_y], [right_x, mid_y], [right_x, bottom_y]]);
    }
  }
}


difference(){
  translate([-32.5, -1, 0]){
    cube([65, 25, wall]);
  }
  translate([0, 0, (wall+$over)]){
    unf_C14SocketCutout(screw_d=screw_d,
      hood_thickness=hood_thickness+$over,
      wall=wall);
    }
}
unf_C14Socket(screw_d=screw_d,
	      fastener=fastener,
	      heatset_length=heatset_length,
	      support_skin=support_skin,
	      support_skin_t=support_skin_t,
	      wall = wall);




