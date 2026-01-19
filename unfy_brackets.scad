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
use <unfy_shapes.scad>

part="SimpleBracket"; //["SimpleBracket"]

top_bolt_size = "M4"; // ["M3", "M4", "#4", "#6", "#8"]
top_slot_length = 0;
top_bolt_position = 11;
bottom_bolt_size = "#6"; // ["M3", "M4", "#4", "#6", "#8"]
bottom_slot_length = 0;
bottom_bolt_position = 13;

body_color = "Blue"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

wall = 3;
$over = 0.01;

$fn = $preview ? 36 : 360;

module unf_simple_bracket(top_bolt_size = "M4",
			  top_slot_length = 0,
			  top_bolt_position = 11,
			  bottom_bolt_size = "#6",
			  bottom_slot_length = 0,
			  bottom_bolt_position = 11,
			  body_color = false,
			  wall = 4){
  let(top_washer_v = unf_wsh_v(top_bolt_size),
      top_washer_d = unf_wsh_diameter(top_washer_v),
      top_bolt_d = unf_fnr_shaft_diameter(top_bolt_size),
      bottom_washer_v = unf_wsh_v(bottom_bolt_size),
      bottom_washer_d = unf_wsh_diameter(bottom_washer_v),
      bottom_bolt_d = unf_fnr_shaft_diameter(bottom_bolt_size),
      width = max(top_washer_d, bottom_washer_d) + (4*wall), //4*wall = 2 wall-widthed webs + 2 wall-widthed outer edges
      top_length = top_bolt_position + (top_washer_d / 2)  + max(0, top_slot_length-(top_bolt_d/2)) + wall,
      bottom_length = bottom_bolt_position + (bottom_washer_d / 2) + max(0, bottom_slot_length-(bottom_bolt_d/2)) + wall, //2*wall = wall taken up by width of top_side + wall-widthed outer edge
      round_edge = wall / 4) {
    color(body_color){
      difference(){
	union(){
	  translate([0, -bottom_length, 0]){
	    difference(){
	      unf_roundedCuboid(size=[width, bottom_length, wall], edge_r=[round_edge, round_edge, 0, round_edge, 0, 0, 0, 0], corners=[wall, wall, 0, 0]);
	    }
	  }
	  translate([0, -wall, 0]){
	    rotate([-90, 0, 0]){
	      translate([0, -(top_length), 0]){
		difference(){
		  union(){
		    unf_roundedCuboid(size=[width, top_length, wall], edge_r=[0, 0, 0, 0, round_edge, round_edge, 0, round_edge], corners=[wall, wall, 0, 0]);
		    translate([2*wall, top_length-wall, 0]){
		      rotate([0, 90, -90]){
			unf_bezierWedge3d(size=[wall, wall, width-(4*wall)]);
		      }
		    }
		  }		  
		}
	      }
	    }
	  }
	  for(x = [wall, width-(2*wall)]){
	    translate([x, -wall, wall]){
	      rotate([0, 0, -90]){
		unf_bezierWedge3d(size=[bottom_length-wall, top_length-wall, wall], rounded_edges=wall/2);
	      }
	    }
	  }
	}

	//Bottom bolt hole or slot
	translate([width/2, -bottom_bolt_position, 0]){
	  translate([0, 0, wall+$over]){
	    rotate([0, 180, 0]){
	      if (bottom_bolt_d < bottom_slot_length){
		hull(){
		  unf_wsh(size=bottom_washer_v, ext=wall+$over);
		  translate([0, -(bottom_slot_length-bottom_bolt_d), 0]){
		    unf_wsh(size=bottom_washer_v, ext=wall+$over);
		  }
		}
	      }else{
		unf_wsh(size=bottom_washer_v, ext=wall+$over);
	      }
	    }
	  }
	  translate([0, 0, -$over]){
	    if (bottom_bolt_d < bottom_slot_length){
	      hull(){
		cylinder(d=bottom_bolt_d, h=wall+(2*$over));
		translate([0, -(bottom_slot_length-bottom_bolt_d), 0]){
		  cylinder(d=bottom_bolt_d, h=wall+(2*$over));
		}
	      }
	    }else{
	      cylinder(d=bottom_bolt_d, h=wall+(2*$over));
	    }
	  }
	}

	//Top bolt hole or slot
	translate([width/2, -wall, top_bolt_position]){
	  rotate([-90, 0, 0]){
	    if (top_bolt_d < top_slot_length){
	      hull(){
		unf_wsh(size=top_washer_v, ext=wall+$over);
		translate([0, -(top_slot_length-top_bolt_d), 0]){
		  unf_wsh(size=top_washer_v, ext=wall+$over);
		}
	      }
	    }else{
	      unf_wsh(size=top_washer_v, ext=wall+$over);
	    }
	    translate([0, 0, -$over]){
	      if (top_bolt_d < top_slot_length){
		hull(){
		  cylinder(d=top_bolt_d, h=wall+(2*$over));
		  translate([0, -(top_slot_length-top_bolt_d), 0]){
		    cylinder(d=top_bolt_d, h=wall+(2*$over));
		  }
		}
	      }else{
		cylinder(d=top_bolt_d, h=wall+(2*$over));
	      }
	    }
	  }
	}

      }
    }
  }
}

if ("SimpleBracket" == part){
  unf_simple_bracket(top_bolt_size = top_bolt_size,
		     top_slot_length = top_slot_length,
		     top_bolt_position = top_bolt_position,
		     bottom_bolt_size = bottom_bolt_size,
		     bottom_slot_length = bottom_slot_length,
		     bottom_bolt_position = bottom_bolt_position,
		     body_color = body_color,
		     wall = wall
  );
 }
