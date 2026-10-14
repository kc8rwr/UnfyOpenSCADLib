// LibFile: unfy_boards.scad
//   UnfyOpenSCADLib Copyright Leif Burrow 2026
//   kc8rwr@unfy.us
//   unforgettability.net
//   .
//   This file is part of UnfyOpenSCADLib.
//   .
//   unfy_boards contains a collection of modules for generating common maker PCBs, mockups, their drill holes and standoffs.

use <unfy_fasteners.scad>
use <unfy_shapes.scad>

part = "standoff"; // ["standoff", "rak19007"]

standoff_color = "yellow"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

pcb_color = "green"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

support_color = "gray"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

subtraction_color = "Yellow"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

show_board = true;

standoff_type = "bottom_heatset"; //["bottom_heatset", "top_heatset", "bottom_nut", "side_nut", "self_tapping"]
standoff_bolt_size = "M3"; //["M2.5", "M3", "M4", "#4", "#6", "#8"]
standoff_height = 5;
standoff_ext = 2;
heatset_length = "medium"; //["small", "medium", "large"]

wall = 2;
$over = 0.001;
$fn = $preview ? 36 : 360;

use <unfy_shapes.scad>

// Section: Boards

// Module: rak19007
// Usage:
//   rak19007(&lt;args&gt;);
// Description:
//   Creates a mockup of a RAKwireless RAK19007 WisBlock base board, with its mounting holes and cutouts. The board is rendered as a transparent background (%) object so it shows in preview but is not part of the rendered model.
// Arguments:
//   ---
//   show_board = show the board mockup (true)
//   standoff_height = height of the bottom of the board above the origin (5)
//   pcb_color = color of the board (green)
//   subtraction_color = color of the holes and cutouts in the board (yellow)
//   support_color = color of any generated supports (gray)
// Figure(Spin;VPD=150;VPT=[15,30,5];NoAxes): defaults
//   $over = 0.001;
//   $fn = 36;
//   use <unfy_boards.scad>;
//   rak19007();
module rak19007(
	show_board = true,
	standoff_height = 5,
	pcb_color = "green",
	subtraction_color = "yellow",
	support_color = "gray"
){
	hole_positions = [[4, 4], [4, 56], [26, 56], [28, 2]];
	if (show_board){
		translate([0, 0, standoff_height]){
			%difference(){
				color(pcb_color, 0.5){
					//		union(){
					unf_roundedCuboid(size=[30, 60, 1.6], corners=1, edge_r=0); //main board
					translate([0, 28, 1.6]){
						cube([30, 20, 1.6]); //daughter board
					}
				}
				color(subtraction_color){
					translate([-$over, 60-(15.5+13), -$over]){
						unf_roundedCuboid(size=[8, 13, 1.6 + (2*$over)], corners=[0, 1, 1, 0], edge_r=0);
					}
					translate([6.9, -$over, -$over]){
						unf_roundedCuboid([14.5, 8+$over, 1.6+(2*$over)], corners=[0, 0, 1, 1], edge_r=0);
					}
					//screw holes
					for(t = hole_positions){
						translate([t.x, t.y, -$over]){
							cylinder(d=2.7, h=1.6+(2*$over));
						}
					}
				}
			}
		}
	}
}

// Section: Standoffs
// Figure(3D;Med;VPD=800;VPT=[0,20,90];VPR=[70,0,20];NoAxes): Standoffs are not yet ready to use, coming soon!
//   $over = 0.01;
//   $fn = 36;
//   use <unfy_construction.scad>;
//   unf_construction_scene();

// Module: standoff
// Usage:
//   standoff(&lt;args&gt;);
// Description:
//   Creates a standoff for mounting a board. Render once with positive=true to create the standoff itself and once with positive=false to create the bolt hole and nut trap to subtract from it.
// Arguments:
//   ---
//   positive = true to create the standoff, false to create the hole to subtract from it (true)
//   type = how the bolt is held, one of "bottom_heatset", "top_heatset", "bottom_nut", "side_nut" or "self_tapping" (bottom_heatset)
//   bolt_size = bolt size (m3)
//   base_ext = how far the bolt hole extends below the standoff into the part it is mounted on (2.5)
//   height = height of the standoff (5)
//   wall_ext = how far the base of the standoff extends down into the wall it is mounted on (1)
//   heatset_length = length of heatset insert, "small", "medium" or "large" (medium)
// Figure(Spin;VPD=50;VPT=[0,0,2];NoAxes): defaults, cut away to show the hole
//   $over = 0.001;
//   $fn = 36;
//   use <unfy_boards.scad>;
//   difference(){
//     color("Blue") standoff(positive=true);
//     color("Yellow") standoff(positive=false);
//     color("Yellow") translate([0, -10, -10]) cube(20);
//   }
module standoff(
	positive = true,
	type = "bottom_heatset",
	bolt_size = "m3",
	base_ext = 2.5,
	height = 5,
	wall_ext = 1,
	heatset_length = "medium",
){
	bolt_d = unf_fnr_shaft_diameter(bolt_size);
	nut_v = unf_nut_v(bolt_size);
	hst_v = unf_hst_v(size=bolt_size, length=heatset_length);

	base_d = max(bolt_d+(2*wall),
					 (
						 "bottom_nut" == standoff_type ?
						 (unf_nut_diameter(nut_v) + (2*wall)) :
						 (
							 "bottom_hst" == standoff_type ?
							 (unf_hst_diameter(hst_v) + (2*wall)) : 0
						 )
					 )
	);

	if(positive){
		base_z = max(
			base_ext,
			(
				"bottom_nut" == standoff_type ?
				(unf_nut_height(nut_v) + wall) :
				(
					"bottom_heatset" == standoff_type ?
					(unf_hst_length(hst_v) + wall) :
					0
				)
			)
		);
		base_offset = max(0, base_z-wall_ext);
		
		top_z = "top_heatset" == standoff_type ? (unf_hst_length(hst_v) + wall) : 0;
		top_d = max(bolt_d+(2*wall),
						(
							"top_heatset" == standoff_type ? (unf_hst_diameter(hst_v) + wall) : 0
						)
		);
		if (0 < base_z){
			translate([0, 0, -wall_ext]){
				cylinder(d=base_d, h=base_z);
			}
		}
		
		translate([0, 0, base_offset]){
			cylinder(h=height-(top_z+base_offset), d1=base_d, d2=top_d);
		}
		
		if (0 < top_z){
			translate([0, 0, height-top_z]){
				cylinder(d=top_d, h=top_z);
			}
		}
	} else {
		translate([0, 0, -(base_ext + $over)]){
			cylinder(h=height+base_ext, d=bolt_d+(2*$over));
		}
		if("bottom_nut" == standoff_type){
			translate([0, 0, -base_ext]){
				unf_nut(size=nut_v, ext=$over);
			}
		} else if("side_nut" == standoff_type){
			unf_nut(size=nut_v, ext=0);
			translate([0, -unf_nut_small_d(nut_v)/2, 0]){
				cube([$over+(base_d/2), unf_nut_small_d(nut_v), unf_nut_height(nut_v)]);
			}
		}
	}
}

if (part == "standoff"){
	difference(){
		*standoff(
			type = "bottom_heatset",
			bolt_size = standoff_bolt_size,
			base_ext = 2.5,
			height = standoff_height,
			wall_ext = standoff_ext,
			heatset_length = "medium",
			positive = true,
		);
		#standoff(
			type = "bottom_heatset",
			bolt_size = standoff_bolt_size,
			base_ext = 2.5,
			height = standoff_height,
			wall_ext = standoff_ext,
			heatset_length = "medium",
			positive = false,
		);
	}
 }

if (part == "rak19007"){
	rak19007(
		show_board = show_board,
		standoff_height = standoff_height,
		pcb_color = pcb_color,
		subtraction_color = subtraction_color,
		support_color = support_color,
	);
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
