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

use <unfy_fasteners.scad>
//use <unfy_shapes.scad>

//part="CableClip"; //["CableClip", "CableClamp"]

cable_d = 7.5;
gap = 3;
bolt = "M3";
wall = 1.5;
hole_ext = 3;
tooth_length = 0.5; // [0:0.1:3]
// will receive fewer teeth if they don't fit
tooth_count = 4;

support = "none"; // ["horizontal", "vertical", "none"]
support_skin = 0.9;

body_color = "Blue"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]
support_color = "Yellow"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

center = true;

$fn = $preview ? 36 : 360;
$over = 0.01;

module unf_cableClip_Positive(cable_d=7.5, gap=3, bolt="M3", tooth_length=0.5, tooth_count=4, wall=1.5, support="none", support_skin=0.6, body_color=false, support_color=false, center=true){
  washer_v = unf_wsh_v(bolt);
  nut_v = unf_nut_v(bolt);

  bolt_d = unf_fnr_shaft_diameter(washer_v);
  washer_d = unf_wsh_diameter(washer_v);
  washer_t = unf_wsh_height(washer_v);
  nut_d = unf_nut_diameter(nut_v);
  nut_t = unf_nut_height(nut_v);

  tab_side = washer_d + (2*wall);
  washer_tab_t = washer_t + wall;
  nut_tab_t = nut_t + wall;

  module tooth(cable_d=7.5, tooth_length=0.5, tooth_width=2)
  {
    rotate_extrude(){
      translate([cable_d/2, 0, 0]){
	polygon([[0, 0], [0, tooth_width], [-tooth_length, tooth_length]]);
      }
    }
  }
  
  translation = center ? [0, 0, 0] : [(cable_d/2)+wall, nut_tab_t+(gap/2), 0];
    
    translate(translation){
      difference(){
	union(){
	  color(body_color){
	    cylinder(d=cable_d+(2*wall), h=wall+tab_side);
	    translate([0, gap/2, wall]){
	      cube([(cable_d/2)+wall+tab_side, washer_tab_t, tab_side]);
	    }
	    translate([0, -(gap/2)-nut_tab_t, 0]){
	      cube([(cable_d/2)+wall+tab_side, nut_tab_t, tab_side+wall]);
	    }
	  }
	  if ("vertical" == support && 0 < support_skin){
	    color(support_color){
	      translate([(cable_d/2)+wall+(tab_side)-support_skin, (gap/2), 0]){
		cube([support_skin, washer_tab_t, wall]);
	      }
	    }
	  }
	}
	translate([0, 0, -$over]){
	  cylinder(d=cable_d, h=wall+tab_side+(2*$over));
	  translate([0, -gap/2, 0]){
	    cube([(cable_d/2)+wall+$over, gap, wall+tab_side+(2*$over)]);
	  }
	}
	translate([-(cable_d/2)-wall-$over, -gap/2, -$over]){
	  cube([cable_d+(2*wall)+$over, (cable_d/2)+(gap/2)+wall, wall+$over]);
	}
	translate([(cable_d/2)+wall+(tab_side/2), (gap/2)+(washer_tab_t)+$over, wall+(tab_side/2)]){
	  rotate([90, 0, 0]){
	    cylinder(d=bolt_d, h=gap+washer_tab_t+nut_tab_t+(2*$over));
	    translate([0, 0, washer_tab_t+gap+nut_tab_t]){
	      rotate([180, 0, 0]){
		unf_nut(size=nut_v, ext=(2*$over));
	      }
	    }
	    translate([0, 0, 0]){
	      unf_wsh(size=washer_v, ext=$over);
	    }
	  }
	}
      }
      if (0 < tooth_count && 0 < tooth_length){
	color(body_color){
	  tooth_width = 2*tooth_length;
	  tooth_step = max(tooth_width, tab_side/tooth_count);
	  z_offset = max(0, (tab_side - (tooth_step * (tooth_count-1)) - tooth_width)/2);
	  difference(){
	    union(){
	      for(z = [0:tooth_step:tab_side-tooth_width]){
		translate([0, 0, z+z_offset+wall]){
		  tooth(cable_d=cable_d, tooth_length=tooth_length, tooth_width=tooth_width);
		}
	      }
	    }
	    translate([0, -gap/2, wall-$over]){
	      cube([(cable_d/2)+$over, gap, tab_side+(2*$over)]);
	    }
	  }
	}
      }
      if ("horizontal" == support && 0 < support_skin){
	color(support_color){
	  translate([(cable_d/2)+wall+(tab_side)-support_skin, -nut_tab_t-(gap/2), wall]){
	    cube([support_skin, nut_tab_t+gap+washer_tab_t, tab_side]);
	  }
	  translate([(cable_d/2), -nut_tab_t-(gap/2), 0]){
	    cube([support_skin, nut_tab_t+gap+washer_tab_t, tab_side+wall]);
	  }
	  translate([(cable_d/2)+wall+(tab_side/2), -(gap/2)-nut_tab_t, wall+(tab_side/2)]){
	    rotate([-90, 0, 0]){
	      difference(){
		cylinder(d=bolt_d+(2*support_skin), h=gap+washer_tab_t+nut_tab_t);
		translate([0, 0, -$over]){
		  cylinder(d=bolt_d, h=gap+washer_tab_t+nut_tab_t+(2*$over));
		}
	      }
	    }
	  }
	}
      } else if ("vertical" == support && 0 < support_skin) {
	color(support_color){
	  difference(){
	    cylinder(d=cable_d+wall+(support_skin/2), h=wall);
	    translate([0, 0, -$over]){
	      cylinder(d=cable_d+wall-(support_skin/2), h=wall+(2*$over));
	      translate([0, -gap/2, 0]){
		cube([(cable_d/2)+wall+wall, gap, wall+2*$over]);
	      }
	    }
	  }
	}
      }
    }
}

module unf_cableClip_Negative(cable_d=7.5, bolt="M3", wall=1.5, hole_ext=3, center=true){
  nut_v = unf_nut_v(bolt);

  nut_t = unf_nut_height(nut_v);
  nut_tab_t = nut_t + wall;

  center_x_offset = center ? 0 : (wall+(cable_d/2));
  center_y_offset = center ? 0 : nut_tab_t+(gap/2);
  
  translate([center_x_offset, center_y_offset, -hole_ext]){
    cylinder(d=cable_d, h=hole_ext+wall+$over);
  }
}

module unf_cableClip(location=[0, 0, 0], rotation=0, cable_d=7.5, bolt="M3", gap=3, hole_ext=3, tooth_length=0.5, tooth_count=4, support="none", support_skin=0.6, wall=1.4, body_color=false, support_color=false, center=true){
  difference(){
    children();
    translate(location){
      rotate(rotation){
	unf_cableClip_Negative(cable_d = cable_d,
			       bolt = bolt,
			       wall = wall,
			       hole_ext=hole_ext,
			       center = center);
      }
    }
  }
  translate(location){
    rotate(rotation){
     unf_cableClip_Positive(cable_d = cable_d,
			     gap = gap,
			     bolt = bolt,
			     tooth_length = tooth_length,
			     tooth_count = tooth_count,
			     wall = wall,
			     support = support,
			     support_skin = support_skin,
			     body_color = body_color,
			     support_color = support_color,
			     center = center);
    }
  }
}

/*module unf_cableClamp_Positive(cable_d=7.5, gap=3, bolt="M3", tooth_length=0.5, tooth_count=4, wall=1.5, support="none", support_skin=0.6, body_color=false, support_color=false, center=true){
  let(){

  }
}

module unf_cableClamp_Negative(cable_d=7.5, bolt="M3", wall=1.5, hole_ext=3){
  translate([0, 0, -hole_ext]){
    cylinder(d=cable_d, h=wall+hole_ext+$over);
  }
}

module unf_cableClamp_Dims(cable_d=7.5, bolt="M3", wall=1.4){
  
}

module unf_cableClamp(location=[0, 0, 0], rotation=0, cable_d=7.5, bolt="M3", gap=3, hole_ext=3, tooth_length=0.5, tooth_count=4, support="none", support_skin=0.6, wall=1.4, body_color=false, support_color=false, center=true){
  difference(){
    children();
    translate(location){
      rotate(rotation){
	unf_cableClamp_Negative(cable_d = cable_d,
			       bolt = bolt,
			       wall = wall,
			       hole_ext=hole_ext);
      }
    }
  }
  translate(location){
    rotate(rotation){
     unf_cableClamp_Positive(cable_d = cable_d,
			     gap = gap,
			     bolt = bolt,
			     tooth_length = tooth_length,
			     tooth_count = tooth_count,
			     wall = wall,
			     support = support,
			     support_skin = support_skin,
			     body_color = body_color,
			     support_color = support_color,
			     center = center);
    }
  }  
}
*/

//if (part == "CableClip"){
  unf_cableClip(location=[0, 0, wall],
		cable_d = cable_d,
		gap = gap,		 
		bolt = bolt,		 
		hole_ext = hole_ext,
		tooth_length = tooth_length,
		tooth_count = tooth_count,
		wall = wall,
		support = support,
		support_skin = support_skin,
		center = center,
		body_color = body_color,
		support_color = support_color){
    translate(center ? [-10, -7.5, 0] : [-5, -3.75, 0])
      color(support_color){
      cube([30, 15, wall]);
    }
  }
// }

/*if (part == "CableClamp"){
  unf_cableClamp(location=[0, 0, wall],
		 cable_d = cable_d,
		 gap = gap,		 
		 bolt = bolt,		 
		 hole_ext = hole_ext,
		 tooth_length = tooth_length,
		 tooth_count = tooth_count,
		 wall = wall,
		 support = support,
		 support_skin = support_skin,
		 center = center,
		 body_color = body_color,
		 support_color = support_color){
    translate(center ? [-10, -7.5, 0] : [-5, -3.75, 0])
      color(support_color){
      cube([30, 15, wall]);
    }
  }
 }
*/
