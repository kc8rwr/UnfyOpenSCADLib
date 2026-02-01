// LibFile: unfy_cablemanagement.scad
//   UnfyOpenSCADLib Copyright Leif Burrow 2026
//   kc8rwr@unfy.us
//   unforgettability.net
//    
//   This file is part of UnfyOpenSCADLib.
//    
//   UnfyOpenSCADLib is free software: you can redistribute it and/or modify it under the terms of the
//   GNU General Public License as published by the Free Software Foundation, either version 3 of
//   the License, or (at your option) any later version.
//   
//   UnfyOpenSCADLib is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
//   without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
//   See the GNU General Public License for more details.
//   
//   You should have received a copy of the GNU General Public License along with UnfyOpenSCADLib.
//   If not, see <https://www.gnu.org/licenses/>.
//

use <unfy_fasteners.scad>
use <unfy_shapes.scad>

part="CableClip"; // ["CableClip", "ClipInStrainRelief"]
gap = 3;
wall = 1.5;
support_skin = 0.9;

body_color = "Blue"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

support_color = "Yellow"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

subtraction_color = "Yellow"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

parent_color = "Yellow"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]
$over = 0.01;


/* [Cable Clip] */
clip_cable_d = 7.5;
bolt = "M3";
hole_ext = 3;
tooth_length = 0.5; // [0:0.1:3]
// will receive fewer teeth if they don't fit
tooth_count = 4;
support = "none"; // ["horizontal", "vertical", "none"]
center = true;

/* [Clip In Strain Relief] */
strain_relief_cable_d = 2.5;
num_conductors = 2;
inside_diameter = 12;
inside_length = 2.5;
waste_diameter = 8;
waste_length=3;
outside_length = 7;
outside_diameter = 12;
edge_r = 2;

$fn = $preview ? 36 : 360;

// Module: unf_cableClip_positive
// Usage:
//   unf_cableClip_positive(&lt;args&gt;);
// Description:
//   Just the positive part of a cable clip.
// Arguments:
//   ---
//   cable_d = cable diameter (7.5)
//   gap = width of the gap in the circle, which gets pinched shut to squeeze the cable (3)
//   bolt = bolt size for closing the clip (M3)
//   tooth_length = optional teeth to grip the cable, this is how far they stick inward (0.5)
//   tooth_count = how many teeth (4)
//   wall = minimum thickness of parts (1.4)
//   support = Optional support for printing, may be vertical, horizontal or none (none)
//   support_skin = thickness of support skin, if generating supports, probably good to use the minimum your slicer will include (0.6)
//   body_color = color of the generated part or false for default (blue)
//   support_color = color of generated supports or false for default (yellow)
//   center = center the part (true)
// Figure(Spin;VPD=75;VPT=[0, 0, 5];NoAxes):
//   $over = 0.01;
//   $fn = 36;
//   use <unfy_cablemanagement.scad>;
//   unf_cableClip_Positive();
module unf_cableClip_Positive(cable_d=7.5, gap=3, bolt="M3", tooth_length=0.5, tooth_count=4, wall=1.5, support="none", support_skin=0.6, body_color="blue", support_color="yellow", subtraction_color="yellow", center=true){
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
			color(subtraction_color){
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

// Module: unf_cableClip_Negative
// Usage:
//   unf_cableClip_Negative(&lt;args&gt;);
// Description:
//   Just the negative part of a cable clip. Really, this is just a cylinder to extend the cable hole into the object the clip attaches to.
//   What is useful here is that if rendered in the same location as the positive part it will locate the hole in the correct place.
// Arguments:
//   ---
//   cable_d = cable diameter (7.5)
//   bolt = bolt size for closing the clip (M3)
//   wall = minimum thickness of parts (1.4)
//   hole_ext = how far to extend the cable hole in (3)
//   center = center the part (true)
// Figure(NoAxes):
//   $over = 0.01;
//   $fn = 360;
//   use <unfy_cablemanagement.scad>;
//   color("yellow"){
//      unf_cableClip_Negative();
//   }
module unf_cableClip_Negative(cable_d=2.5, bolt="M3", wall=1.5, hole_ext=3, center=true, subtraction_color="yellow"){
	nut_v = unf_nut_v(bolt);

	nut_t = unf_nut_height(nut_v);
	nut_tab_t = nut_t + wall;

	center_x_offset = center ? 0 : (wall+(cable_d/2));
	center_y_offset = center ? 0 : nut_tab_t+(gap/2);

	color(subtraction_color){
		translate([center_x_offset, center_y_offset, -hole_ext]){
			cylinder(d=cable_d, h=hole_ext+wall+$over);
		}
	}
}

// Module: unf_cableClip
// Usage:
//   unf_cableClip(&lt;args&gt;){<br/>&nbsp;&nbsp;&nbsp;child_stuff();<br/>}
// Description:
//   Operator module that uses unf_cableClip_Positive() and unf_cableClip_Negative() to place a cable clip on and a cable hole through the child object(s).
// Arguments:
//   ---
//   location = where to place the clip relative to the child/childrens' origin. ([0, 0, 0])
//   rotation = how to orientate the clip releative to the child/childen objects (0)
//   cable_d = cable diameter (7.5)
//   bolt = bolt size for closing the clip (M3)
//   gap = width of the gap in the circle, which gets pinched shut to squeeze the cable (3)
//   hole_ext = how far to extend the cable hole into the child/children (3)
//   tooth_length = optional teeth to grip the cable, this is how far they stick inward (0.5)
//   tooth_count = how many teeth (4)
//   support = optional support for printing, may be vertical, horizontal or none (none)
//   support_skin = thickness of support skin, if generating supports, probably good to use the minimum your slicer will include (0.6)
//   wall = minimum thickness of parts (1.4)
//   body_color = color of the generated part or false for default (blue)
//   support_color = color of generated supports or false for default (yellow)
//   center = center the part (true)
// Figure(Spin;VPD=75;VPT=[0, 0, 5];NoAxes):
//   $over = 0.01;
//   $fn = 36;
//   wall = 1.5;
//   use <unfy_cablemanagement.scad>;
//   unf_cableClip(location=[0, 0, wall]){
//      translate([-10, -7.5, 0]){
//         color("yellow"){
//            cube([30, 15, wall]);
//         }
//      }
//   }
module unf_cableClip(location=[0, 0, 0], rotation=0, cable_d=7.5, bolt="M3", gap=3, hole_ext=3, tooth_length=0.5, tooth_count=4, support="none", support_skin=0.6, wall=1.4, body_color="blue", support_color="yellow", subtraction_color="yellow", center=true){
	difference(){
		children();
		translate(location){
			rotate(rotation){
				unf_cableClip_Negative(cable_d = cable_d,
											  bolt = bolt,
											  wall = wall,
											  hole_ext=hole_ext,
											  center = center,
											  subtraction_color = subtraction_color);
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
										  subtraction_color = subtraction_color,
										  center = center);
		}
	}
}

// Module: unf_clipInStrainRelief
// Usage:
//   unf_clipInStrainRelief(&lt;args&gt;);
// Description:
//   A cable strain relief that can be closed within a hole between two walls of a chassis.
// Arguments:
//   ---
//   cable_d = cable diameter (2.5)
//   num_conductors = number of conductors or separate cables to pass through (2)
//   inside_diameter = diameter of non-tapered end that goes inside the chasis (12)
//   inside_length = length of non-tapered end that goes inside the chasis (2.5)
//   waste_diameter = diameter of narrow part that gets gripped by the chassis (6)
//   waste_length = length of the narrow part that gets gripped by the chassis (3)
//   outside_length = length of the tapered end that goes outside the chasis (7)
//   outside_diameter = diameter of the tapered end that goes outside the chasis (12)
//   wall = minimum wall thickness (1.5)
//   body_color = color of the generated part or false for default (blue)
//   support_skin = thickness of support skin to print along the outside edge of the waste for preventing overhang (0.6)
//   support_color = color of generated supports or false for default (yellow)
//   edge_r = radius of rounded edges (2)
// Figure(Anim;VPD=75;NoAxes):
//   wall = 2;
//   $over = 0.01;
//   $fn = 36;
//   use <unfy_cablemanagement.scad>;
//   module chassis(x, y, diameter){
//     color("Yellow"){
//   		difference(){
//   			cube([x, wall, y]);
//   			translate([x/2, wall+$over, 0]){
//   				rotate([90, 0, 0]){
//   					cylinder(d=diameter, h=wall+(2*$over));
//   				}
//   			}
//   		}
//   	}
//   }
//   translate([-7.5, 0, 7 * (1-$t)]){
//   	chassis(15, 7, 8);
//   }
//   translate([0, 2*wall, 0]){
//   	rotate([90, 0, 0]){
//   		unf_clipInStrainRelief(support_skin=0, inside_length=wall, waste_length=wall, body_color="Blue", subtraction_color="Yellow");
//   	}
//   }
//   translate([7.5, 0, 0]){
//   	rotate([0, 180, 0]){
//   		chassis(15, 7, 8);
//   	}
//   }
//   for (x = [-1, 1]){
//   	translate([x, 2.5+(2*wall), 0]){
//   		rotate([90, 0, 0]){
//   			color ("Black") cylinder(d=2, h=12+(2*wall));
//   			color("Yellow") translate([0, 0, -2]) cylinder(d=1.5, h=16+(2*wall));
//   		}
//   	}
//   }
// Figure(Spin;VPD=50;VPT=[0, 0, 5];NoAxes):
//   $over = 0.01;
//   $fn = 36;
//   wall = 1.5;
//   use <unfy_cablemanagement.scad>;
//   unf_clipInStrainRelief(support_skin=0);
module unf_clipInStrainRelief(
	cable_d = 2.5,
	num_conductors = 2,
	inside_diameter = 12,
	inside_length = 2.5,
	waste_diameter = 6,
	waste_length = 3,
	outside_length = 7,
	outside_diameter = 12,
	wall = 1.5,
	body_color = "Blue",
	support_skin = 0.6,
	support_color = "Yellow",
	subtraction_color = "yellow",
	edge_r = 2
){
	outside_x = (2*wall) + (num_conductors * cable_d);
	outside_y = (2*wall) + cable_d;
	echo(str("outside_x: ", outside_x));
	echo(str("outside_y: ", outside_y));

	module inner(){
		cylinder(d=inside_diameter, h=inside_length);
		cylinder(d=waste_diameter, h=inside_length+waste_length+$over);
		translate([0, 0, inside_length+waste_length]){
			unf_bezier_frustrum(
				base_d = outside_diameter,
				end_edge_r = edge_r,
				end_dx = outside_x,
				end_dy = outside_y,
				length = outside_length
			);
		}
	}

	difference(){
		union(){
			//main body
			color(body_color){
				inner();
			}
			//support
			if (0 < support_skin){
				color(support_color){
					linear_extrude(inside_length+waste_length){
						difference(){
							circle(d=inside_diameter-$over);
							circle(d=inside_diameter-(2*support_skin)-$over);
						}
					}
				}
			}
		} //end positive part
		// cable
		color(subtraction_color){
			translate([(cable_d/2) - (cable_d * num_conductors / 2), 0, -$over]){
				linear_extrude((2*$over) + inside_length + waste_length + outside_length){
					union(){
						for (x = [0:num_conductors-1]){
							translate([cable_d * x, 0]){
								circle(d=cable_d);
							}
						}
						translate([0, -cable_d/6]){
							square([cable_d*(num_conductors-1), cable_d/3]);
						}
					}
				}
			}
		}
	}
}
	
if (part == "ClipInStrainRelief"){
	unf_clipInStrainRelief(
		cable_d = strain_relief_cable_d,
		num_conductors = num_conductors,
		inside_diameter = inside_diameter,
		inside_length = inside_length,
		waste_diameter = waste_diameter,
		waste_length = waste_length,
		outside_length = outside_length,
		outside_diameter = outside_diameter,
		wall = wall,
		body_color = body_color,
		support_skin = support_skin,
		support_color = support_color,
		subtraction_color = subtraction_color,
		edge_r = edge_r
	);
 }

if (part == "CableClip"){
	unf_cableClip(location=[0, 0, wall],
					  cable_d = clip_cable_d,
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
					  support_color = support_color,
					  subtraction_color = subtraction_color){
		color(parent_color){
			translate(center ? [-10, -7.5, 0] : [-5, -3.75, 0])
				color(support_color){
				cube([30, 15, wall]);
			}
		}
	}
 }



