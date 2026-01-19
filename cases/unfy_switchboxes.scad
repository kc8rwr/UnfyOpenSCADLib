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

use <../unfy_fasteners.scad>
use <../unfy_shapes.scad>
use <../cutouts/unfy_popins.scad>
use <../unfy_cablemanagement.scad>

box_type = "Mounted"; //["Mounted"]

device="RLEIL_R2 | RLEIL_R2-Rleil R2 Series Switch"; //["RLEIL_R2 | RLEIL_R2-Rleil R2 Series Switch"]
device_space_z = 4;
device_space_y = 4;

support_skin = 0.6;


body_color = "Blue"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]
support_color = "Yellow"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

/* [Mounted Switchbox] */
mbx_angle = 25; //[0:90]
mbx_max_skinless_angle = 50; //[0:90]
mbx_fastener_spacing = 100;
mbx_fastener_size = "#6"; // ["M3", "M4", "#4", "#6", "#8"]
mbx_cable_d = 7.5;
mbx_cable_bolt = "M3"; //["M3", "M4", "#6"]

/* [ advanced ] */
wall = 4;
$fn = $preview ? 18 : 360;
$over = 0.01;

module unf_mounted_power_switch_box(angle=45, corner=5, edge=2, device="RLEIL_R2", device_space_z=4, device_space_y=4, fastener_spacing=100, fastener_size="#6", cable_d=7.5, cable_bolt="M3", body_color="Blue", support_color="Yellow", support_skin=0.6, max_skinless_angle=50, wall=2){
  let(switch_d = unf_Popin_Dims(device = device),
      washer_v = unf_wsh_v(fastener_size),
      bolt_d = unf_fnr_shaft_diameter(washer_v),
      tab_length = unf_wsh_diameter(washer_v) + (2*wall),
      tab_width = unf_wsh_diameter(washer_v) + (6*wall),
      tab_height = wall + unf_wsh_height(washer_v),

      face_width = switch_d.y+(2*max(corner, wall, device_space_y)),
      face_length = switch_d.x+(2*max(corner, wall, device_space_z)),
      face_depth = 100,

      base_width = fastener_spacing-(2*tab_length),
      base_height = max(sin(90-angle)*switch_d.z, 2*wall, tab_length+edge-wall),

      base_depth = (edge) + face_length/cos(45 >= angle ? angle : 90-angle),

      face = [face_depth, face_width, face_length],
      base = [base_depth, base_width, base_height],
      dimMax = max(face.x, face.y, face.z, base.x, base.y, base.z)
  ) {
    unf_cableClip(location=[0, base.y/2, (cable_d/2)+1.5], rotation=[0, -90, 0], cable_d=cable_d, bolt=cable_bolt, hole_ext=wall+$over, support="none", body_color=body_color, support_color=support_color, wall=1.5){
      difference(){
	union(){
	  //base
	  color(body_color){
	    unf_roundedCuboid(size=base, corners=corner, edge_r=[edge, 0]);
	  }
	  intersection(){
	    translate([base_depth-edge, 0, base_height]){
	      rotate([0, angle-90, 0]){
		translate([-face_depth, (base_width/2)-(face_width/2), 0]){
		  unf_Popin(location=[face.x, (face.y/2)-(switch_d.y/2), (face.z/2)-(switch_d.x/2)], rotation=[0, -90, 0], device=device, wall=wall, body_color=body_color, support_color=support_color, support_skin=angle>max_skinless_angle?support_skin:0, do_render=false){
		    color(body_color){
		      difference(){
			unf_roundedCuboid(size=face, corners=[0, corner, corner, 0], edge_r=[edge, 0]);
			translate([-$over, wall, wall]){
			  unf_roundedCuboid(size=[face.x+$over-wall, face.y-(2*wall), face.z-(2*wall)], corners=[0, corner, corner, 0], edge_r=[edge, 0]);
			}
		      }
		    }
		  }
		}
	      }
	    }
	    translate([0, 0, 0]){
	      color(body_color){
		cube([2*dimMax, 2*dimMax, dimMax]);
	      }
	    }
	  }
	  // Backing
	  color(body_color){
	    translate([0, (base.y/2)-(face.y/2), 0]){
	      z = (90==angle) ? base.z+face.z-edge : ((((face.z)/cos(angle))-(base.x-edge))*tan(90-angle))+base.z-edge;
	      cube([wall, face.y, z]);
	    }
	  }
	  
	  translate([(base.x/2)-(tab_width/2), -tab_length, 0]){
	    color(body_color){
	      unf_mount_tab(tab_length=tab_length, tab_height=tab_height, bolt_d=bolt_d, washer_v=washer_v, wall=wall);
	    }
	  }
	  translate([(base.x/2)+(tab_width/2), tab_length+base.y, 0]){
	    rotate([0, 0, 180]){
	      color(body_color){
		unf_mount_tab(tab_length=tab_length, tab_height=tab_height, bolt_d=bolt_d, washer_v=washer_v, wall=wall);
	      }
	    }
	  }
	}
	
	//base opening
	translate([wall, wall, -$over]){
	  unf_roundedCuboid(size=[base.x-(2*wall), base.y-(2*wall), base.z-wall+$over], corners=corner, edge_r=[edge, 0]);
	}
	//opening between base and head
	translate([max(wall, edge), (base.y/2)-((face.y-(2*wall))/2), 0]){
	  cube([base.x-(2*max(wall,edge)), face.y-(2*wall), base.z+$over]);
	}
      }
      //base support skin
      if (0 < support_skin){
	color(support_color){
	  translate([max(wall, edge)+support_skin, (base.y/2)-((face.y-(2*wall))/2), 0]){
	    cube([base.x-(2*(max(wall, edge)+support_skin)), support_skin, base.z-wall]);
	  }
	  translate([max(wall, edge)+support_skin, (base.y/2)+((face.y-(2*wall))/2), 0]){
	    cube([base.x-(2*(max(wall, edge)+support_skin)), support_skin, base.z-wall]);
	  }
	}
      }
    }
  }
}


unf_mounted_power_switch_box(angle = mbx_angle,
		 device=device,
		 device_space_z = device_space_z,
		 device_space_y = device_space_y,
		 fastener_spacing=mbx_fastener_spacing,
		 fastener_size = mbx_fastener_size,
		 cable_d = mbx_cable_d,
		 cable_bolt = mbx_cable_bolt,
		 body_color=body_color,
		 support_color=support_color,
		 support_skin = support_skin,
		 max_skinless_angle = mbx_max_skinless_angle,
		 wall = wall);
