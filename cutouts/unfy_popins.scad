// For simple rectangular shapes such as switches which push into a hole and have fingers that grab
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

use <../unfy_lists.scad>

//Device 
device="rleil_r2"; //["RLEIL_R2 | RLEIL_R2-Rleil R2 Series Switch", "YB4835VA | Digital Volt/Amp Panel Meter"]
wall = 3;
margin = 5;
support_skin = 0.6;

body_color = "Blue"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]
support_color = "Yellow"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]


$over = 1;

module unf_PopinCustom_Negative(size=[10, 5], ridge=[2, 1], extra=5, wall=2){
  translate([0, 0, -$over]){
    cube([size.x+(2*ridge.x), size.y+(2*ridge.y), wall + extra + (2*$over)]);
  }
}

module unf_PopinCustom_Positive(size=[10, 5], catch_thickness=1.2, ridge=[2,1], wall=2, body_color="Blue", support_color="Yellow", support_skin=0){
  z_offset = 0 < (wall-catch_thickness) ? wall-catch_thickness : 0;
  if (0 < support_skin){
    color(support_color){
      translate([ridge.x, ridge.y, -support_skin/2]){
	cube([size.x, size.y, support_skin]);
      }
      translate([0, 0, wall-(support_skin/2)]){
	cube([size.x+(2*ridge.x), size.y+(2*ridge.y), support_skin]);
      }
    }
  }
  color(body_color){
    difference(){
      cube([size.x+(2*ridge.x), size.y+(2*ridge.y), catch_thickness]);
      translate([ridge.x, ridge.y, -$over]){
	cube([size.x, size.y, catch_thickness+(2*$over)]);
      }
    }
  }
}


//call a popin switch module by name
module unf_Popin_Positive(device, wall=2, body_color="Blue", support_color="Yellow", support_skin=0){
  let(device = unf_stToLower(unf_stCutAfter(device, "|"))){
    if ("rleil_r2" == device){
      unf_rleil_rl2_popin(wall=wall, body_color=body_color, support_color=support_color, support_skin=support_skin);
    } else if ("yb4835va" == device){
      unf_yb4835va_popin(wall=wall, body_color=body_color, support_color=support_color, support_skin=support_skin);
    }
  }
}

//call a popin switch cutout module by name
module unf_Popin_Negative(device, wall=2){
  let(device = unf_stToLower(unf_stCutAfter(device, "|"))){
    if ("rleil_r2" == device){
      unf_rleil_rl2_cutout(wall);
    } else if ("yb4835va" == device){
      unf_yb4835va_cutout(wall);
    }
  }
}

//get a popin switch's dimensions by name
function unf_Popin_Dims(device) =
  let(device = unf_stToLower(unf_stCutAfter(device, "|"))) (
    "rleil_r2" == device ? unf_rleil_r2_dims() : (
      "yb4835va" == device ? unf_yb4835va_dims() : [0, 0]
    )
  );

//cutout and buildup a popin by name
module unf_Popin(location=[0, 0, 0], rotation=0, device="rleil_r2", wall=2, body_color="Blue", support_color="Yellow", support_skin=0){
  difference(){
    children();
    translate(location){
      rotate(rotation){
	unf_Popin_Negative(device=device, wall=wall);
      }
    }
  }
  translate(location){
    rotate(rotation){
      unf_Popin_Positive(device=device, wall=wall, body_color=body_color, support_color=support_color, support_skin=support_skin);
    }
  }

}

//**********************Switches****************************

//RLEIL RL2 series Rocker Switch
module unf_rleil_rl2_popin(wall=2, body_color="Blue", support_color="Yellow", support_skin=0){
  unf_PopinCustom_Positive(size=[30.2, 22], catch_thickness=1.75, ridge=[1.5, 0], wall=wall, body_color=body_color, support_color=support_color, support_skin=support_skin);
}

//RLEIL RL2 series Rocker Switch
module unf_rleil_rl2_cutout(wall=2){
  unf_PopinCustom_Negative(size=[30.2, 22], ridge=[1.5, 0], wall=wall);
}

//RLEIL RL2 series Rocker Switch
function unf_rleil_r2_dims() = [33, 25, 27];

//********************End Switches**************************


//********************Random Items**************************

//YB4835VA Volt/Amp meter
module unf_yb4835va_cutout(wall=2){
  unf_PopinCustom_Negative(size=[66, 37], wall=wall, ridge=[3, 0]);
}

//YB4835VA Volt/Amp meter
module unf_yb4835va_popin(wall=2, body_color="Blue", support_color="Yellow", support_skin=0){
  unf_PopinCustom_Positive(size=[66, 37], wall=wall, ridge=[3, 0], body_color=body_color, support_color=support_color, support_skin=support_skin);
}

//YB4835VA Volt/Amp meter
function unf_yb4835va_dims() = [70, 40];

//******************End Random Items************************


panel_dim = unf_Popin_Dims(device=device);
unf_Popin(location=[margin, margin, 0], rotation=0, device=device, wall=wall, body_color=body_color, support_color=support_color, support_skin=support_skin){
  color(body_color){
    cube([panel_dim.x + (2*margin), panel_dim.y + (2*margin), wall]);
  }
}
