// LibFile: unfy_construction.scad
//   UnfyOpenSCADLib Copyright Leif Burrow 2026
//   kc8rwr@unfy.us
//   unforgettability.net
//   .
//   This file is part of UnfyOpenSCADLib.
//   .
//   unfy_construction contains modules for generating an "under construction" scene: a sign with a custom
//   message, striped barricades (sawhorses), drums (barrels), traffic cones and warning lights. Useful as a
//   placeholder in an unfinished design or just for fun.
//   .
//   This file was created with help from Claude.

use <unfy_shapes.scad>

part = "Scene"; //["Scene", "Sign", "Barricade", "Barrel", "Cone", "Light"]

/* [ Message ] */
message = "UNDER|CONSTRUCTION";
// Multiple lines may be separated by this character
line_separator = "|";
font = "Liberation Sans:style=Bold";

/* [ Details ] */
show_sign = true;
show_barricade = true;
show_barrels = true;
barrel_count = 2; //[0:6]
show_cones = true;
cone_count = 3; //[0:9]
show_lights = true;
show_stripes = true;

/* [ Dimensions ] */
sign_shape = "diamond"; //["diamond", "rectangle"]
sign_size = 100;
sign_height = 60;
barricade_length = 160;
barricade_height = 70;
barrel_diameter = 45;
barrel_height = 70;
cone_height = 45;
light_size = 10;

/* [ Colors ] */
sign_color = "Orange"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]
text_color = "Black"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]
stripe_color = "OrangeRed"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]
stripe_alt_color = "White"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]
frame_color = "DimGray"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]
base_color = "Black"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]
lens_color = "Gold"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

$over = 0.01;

$fn = $preview ? 36 : 180;

// Function: unf_cnst_split
// Usage:
//   lines = unf_cnst_split(str, sep);
// Description:
//   Splits a string into a list of strings on a single separator character. A list passed in is returned unchanged.
// Arguments:
//   ---
//   str = the string to split, or a list of strings
//   sep = the single-character separator ("|")
function unf_cnst_split(str, sep = "|", i = 0, cur = "") =
	is_list(str) ? str :
	i >= len(str) ? [cur] :
	str[i] == sep ? concat([cur], unf_cnst_split(str, sep, i+1, "")) :
	unf_cnst_split(str, sep, i+1, str(cur, str[i]));

// Module: unf_cnst_text_block
// Usage:
//   unf_cnst_text_block(&lt;args&gt;);
// Description:
//   Creates 2d, centered, multi-line text scaled to fit within the given width and height.
// Arguments:
//   ---
//   lines = a list of strings, one per line
//   size = [width, height] of the area the text must fit within
//   font = font to use ("Liberation Sans:style=Bold")
module unf_cnst_text_block(lines, size, font = "Liberation Sans:style=Bold"){
	let(count = len(lines),
		 longest = max([ for (l = lines) len(l) ]),
		 line_h = size.y / count,
		 // ~0.95 em average width per bold capital (conservative so wide letters still fit), 0.7 of the line pitch for glyph height
		 txt_size = min(line_h * 0.7, size.x / (max(1, longest) * 0.95))){
		for (i = [0 : count - 1]){
			translate([0, (((count - 1) / 2) - i) * line_h, 0]){
				text(lines[i], size = txt_size, font = font, halign = "center", valign = "center");
			}
		}
	}
}

// Module: unf_cnst_striped_board
// Usage:
//   unf_cnst_striped_board(&lt;args&gt;);
// Description:
//   Creates a flat board with diagonal hazard stripes. The board lies in the XZ plane, centered on X, with its front face at y=0 and its back at y=size.y.
// Arguments:
//   ---
//   size = [length, thickness, height] of the board
//   stripe_width = width of each stripe measured along the board (size.z)
//   angle = angle of the stripes (45)
//   stripes = true for stripes, false for a plain board (true)
//   stripe_color = color of the stripes ("OrangeRed")
//   stripe_alt_color = color between the stripes ("White")
// Figure(Spin;VPD=250;NoAxes): defaults
//   $over = 0.01;
//   $fn = 36;
//   use <unfy_construction.scad>;
//   unf_cnst_striped_board(size=[150, 3, 20]);
module unf_cnst_striped_board(size = [150, 3, 20], stripe_width = false, angle = 45, stripes = true, stripe_color = "OrangeRed", stripe_alt_color = "White"){
	let(stripe_width = stripe_width ? stripe_width : size.z,
		 count = ceil((size.x + size.z) / stripe_width) + 2){
		rotate([90, 0, 0]){
			translate([0, 0, -size.y]){
				if (stripes){
					color(stripe_color){
						linear_extrude(size.y){
							intersection(){
								translate([-size.x/2, 0]){
									square([size.x, size.z]);
								}
								for (i = [-count/2 : count/2]){
									translate([i * 2 * stripe_width, 0]){
										rotate(angle){
											translate([-stripe_width/2, -2*size.z]){
												square([stripe_width, 4*size.z]);
											}
										}
									}
								}
							}
						}
					}
					color(stripe_alt_color){
						linear_extrude(size.y){
							difference(){
								translate([-size.x/2, 0]){
									square([size.x, size.z]);
								}
								for (i = [-count/2 : count/2]){
									translate([i * 2 * stripe_width, 0]){
										rotate(angle){
											translate([-stripe_width/2, -2*size.z]){
												square([stripe_width, 4*size.z]);
											}
										}
									}
								}
							}
						}
					}
				}else{
					color(stripe_color){
						translate([-size.x/2, 0, 0]){
							cube([size.x, size.z, size.y]);
						}
					}
				}
			}
		}
	}
}

// Module: unf_construction_light
// Usage:
//   unf_construction_light(&lt;args&gt;);
// Description:
//   Creates a barricade warning light: a housing with a domed lens facing forward (-Y). The origin is at the bottom center of the housing.
// Arguments:
//   ---
//   size = width of the housing, everything else is scaled from this (10)
//   housing_color = color of the housing ("Black")
//   lens_color = color of the lens ("Gold")
// Figure(Spin;VPD=60;NoAxes): defaults
//   $over = 0.01;
//   $fn = 36;
//   use <unfy_construction.scad>;
//   unf_construction_light();
module unf_construction_light(size = 10, housing_color = "Black", lens_color = "Gold"){
	let(depth = size * 0.5,
		 lens_r = size * 0.42){
		color(housing_color){
			// mounting stem
			translate([0, 0, 0]){
				cylinder(d = size * 0.25, h = size * 0.3);
			}
			translate([0, 0, size * 0.3]){
				translate([-size/2, -depth/2, 0]){
					unf_roundedCuboid(size = [size, depth, size], corners = size * 0.1, edge_r = 0);
				}
			}
		}
		color(lens_color){
			translate([0, -depth/2 + $over, size * 0.8]){
				rotate([90, 0, 0]){
					scale([1, 1, 0.5]){
						difference(){
							sphere(r = lens_r);
							translate([0, 0, -lens_r]){
								cylinder(r = lens_r + $over, h = lens_r);
							}
						}
					}
				}
			}
		}
	}
}

// Module: unf_construction_sign
// Usage:
//   unf_construction_sign(&lt;args&gt;);
// Description:
//   Creates a road-work style sign with a message on a post and folding X base. The sign faces -Y and the origin is at the center of the base on the ground.
// Arguments:
//   ---
//   message = text to show, either a string with lines separated by line_separator or a list of strings ("UNDER CONSTRUCTION")
//   size = side length of a diamond sign or width of a rectangular sign (100)
//   shape = "diamond" or "rectangle" ("diamond")
//   height = height of the bottom of the sign above the ground (60)
//   thickness = thickness of the sign panel (2)
//   line_separator = character separating lines in message ("|")
//   font = font for the message ("Liberation Sans:style=Bold")
//   sign_color = color of the sign panel ("Orange")
//   text_color = color of the message and border ("Black")
//   frame_color = color of the post and base ("DimGray")
// Figure(Spin;VPD=350;VPT=[0,0,80];NoAxes): defaults
//   $over = 0.01;
//   $fn = 36;
//   use <unfy_construction.scad>;
//   unf_construction_sign();
// Figure(Spin;VPD=350;VPT=[0,0,80];NoAxes): rectangle, multi-line
//   $over = 0.01;
//   $fn = 36;
//   use <unfy_construction.scad>;
//   unf_construction_sign(message="WORK|IN|PROGRESS", shape="rectangle");
module unf_construction_sign(message = "UNDER|CONSTRUCTION",
									  size = 100,
									  shape = "diamond",
									  height = 60,
									  thickness = 2,
									  line_separator = "|",
									  font = "Liberation Sans:style=Bold",
									  sign_color = "Orange",
									  text_color = "Black",
									  frame_color = "DimGray"){
	let(lines = unf_cnst_split(message, line_separator),
		 diamond = ("diamond" == shape),
		 panel_w = diamond ? size * sqrt(2) : size,
		 panel_h = diamond ? size * sqrt(2) : size * 0.6,
		 border = size * 0.03,
		 relief = max(0.4, thickness * 0.3),
		 // largest centered rectangle comfortably inside the border: half of each diagonal for a diamond
		 text_area = diamond ? [panel_w * 0.6, panel_h * 0.3] : [panel_w - 6*border, panel_h - 6*border],
		 center_z = height + panel_h/2,
		 post_w = max(3, size * 0.06),
		 foot_l = size * 0.8){

		translate([0, 0, center_z]){
			rotate([90, 0, 0]){
				// panel, back face at y=thickness
				translate([0, 0, -thickness]){
					color(sign_color){
						linear_extrude(thickness){
							unf_cnst_sign_outline(diamond, size, panel_w, panel_h, 0);
						}
					}
					// border and message stand proud of the front face
					color(text_color){
						translate([0, 0, thickness - $over]){
							linear_extrude(relief + $over){
								difference(){
									unf_cnst_sign_outline(diamond, size, panel_w, panel_h, border);
									unf_cnst_sign_outline(diamond, size, panel_w, panel_h, 2*border);
								}
								unf_cnst_text_block(lines, text_area, font);
							}
						}
					}
				}
			}
		}

		color(frame_color){
			// post behind the panel
			translate([-post_w/2, thickness, 0]){
				cube([post_w, post_w, center_z + panel_h * 0.3]);
			}
			// folding X base
			for (a = [45, -45]){
				translate([0, thickness + post_w/2, post_w/4]){
					rotate([0, 0, a]){
						cube([foot_l, post_w, post_w/2], center = true);
					}
				}
			}
		}
	}
}

// Outline of the sign panel, inset by the given amount.
module unf_cnst_sign_outline(diamond, size, panel_w, panel_h, inset){
	if (diamond){
		rotate(45){
			offset(r = size * 0.04){
				square(size - 2*(inset * sqrt(2)) - 2*size*0.04, center = true);
			}
		}
	}else{
		offset(r = size * 0.03){
			square([panel_w - 2*inset - 2*size*0.03, panel_h - 2*inset - 2*size*0.03], center = true);
		}
	}
}

// Module: unf_construction_barricade
// Usage:
//   unf_construction_barricade(&lt;args&gt;);
// Description:
//   Creates a sawhorse style barricade: a striped board atop two A-frame leg sets, optionally with a warning light. The board faces -Y and the origin is at the center of the barricade on the ground.
// Arguments:
//   ---
//   length = length of the board (160)
//   height = height to the top of the board (70)
//   board_height = height of the striped board (height * 0.3)
//   thickness = thickness of the board and legs (3)
//   stripes = show hazard stripes (true)
//   light = show a warning light on one end (true)
//   light_size = size of the warning light (10)
//   stripe_color = color of the stripes ("OrangeRed")
//   stripe_alt_color = color between the stripes ("White")
//   frame_color = color of the legs ("DimGray")
//   lens_color = color of the light's lens ("Gold")
// Figure(Spin;VPD=350;VPT=[0,0,35];NoAxes): defaults
//   $over = 0.01;
//   $fn = 36;
//   use <unfy_construction.scad>;
//   unf_construction_barricade();
module unf_construction_barricade(length = 160,
											 height = 70,
											 board_height = false,
											 thickness = 3,
											 stripes = true,
											 light = true,
											 light_size = 10,
											 stripe_color = "OrangeRed",
											 stripe_alt_color = "White",
											 frame_color = "DimGray",
											 lens_color = "Gold"){
	let(board_height = board_height ? board_height : height * 0.3,
		 leg_w = thickness * 2,
		 splay = height * 0.25,
		 leg_l = sqrt(pow(height, 2) + pow(splay, 2)),
		 leg_a = atan(splay / height),
		 leg_x = length/2 - length * 0.15){

		// board, back face against the front of the legs
		translate([0, -leg_w/2, height - board_height]){
			unf_cnst_striped_board(size = [length, thickness, board_height], stripes = stripes, stripe_color = stripe_color, stripe_alt_color = stripe_alt_color);
		}

		color(frame_color){
			for (x = [-leg_x, leg_x]){
				translate([x, 0, 0]){
					// A-frame legs splayed front and back
					for (s = [-1, 1]){
						translate([0, 0, height]){
							rotate([s * leg_a, 0, 0]){
								translate([-thickness/2, -leg_w/2, -leg_l]){
									cube([thickness, leg_w, leg_l]);
								}
							}
						}
					}
					// cross brace
					translate([-thickness/2, -splay * 0.6, height * 0.35]){
						cube([thickness, splay * 1.2, leg_w]);
					}
					// top cap
					translate([-thickness/2, -leg_w/2, height - leg_w]){
						cube([thickness, leg_w, leg_w]);
					}
				}
			}
		}

		if (light){
			translate([leg_x, 0, height]){
				unf_construction_light(size = light_size, lens_color = lens_color);
			}
		}
	}
}

// Module: unf_construction_barrel
// Usage:
//   unf_construction_barrel(&lt;args&gt;);
// Description:
//   Creates a traffic drum (barrel) with alternating reflective bands, a weighted base ring and optionally a warning light on top. The origin is at the center of the base on the ground.
// Arguments:
//   ---
//   diameter = diameter at the base of the drum (45)
//   height = height of the drum, not including the light (70)
//   bands = number of colored bands, alternating with stripe_alt_color (4)
//   light = show a warning light on top (true)
//   light_size = size of the warning light (10)
//   stripe_color = color of the bands ("OrangeRed")
//   stripe_alt_color = color between the bands ("White")
//   base_color = color of the base ring ("Black")
//   lens_color = color of the light's lens ("Gold")
// Figure(Spin;VPD=200;VPT=[0,0,40];NoAxes): defaults
//   $over = 0.01;
//   $fn = 36;
//   use <unfy_construction.scad>;
//   unf_construction_barrel();
module unf_construction_barrel(diameter = 45,
										 height = 70,
										 bands = 4,
										 light = true,
										 light_size = 10,
										 stripe_color = "OrangeRed",
										 stripe_alt_color = "White",
										 base_color = "Black",
										 lens_color = "Gold"){
	let(base_h = height * 0.08,
		 top_d = diameter * 0.85,
		 body_h = height - base_h,
		 sections = bands * 2,
		 section_h = body_h / sections,
		 d_at = function (z) diameter + (top_d - diameter) * (z / body_h)){

		color(base_color){
			cylinder(d = diameter * 1.25, h = base_h);
		}

		translate([0, 0, base_h]){
			for (i = [0 : sections - 1]){
				color((0 == i % 2) ? stripe_color : stripe_alt_color){
					translate([0, 0, i * section_h]){
						cylinder(d1 = d_at(i * section_h), d2 = d_at((i + 1) * section_h), h = section_h);
					}
				}
			}
			// lid
			color(stripe_color){
				translate([0, 0, body_h - $over]){
					unf_roundedCylinder(d = top_d, h = height * 0.03 + $over, edge2_r = height * 0.015);
				}
			}
		}

		if (light){
			translate([0, 0, height + height * 0.03]){
				unf_construction_light(size = light_size, lens_color = lens_color);
			}
		}
	}
}

// Module: unf_construction_cone
// Usage:
//   unf_construction_cone(&lt;args&gt;);
// Description:
//   Creates a traffic cone on a square base with a reflective collar. The origin is at the center of the base on the ground.
// Arguments:
//   ---
//   height = overall height (45)
//   cone_color = color of the cone ("OrangeRed")
//   band_color = color of the reflective collar ("White")
//   base_color = color of the base ("Black")
// Figure(Spin;VPD=150;VPT=[0,0,20];NoAxes): defaults
//   $over = 0.01;
//   $fn = 36;
//   use <unfy_construction.scad>;
//   unf_construction_cone();
module unf_construction_cone(height = 45, cone_color = "OrangeRed", band_color = "White", base_color = "Black"){
	let(base_w = height * 0.65,
		 base_h = height * 0.05,
		 bottom_d = height * 0.5,
		 top_d = height * 0.08,
		 cone_h = height - base_h,
		 d_at = function (z) bottom_d + (top_d - bottom_d) * (z / cone_h),
		 band_lo = cone_h * 0.45,
		 band_hi = cone_h * 0.65){

		color(base_color){
			translate([-base_w/2, -base_w/2, 0]){
				unf_roundedCuboid(size = [base_w, base_w, base_h], corners = base_w * 0.15, edge_r = 0);
			}
		}
		translate([0, 0, base_h - $over]){
			color(cone_color){
				cylinder(d1 = bottom_d, d2 = d_at(band_lo), h = band_lo);
				translate([0, 0, band_hi]){
					cylinder(d1 = d_at(band_hi), d2 = top_d, h = cone_h - band_hi);
				}
			}
			color(band_color){
				translate([0, 0, band_lo]){
					cylinder(d1 = d_at(band_lo), d2 = d_at(band_hi), h = band_hi - band_lo);
				}
			}
		}
	}
}

// Module: unf_construction_scene
// Usage:
//   unf_construction_scene(&lt;args&gt;);
// Description:
//   Creates a complete "under construction" scene. A sign stands behind a barricade which is flanked by barrels with a row of cones in front. Each detail may be turned on or off. The scene faces -Y and the origin is at the center of the barricade on the ground.
// Arguments:
//   ---
//   message = text on the sign, either a string with lines separated by line_separator or a list of strings ("UNDER CONSTRUCTION")
//   show_sign = show the sign (true)
//   show_barricade = show the barricade (true)
//   show_barrels = show barrels beside the barricade (true)
//   barrel_count = number of barrels, alternating sides (2)
//   show_cones = show a row of cones in front (true)
//   cone_count = number of cones (3)
//   show_lights = show warning lights on the barricade and barrels (true)
//   show_stripes = show hazard stripes on the barricade (true)
//   sign_shape = "diamond" or "rectangle" ("diamond")
//   sign_size = side of a diamond sign or width of a rectangular one (100)
//   sign_height = height of the bottom of the sign above the ground (60)
//   barricade_length = length of the barricade (160)
//   barricade_height = height of the barricade (70)
//   barrel_diameter = diameter of the barrels (45)
//   barrel_height = height of the barrels (70)
//   cone_height = height of the cones (45)
//   light_size = size of the warning lights (10)
//   line_separator = character separating lines in message ("|")
//   font = font for the message ("Liberation Sans:style=Bold")
//   sign_color = color of the sign ("Orange")
//   text_color = color of the message and sign border ("Black")
//   stripe_color = color of stripes, bands and cones ("OrangeRed")
//   stripe_alt_color = color between stripes and bands ("White")
//   frame_color = color of posts and legs ("DimGray")
//   base_color = color of barrel and cone bases ("Black")
//   lens_color = color of the warning light lenses ("Gold")
// Figure(Spin;VPD=700;VPT=[0,0,60];NoAxes): defaults
//   $over = 0.01;
//   $fn = 36;
//   use <unfy_construction.scad>;
//   unf_construction_scene();
// Figure(Spin;VPD=500;VPT=[0,0,50];NoAxes): sign only, custom message
//   $over = 0.01;
//   $fn = 36;
//   use <unfy_construction.scad>;
//   unf_construction_scene(message="COMING|SOON", show_barricade=false, show_barrels=false, show_cones=false);
module unf_construction_scene(message = "UNDER|CONSTRUCTION",
										show_sign = true,
										show_barricade = true,
										show_barrels = true,
										barrel_count = 2,
										show_cones = true,
										cone_count = 3,
										show_lights = true,
										show_stripes = true,
										sign_shape = "diamond",
										sign_size = 100,
										sign_height = 60,
										barricade_length = 160,
										barricade_height = 70,
										barrel_diameter = 45,
										barrel_height = 70,
										cone_height = 45,
										light_size = 10,
										line_separator = "|",
										font = "Liberation Sans:style=Bold",
										sign_color = "Orange",
										text_color = "Black",
										stripe_color = "OrangeRed",
										stripe_alt_color = "White",
										frame_color = "DimGray",
										base_color = "Black",
										lens_color = "Gold"){
	let(depth = barricade_height * 0.5, // front-to-back footprint of the barricade
		 barrel_pitch = barrel_diameter * 1.4,
		 cone_pitch = cone_height * 0.9,
		 cone_y = -(depth/2 + cone_height * 0.6)){

		if (show_sign){
			translate([0, show_barricade ? depth/2 + sign_size * 0.4 : 0, 0]){
				unf_construction_sign(message = message,
											 size = sign_size,
											 shape = sign_shape,
											 height = sign_height,
											 line_separator = line_separator,
											 font = font,
											 sign_color = sign_color,
											 text_color = text_color,
											 frame_color = frame_color);
			}
		}

		if (show_barricade){
			unf_construction_barricade(length = barricade_length,
												height = barricade_height,
												stripes = show_stripes,
												light = show_lights,
												light_size = light_size,
												stripe_color = stripe_color,
												stripe_alt_color = stripe_alt_color,
												frame_color = frame_color,
												lens_color = lens_color);
		}

		if (show_barrels && barrel_count > 0){
			let(inner_x = (show_barricade ? barricade_length/2 : sign_size * 0.6) + barrel_pitch/2){
				for (i = [0 : barrel_count - 1]){
					// alternate right, left, working outward
					translate([(0 == i % 2 ? 1 : -1) * (inner_x + floor(i/2) * barrel_pitch), 0, 0]){
						unf_construction_barrel(diameter = barrel_diameter,
														height = barrel_height,
														light = show_lights,
														light_size = light_size,
														stripe_color = stripe_color,
														stripe_alt_color = stripe_alt_color,
														base_color = base_color,
														lens_color = lens_color);
					}
				}
			}
		}

		if (show_cones && cone_count > 0){
			for (i = [0 : cone_count - 1]){
				translate([(i - (cone_count - 1)/2) * cone_pitch, cone_y, 0]){
					unf_construction_cone(height = cone_height,
												 cone_color = stripe_color,
												 band_color = stripe_alt_color,
												 base_color = base_color);
				}
			}
		}
	}
}

if ("Scene" == part){
	unf_construction_scene(message = message,
								  show_sign = show_sign,
								  show_barricade = show_barricade,
								  show_barrels = show_barrels,
								  barrel_count = barrel_count,
								  show_cones = show_cones,
								  cone_count = cone_count,
								  show_lights = show_lights,
								  show_stripes = show_stripes,
								  sign_shape = sign_shape,
								  sign_size = sign_size,
								  sign_height = sign_height,
								  barricade_length = barricade_length,
								  barricade_height = barricade_height,
								  barrel_diameter = barrel_diameter,
								  barrel_height = barrel_height,
								  cone_height = cone_height,
								  light_size = light_size,
								  line_separator = line_separator,
								  font = font,
								  sign_color = sign_color,
								  text_color = text_color,
								  stripe_color = stripe_color,
								  stripe_alt_color = stripe_alt_color,
								  frame_color = frame_color,
								  base_color = base_color,
								  lens_color = lens_color
	);
}

if ("Sign" == part){
	unf_construction_sign(message = message,
								 size = sign_size,
								 shape = sign_shape,
								 height = sign_height,
								 line_separator = line_separator,
								 font = font,
								 sign_color = sign_color,
								 text_color = text_color,
								 frame_color = frame_color
	);
}

if ("Barricade" == part){
	unf_construction_barricade(length = barricade_length,
										height = barricade_height,
										stripes = show_stripes,
										light = show_lights,
										light_size = light_size,
										stripe_color = stripe_color,
										stripe_alt_color = stripe_alt_color,
										frame_color = frame_color,
										lens_color = lens_color
	);
}

if ("Barrel" == part){
	unf_construction_barrel(diameter = barrel_diameter,
									height = barrel_height,
									light = show_lights,
									light_size = light_size,
									stripe_color = stripe_color,
									stripe_alt_color = stripe_alt_color,
									base_color = base_color,
									lens_color = lens_color
	);
}

if ("Cone" == part){
	unf_construction_cone(height = cone_height,
								 cone_color = stripe_color,
								 band_color = stripe_alt_color,
								 base_color = base_color
	);
}

if ("Light" == part){
	unf_construction_light(size = light_size, lens_color = lens_color);
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
