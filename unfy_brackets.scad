// - Under construction - Not yet functional
//
// UnfyOpenSCADLib Copyright Leif Burrow 2022
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

/*[ Main ] */
width = 50;
thickness = 2;
fillet = 2;
rounded_corners = true;
rounded_edges = true;
leg_count = 8; //[1:8]

/*[ Leg-1 ] */
leg1_angle = 0;
leg1_length = 30;
leg1_color = "Silver"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

/*[ Leg-2 ] */
leg2_angle = 45;
leg2_length = 30;
leg2_color = "Blue"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

/*[ Leg-3 ] */
leg3_angle = 90;
leg3_length = 30;
leg3_color = "Silver"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

/*[ Leg-4 ] */
leg4_angle = 135;
leg4_length = 30;
leg4_color = "Yellow"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

/*[ Leg-5 ] */
leg5_angle = 180;
leg5_length = 30;
leg5_color = "Silver"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

/*[ Leg-6 ] */
leg6_angle = 225;
leg6_length = 30;
leg6_color = "Blue"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

/*[ Leg-7 ] */
leg7_angle = 270;
leg7_length = 30;
leg7_color = "Silver"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

/*[ Leg-8 ] */
leg8_angle = 315;
leg8_length = 30;
leg8_color = "Yellow"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

/*[ Webs ] */
web_height = 30;
web_thickness = 5;

use <unfy_fasteners.scad>
use <unfy_math.scad>
use <unfy_lists.scad>

$fn = $preview ? 36 : 360;

module multi_bracket(width=6, thickness=2, fillet=2, legs=[[0, 10, [], [], "yellow"], [45, 10, [], [], "blue"]], rounded_corners = true, rounded_edges = true){
  // functions which read from the leg vectors
  //[angle, length, hole_type, holes, leg_color]
  function leg_angle(v) = v[0];
  function leg_length(v) = v[1];
  function leg_holes(v) = v[2];
  function leg_webs(v) = v[3];
  function leg_color(v) = v[4];

  //functions which read from the calcs1 vectors
  function leg_offset(v) = v[0];
  function leg_slope(v) = v[1];
  function leg_b1(v) = v[2];
  function leg_b2(v) = v[3];
  function leg_adj_len(v) = v[4];

  //functions which read from the calcs2 vector
  function opening(v) = v[0];
  function inside(v) = v[1];
  function inner_length1(v) = v[2];
  function inner_length2(v) = v[3];

  //as leg angle travels around the circle need to offset so that legs still come to a clean point
  function h_offset(leg_angle, thickness) = 180 < leg_angle ? 0 : thickness*cos(90 - leg_angle); //offset = adj hyp = thickness cos(theta)=adj/hyp  hyp*cos(theta) = adj
  function v_offset(leg_angle, thickness, h_offset) = 90 == leg_angle ? 0 : (
    90 < leg_angle && leg_angle < 270 ? sqrt(pow(thickness, 2)-pow(h_offset, 2)) : (
      thickness-sqrt(pow(thickness,2)-pow(h_offset, 2))));

  let(
    legs = [for(leg = legs)
	concat(
	  [unf_normalize_angle(leg[0])],
	  [for(index = [1:len(leg)-1]) leg[index]]
	)
    ]){
    let(legs = unf_matrix_sort(legs, 0)){
      let(
	legs = [for(index=[0:len(legs)-1])
	    concat(
	      [legs[index][0]-legs[0][0]],
	      [for(x = [1:len(legs[index])-1]) legs[index][x]]
	    )
	]){

	//pre-calculate values
	calcs1 = [for (leg = legs) let (
	    angle = leg_angle(leg),
	    slope = tan(angle),
	    off_x = h_offset(angle, thickness),
	    off_y = v_offset(angle, thickness, off_x),
	    b1 = off_y - slope*off_x,
	    b2 = (thickness / sin(90-angle)) - slope*off_x + off_y,
	    adj_leg_length = unf_distance_to_bounding_circle(leg_length(leg), [off_x, off_y], angle)
	  )[
	    [off_x, off_y],//offset - 0
	    slope,//slope - 1
	    b1, //base line b
	    b2, //thickness line b
	    adj_leg_length //adjusted leg length which takes into account the offset
	  ]];

	calcs2 = [for (index = [0:len(legs)-1]) let (
	    prev_index = index == 0 ? len(legs)-1 : index-1,
	    cur_leg = legs[index],
	    prev_leg = legs[prev_index],
	    cur_calcs1 = calcs1[index],
	    prev_calcs1 = calcs1[prev_index],
	    cur_len = leg_adj_len(cur_calcs1),
	    prev_len = leg_adj_len(prev_calcs1),
	    cur_offset = leg_offset(cur_calcs1),
	    prev_offset = leg_offset(prev_calcs1),
	    cur_slope = leg_slope(cur_calcs1),
	    prev_slope = leg_slope(prev_calcs1),
	    cur_angle = leg_angle(cur_leg),
	    prev_angle = leg_angle(prev_leg),
	    opening_angle = cur_angle - prev_angle,
	    cur_b = leg_b1(cur_calcs1),
	    prev_b = leg_b2(prev_calcs1),
	    
	    inside = 90 == prev_angle ? (
	      [0, cur_b]
	    ) : (
	      270 == prev_angle ? (
		[thickness, (cur_slope * thickness) + cur_b]
	      ) : (
		90 == cur_angle ? (
		  [cur_offset.x, prev_offset.y + prev_b + (prev_slope * prev_offset.x)]
		) : (
		  270 == cur_angle ? (
		    [0, prev_b]
		  ) : (
		    let(inside_x = (prev_b - cur_b) / (cur_slope - prev_slope))
		    [inside_x, (prev_slope * inside_x) + prev_b]
		  )
		)
	      )
	    ),
	    prev_inner_length = prev_len,
	    cur_inner_length = cur_len
	  )[
	    opening_angle,
	    inside,
	    prev_inner_length,
	    cur_inner_length
	  ]];
	
	//Draw each leg
	for (leg_index=[0:len(legs)-1]){
	  leg = legs[leg_index];
	  leg_angle = leg_angle(leg);
	  leg_offset = leg_offset(calcs1[leg_index]);
	  leg_length = leg_adj_len(calcs1[leg_index]);
	  translate([leg_offset.x, 0, leg_offset.y]){
	    rotate([0, -leg_angle, 0]){
	      //translate([-(thickness/20), -(thickness/20), 0]) color("black") cube([leg_length+(thickness/10), width+(thickness/10), thickness/10]);
	      color(leg_color(leg)){
		let(
		  adj_leg_length = rounded_edges && (0 == leg_index || len(legs)-1 == leg_index) ? leg_length - (thickness/2) : leg_length,
		  adj_width = rounded_edges && (0 == leg_index || len(legs)-1 == leg_index) ? width - (thickness) : width,
		  shift = [0, rounded_edges && (0 == leg_index || len(legs)-1 == leg_index) ? thickness/2 : 0, rounded_edges && len(legs)-1 == leg_index ? thickness/2 : (rounded_edges && 0 == leg_index ? -thickness/2 : 0)]
		){
		  intersection(){
		    if (0 == leg_index || len(legs)-1 == leg_index){
		      cube([leg_length, width, thickness]);
		    }
		    translate(shift){
		      minkowski(){
			if (rounded_corners){
			  hull(){
			    cube([0.001, adj_width, thickness]);
			    translate([adj_leg_length-thickness, adj_width-thickness, 0])
			      cylinder(h=thickness, r=thickness);
			    translate([adj_leg_length-thickness, thickness, 0])
			      cylinder(h=thickness, r=thickness);
			  }
			} else {
			  if(rounded_edges && (0 == leg_index || len(legs)-1 == leg_index)){
			    cube([adj_leg_length, adj_width, thickness]);
			  } else {
			    cube([leg_length, width, thickness]);
			  }
			}
			if(rounded_edges && (0 == leg_index || len(legs)-1 == leg_index)){
			  sphere(d = thickness);
			}
		      }
		    }
		  }
		}
	      }
	    }
	  }
	}
    
	// fillet & webs
	if (1 < len(legs)){
	  for (leg_index = [1:len(legs)-1]){
	    if (0 < fillet){
	      leg = legs[leg_index];
	      prev_leg = legs[leg_index-1];
	      cur_calcs1 = calcs1[leg_index];
	      prev_calcs1 = calcs1[leg_index-1];
	      calcs2 = calcs2[leg_index];

	      cur_length = leg_length(leg);
	      prev_length = leg_length(prev_leg);
	      cur_angle = leg_angle(leg);
	      prev_angle = leg_angle(prev_leg);
	      leg_adj_len = leg_adj_len(cur_calcs1);
	      prev_adj_len = leg_adj_len(prev_calcs1);
	      cur_fillet = min(leg_adj_len, fillet);
	      prev_fillet = min(prev_adj_len, fillet);
	      opening_angle = opening(calcs2);
	      opening_inside = inside(calcs2);
	      prev_inner_length = inner_length1(calcs2);
	      cur_inner_length = inner_length2(calcs2);
	      
	      if (180 > opening_angle && atan(thickness/min(leg_adj_len, prev_adj_len)) < opening_angle){
		cur_offset = leg_offset(cur_calcs1);
		prev_offset = leg_offset(prev_calcs1);
	      
		cur_m = leg_slope(cur_calcs1);
		prev_m = leg_slope(prev_calcs1);
		prev_b = leg_b2(prev_calcs1);

 		color("green"){
		  for(web = 0 < fillet ? concat([[0, width, fillet]], leg_webs(leg)) : leg_webs(leg)){
		    web_bez = let(
		      adj_web1 = min(unf_distance_to_bounding_circle(cur_length, opening_inside, cur_angle)-(rounded_corners ? thickness : 0), web[2]),
		      adj_web2 = min(unf_distance_to_bounding_circle(prev_length, opening_inside, prev_angle)-(rounded_corners ? thickness : 0), web[2]),
		      top_front = [adj_web1*cos(cur_angle) + opening_inside.x, adj_web1*sin(cur_angle) + opening_inside.y],
		      bottom = [adj_web2*cos(prev_angle) + opening_inside.x, adj_web2*sin(prev_angle) + opening_inside.y],
		      cur_across = [thickness*cos(cur_angle+90), thickness*sin(cur_angle+90)],
		      cur_back = top_front + cur_across,
		      mid = cur_offset + cur_across,
		      bottom_angle = prev_angle-90,
		      bottom_back = bottom + [thickness*cos(bottom_angle), thickness*sin(bottom_angle)]
		    ) concat([prev_offset, mid, cur_back], unfy_bezier([top_front, opening_inside, bottom], $fn = $fn), [bottom_back, prev_offset]);
		    translate([0, width-web[0], 0]){
		      rotate([90, 0, 0]){
			linear_extrude(web[1]){
			  polygon(web_bez);
			}
		      }
		    }
		  }
		}
	      }
	    }
	  }
	}
      }
    }
  }
}


test_webs = [[0, web_thickness, web_height], [(width/2)-(web_thickness/2), web_thickness, web_height], [width-web_thickness, web_thickness, web_height]];
holes = [];


legs = unf_sub([
  [leg1_angle, leg1_length, holes, test_webs, leg1_color],
  [leg2_angle, leg2_length, holes, test_webs, leg2_color],
  [leg3_angle, leg3_length, holes, test_webs, leg3_color],
  [leg4_angle, leg4_length, holes, test_webs, leg4_color],
  [leg5_angle, leg5_length, holes, test_webs, leg5_color],
  [leg6_angle, leg6_length, holes, test_webs, leg6_color],
  [leg7_angle, leg7_length, holes, test_webs, leg7_color],
  [leg8_angle, leg8_length, holes, test_webs, leg8_color],
	       ], 0, leg_count);

multi_bracket(width=width, thickness=thickness, rounded_corners=rounded_corners, rounded_edges=rounded_edges, legs=legs, fillet=fillet);

