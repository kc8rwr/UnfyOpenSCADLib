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

use <../unfy_fasteners.scad>
use <../unfy_shapes.scad>
use <../cutouts/unfy_c14socket.scad>
use <../cutouts/unfy_popins.scad>
use <../cutouts/unfy_dhole.scad>
use <../unfy_cablemanagement.scad>

part = "MountedPowerBox"; // ["MountedPowerBox"]

support_skin = 0.6;

body_color = "Blue"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]
support_color = "Yellow"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

bolt_size = "#6"; // ["M3", "M4", "#4", "#6", "#8"]
socket_fastener = "Heatset"; //["Heatset", "HexNut", "PlainHole"]
socket_fastener_size = "M4"; // ["M3", "M4", "#4", "#6", "#8"]

fuse_holder_hole_diameter = 12;
fuse_holder_outer_diameter = 14;
fuse_holder_spacing = 4; //[0:0.5:5]
fuse_holder_hole_shape = "circle";// ["circle", "d", "doubled"]
fuse_holder_flat_width = 5;
fuse_holder_rotation = 0; //[0:360]

top_cable_d = 7.5;
top_cable_bolt = "M3"; //["M3", "M4", "#6"]
bottom_cable_d = 7.5;
bottom_cable_bolt = "M3"; //["M3", "M4", "#6"]

wall = 4;
$fn = $preview ? 36 : 360;
$over = 0.01;

module unf_mounted_power_socket_box(step=[20, 27],
		 bolt_size = "m4",
		 back_lip = 5,
		 top_cable_d,
		 top_cable_bolt,
		 bottom_cable_d,
		 bottom_cable_bolt,
		 socket_fastener="Heatset",
		 socket_fastener_size="M4",
		 fuse_holder_hole_diameter=12,
		 fuse_holder_outer_diameter=14,
		 fuse_holder_spacing=4,
		 fuse_holder_hole_shape="circle",
		 fuse_holder_flat_width=5,
		 fuse_holder_rotation=0,
		 support_skin=0.6,
		 wall=4){

  module main_shape(back_size, front_size, corner_r, back_corner_r, wall){
    let(back_size = [max(wall, back_size.x), max(wall, back_size.y), max(wall, back_size.z)],
	front_size = [max(wall, front_size.x), max(wall, front_size.y), max(wall, front_size.z)],
	edge_r = corner_r/4,
	back_corners = [back_corner_r, corner_r, 0, 0],
	front_corners = [0, corner_r, 0, 0],
	edge_rs=[edge_r, edge_r, 0, edge_r, 0, 0, 0, 0]){
      unf_roundedCuboid(size=back_size, corners=back_corners, edge_r=edge_rs);
      translate([back_size.x-corner_r, 0, 0]){
	unf_roundedCuboid(size=[front_size.x+corner_r, front_size.y, front_size.z], corners=front_corners, edge_r=edge_rs);
      }
    }
  }
  
  let(washer_v = unf_wsh_v(bolt_size),
      size = [57, 54],
      bolt_d = unf_fnr_shaft_diameter(washer_v),
      tab_length = unf_wsh_diameter(washer_v) + (2*wall),
      tab_height = wall + unf_wsh_height(washer_v),
      c14_zpos = wall,
      fuse_holder_zpos = c14_zpos + unf_c14_size().x + fuse_holder_spacing,
      back_x = size.x,
      back_y = size.y - tab_length,
      corner_r = min(back_x, back_y)/2,
      back_corner_r = corner_r / 4,
      back_z = fuse_holder_zpos + fuse_holder_spacing + fuse_holder_outer_diameter + max(back_corner_r, fuse_holder_spacing),
      back_size = [back_x, back_y, back_z],
      front_size = [step.x, back_y, step.y]
  ){

    // Top Cable Clip
    unf_cableClip(location=[back_size.x-(corner_r/2), back_size.y-wall-(top_cable_d/2), back_size.z], rotation=[0, 0, -90], cable_d=top_cable_d, bolt=top_cable_bolt, hole_ext=back_size.z-(2*wall), support="vertical", support_skin=support_skin, body_color=body_color, support_color=support_color)
      
      // Bottom Cable Clip
      unf_cableClip(location=[front_size.x+back_size.x, (3/4)*front_size.y, 0], rotation=[180, -90, 0], cable_d=top_cable_d, bolt=top_cable_bolt, hole_ext=front_size.x, body_color=body_color, support="none", center=false)
      
      // Socket
      unf_C14Socket(rotation=[0, 90, 180], location=[wall-$over, (unf_c14_size().y+front_size.y)/2, unf_c14_size().x+c14_zpos], fastener=socket_fastener, bolt=socket_fastener_size, support_skin="vertical", restriction_l=fuse_holder_spacing, restriction_r=c14_zpos, body_color=body_color, support_color=support_color, support_skin_t=support_skin, wall=wall){
      
      color(body_color){

	//Main Body
	
	difference(){
	  //outer main body
	  main_shape(back_size=back_size, front_size=front_size, corner_r=corner_r, back_corner_r=back_corner_r, wall=wall);
	  //cutout inside, except bottom
	    translate([wall, wall, wall]){
	    main_shape(back_size = [max($over, back_size.x-(2*wall)), max($over, back_size.y-(2*wall)), max($over, back_size.z-(2*wall))],
		       front_size = [max($over, front_size.x-(2*wall)), max($over, front_size.y-(2*wall)), max($over, front_size.z-(2*wall))],
		       corner_r = corner_r, back_corner_r = back_corner_r, wall=wall);
	  }
	  //cutout middle of bottom
	  translate([2*wall, 2*wall, -$over]){
	    main_shape(back_size = [max($over, back_size.x-(4*wall)), max($over, back_size.y-(4*wall)), max($over, back_size.z-wall+$over)],
		       front_size = [max($over, front_size.x-(2*wall)), max($over, front_size.y-(4*wall)), max($over, front_size.z-wall+$over)],
		       corner_r = corner_r, back_corner_r = back_corner_r, wall=wall);
	  }
	  //cut back out of main section
	  translate([back_lip+wall, back_size.y-(wall+$over), max(wall, back_lip)]){
	    cube([max($over, back_size.x-(2*wall)-(2*back_lip)), max($over, wall+(2*$over)), max($over, back_size.z-(2*max(wall, back_lip)))]);
	  }
	  //cut back out of step section
	  translate([wall+back_lip, back_size.y-(wall+$over), max(wall, back_lip)]){
	    cube([max($over, size.x+step.x-(2*wall)-(2*back_lip)), max($over, wall+(2*$over)), max($over, front_size.z-(2*max(wall, back_lip)))]);
	  }

	  //Fuse Holder
	  translate([wall+$over, back_size.y/2, fuse_holder_zpos+(fuse_holder_outer_diameter/2)]){
	    rotate([90, "doubled"==fuse_holder_hole_shape?90:0, -90]){
	      unf_DHole(diameter=fuse_holder_hole_diameter, shape=fuse_holder_hole_shape, flat_width=fuse_holder_flat_width, angle=fuse_holder_rotation, z=wall+(2*$over));
	    }
	  }
	}

	// Side Tab
	translate([size.x-corner_r-(tab_length+(4*wall)), -tab_length, 0]){
	  unf_mount_tab(tab_length=tab_length, tab_height=tab_height, bolt_d=bolt_d, washer_v=washer_v, wall=wall);
	}

	
	// Top Tab
	translate([tab_length+(5*wall), back_size.y, back_size.z]){
	  rotate([270, 0, 180]){
	    translate([0, -tab_length, 0]){
	      unf_mount_tab(tab_length=tab_length, tab_height=tab_height, bolt_d=bolt_d, washer_v=washer_v, wall=wall);
	    }
	  }
	}

      }
      
      //Support Skin
      if ($over < support_skin){
	color(support_color, alpha=0.5){
	  //hold up corner of step
	  translate([back_size.x-back_lip-wall, back_size.y-wall, 0]){
	    cube([support_skin, wall, front_size.z-back_lip]);
	  }
	  //backing of main section
	  translate([back_lip+wall, back_size.y-support_skin, 0]){
	    cube([back_size.x-(2*wall)-(2*back_lip), support_skin, back_size.z+$over-max(wall, back_lip)]);
	  }
	  //backing of step
	  translate([back_size.x-back_lip-wall, back_size.y-support_skin, 0]){
	    cube([step.x, support_skin, front_size.z-max(wall, back_lip)]);
	  }
	}
      }
    }
  }
}

if ("MountedPowerBox" == part){

  unf_mounted_power_socket_box(bolt_size = bolt_size,
	    top_cable_d = top_cable_d,
	    top_cable_bolt = top_cable_bolt,
	    bottom_cable_d = bottom_cable_d,
	    bottom_cable_bolt = bottom_cable_bolt,
	    socket_fastener=socket_fastener,
	    socket_fastener_size=socket_fastener,
	    fuse_holder_hole_diameter = fuse_holder_hole_diameter,
	    fuse_holder_outer_diameter = fuse_holder_outer_diameter,
	    fuse_holder_spacing = fuse_holder_spacing,
	    fuse_holder_hole_shape = fuse_holder_hole_shape,
	    fuse_holder_flat_width = fuse_holder_flat_width,
	    fuse_holder_rotation = fuse_holder_rotation,
	    support_skin = support_skin,
	    wall = wall);
 }
