// LibFile: unfy_popins.scad
//   UnfyOpenSCADLib Copyright Leif Burrow 2026
//   kc8rwr@unfy.us
//   unforgettability.net
//   .
//   This file is part of UnfyOpenSCADLib.
//   .
//   unfy_popins contains modules for creating cutouts and mounts for simple rectangular parts such as switches and panel meters which push into a hole and have fingers that grab. Parts may be selected by name so that the end user may choose a part from a customizer drop-down.

use <../unfy_lists.scad>

//Device 
device="rleil_r2"; //["RLEIL_R2 | RLEIL_R2-Rleil R2 Series Switch", "YB4835VA | Digital Volt/Amp Panel Meter"]
wall = 3;
margin = 5;
support_skin = 0.6;

body_color = "Blue"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]
support_color = "Yellow"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]


$over = 1;

// Section: Custom Pop-ins
//   Modules for pop-ins of any size. These are used by the named parts below, and may be used directly for parts which are not yet included.

// Module: unf_PopinCustom_Negative
// Usage:
//   unf_PopinCustom_Negative(&lt;args&gt;);
// Description:
//   The cutout for a pop-in part of any size. The cutout is the size of the opening plus the ridge on each side, it is partially filled back in by unf_PopinCustom_Positive().
// Arguments:
//   ---
//   size = [x, y] size of the opening the part pushes through ([10, 5])
//   ridge = [x, y] width of the ledge on each side of the opening which the part's fingers grab ([2, 1])
//   extra = how far beyond the wall to extend the cutout (5)
//   wall = thickness of the panel the part is mounted in (2)
// Figure(Spin;VPD=50;VPT=[7,3.5,3];NoAxes): defaults
//   $over = 1;
//   $fn = 36;
//   use <cutouts/unfy_popins.scad>;
//   unf_PopinCustom_Negative();
module unf_PopinCustom_Negative(size=[10, 5], ridge=[2, 1], extra=5, wall=2){
  translate([0, 0, -$over]){
    cube([size.x+(2*ridge.x), size.y+(2*ridge.y), wall + extra + (2*$over)]);
  }
}

// Module: unf_PopinCustom_Positive
// Usage:
//   unf_PopinCustom_Positive(&lt;args&gt;);
// Description:
//   The positive part for a pop-in part of any size. This is a ledge around the opening, thin enough for the part's fingers to grab, plus any optional support skin for printing.
// Arguments:
//   ---
//   size = [x, y] size of the opening the part pushes through ([10, 5])
//   catch_thickness = thickness of the ledge which the part's fingers grab (1.2)
//   ridge = [x, y] width of the ledge on each side of the opening which the part's fingers grab ([2, 1])
//   wall = thickness of the panel the part is mounted in (2)
//   body_color = color of the generated part (Blue)
//   support_color = color of generated supports (Yellow)
//   support_skin = thickness of support skin, 0 for none (0)
// Figure(Spin;VPD=50;VPT=[7,3.5,0];NoAxes): defaults
//   $over = 1;
//   $fn = 36;
//   use <cutouts/unfy_popins.scad>;
//   unf_PopinCustom_Positive();
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


// Section: Pop-ins by Name

// Module: unf_Popin_Positive
// Usage:
//   unf_Popin_Positive(device, &lt;args&gt;);
// Description:
//   Call a popin switch module by name.
// Arguments:
//   device = name of the part, "RLEIL_R2" or "YB4835VA", case insensitive. Anything after a "|" is ignored, so a description may be included for display in a customizer drop-down.
//   ---
//   wall = thickness of the panel the part is mounted in (2)
//   body_color = color of the generated part (Blue)
//   support_color = color of generated supports (Yellow)
//   support_skin = thickness of support skin, 0 for none (0)
// Figure(Spin;VPD=80;VPT=[17,11,0];NoAxes): device="RLEIL_R2"
//   $over = 1;
//   $fn = 36;
//   use <cutouts/unfy_popins.scad>;
//   unf_Popin_Positive(device="RLEIL_R2");
module unf_Popin_Positive(device, wall=2, body_color="Blue", support_color="Yellow", support_skin=0){
  let(device = unf_stToLower(unf_stCutAfter(device, "|"))){
    if ("rleil_r2" == device){
      unf_rleil_rl2_popin(wall=wall, body_color=body_color, support_color=support_color, support_skin=support_skin);
    } else if ("yb4835va" == device){
      unf_yb4835va_popin(wall=wall, body_color=body_color, support_color=support_color, support_skin=support_skin);
    }
  }
}

// Module: unf_Popin_Negative
// Usage:
//   unf_Popin_Negative(device, &lt;args&gt;);
// Description:
//   Call a popin switch cutout module by name.
// Arguments:
//   device = name of the part, "RLEIL_R2" or "YB4835VA", case insensitive. Anything after a "|" is ignored.
//   ---
//   wall = thickness of the panel the part is mounted in (2)
// Figure(Spin;VPD=80;VPT=[17,11,3];NoAxes): device="RLEIL_R2"
//   $over = 1;
//   $fn = 36;
//   use <cutouts/unfy_popins.scad>;
//   unf_Popin_Negative(device="RLEIL_R2");
module unf_Popin_Negative(device, wall=2){
  let(device = unf_stToLower(unf_stCutAfter(device, "|"))){
    if ("rleil_r2" == device){
      unf_rleil_rl2_cutout(wall);
    } else if ("yb4835va" == device){
      unf_yb4835va_cutout(wall);
    }
  }
}

// Function: unf_Popin_Dims
// Synopsis: Pop-in Dimensions by Name
// Description:
//   Get a popin switch's dimensions by name. Returns [0, 0] for an unknown part.
// Usage:
//   unf_Popin_Dims(device)
// Arguments:
//   device = name of the part, "RLEIL_R2" or "YB4835VA", case insensitive. Anything after a "|" is ignored.
function unf_Popin_Dims(device) =
  let(device = unf_stToLower(unf_stCutAfter(device, "|"))) (
    "rleil_r2" == device ? unf_rleil_r2_dims() : (
      "yb4835va" == device ? unf_yb4835va_dims() : [0, 0]
    )
  );

// Module: unf_Popin
// Usage:
//   unf_Popin(&lt;args&gt;){<br/>&nbsp;&nbsp;&nbsp;child_stuff();<br/>}
// Description:
//   Operator module that uses unf_Popin_Positive() and unf_Popin_Negative() to cut out and build up a popin by name on the child object(s).
// Arguments:
//   ---
//   location = where to place the pop-in relative to the child/childrens' origin ([0, 0, 0])
//   rotation = how to orientate the pop-in relative to the child/children objects (0)
//   device = name of the part, "RLEIL_R2" or "YB4835VA", case insensitive. Anything after a "|" is ignored. (rleil_r2)
//   wall = thickness of the panel the part is mounted in (2)
//   body_color = color of the generated part (Blue)
//   support_color = color of generated supports (Yellow)
//   support_skin = thickness of support skin, 0 for none (0)
//   do_render = wrap the positive and negative parts in render(), which may speed up previews of complex models (false)
// Figure(Spin;VPD=120;VPT=[20,16,0];NoAxes): device="RLEIL_R2"
//   $over = 1;
//   $fn = 36;
//   use <cutouts/unfy_popins.scad>;
//   unf_Popin(location=[5, 5, 0], device="RLEIL_R2", wall=3){
//     color("Blue") cube([43.2, 32, 3]);
//   }
module unf_Popin(location=[0, 0, 0], rotation=0, device="rleil_r2", wall=2, body_color="Blue", support_color="Yellow", support_skin=0, do_render=false){
  difference(){
    children();
    translate(location){
      rotate(rotation){
	if (do_render){
	  render() unf_Popin_Negative(device=device, wall=wall);
	} else {
	  unf_Popin_Negative(device=device, wall=wall);
	}
      }
    }
  }
  translate(location){
    rotate(rotation){
      if (do_render){
	render() unf_Popin_Positive(device=device, wall=wall, body_color=body_color, support_color=support_color, support_skin=support_skin);
      } else {
	unf_Popin_Positive(device=device, wall=wall, body_color=body_color, support_color=support_color, support_skin=support_skin);
      }
    }
  }

}

//**********************Switches****************************

// Section: Switches

// Module: unf_rleil_rl2_popin
// Usage:
//   unf_rleil_rl2_popin(&lt;args&gt;);
// Description:
//   The positive part for a RLEIL RL2 series Rocker Switch.
// Arguments:
//   ---
//   wall = thickness of the panel the switch is mounted in (2)
//   body_color = color of the generated part (Blue)
//   support_color = color of generated supports (Yellow)
//   support_skin = thickness of support skin, 0 for none (0)
module unf_rleil_rl2_popin(wall=2, body_color="Blue", support_color="Yellow", support_skin=0){
  unf_PopinCustom_Positive(size=[30.2, 22], catch_thickness=1.75, ridge=[1.5, 0], wall=wall, body_color=body_color, support_color=support_color, support_skin=support_skin);
}

// Module: unf_rleil_rl2_cutout
// Usage:
//   unf_rleil_rl2_cutout(&lt;args&gt;);
// Description:
//   The cutout for a RLEIL RL2 series Rocker Switch.
// Arguments:
//   wall = thickness of the panel the switch is mounted in (2)
module unf_rleil_rl2_cutout(wall=2){
  unf_PopinCustom_Negative(size=[30.2, 22], ridge=[1.5, 0], wall=wall);
}

// Function: unf_rleil_r2_dims
// Synopsis: RLEIL RL2 Dimensions
// Description:
//   Returns the [x, y, z] dimensions of a RLEIL RL2 series Rocker Switch.
// Usage:
//   unf_rleil_r2_dims()
function unf_rleil_r2_dims() = [30.2, 22, 27];//[33, 25, 27];

//********************End Switches**************************


//********************Random Items**************************

// Section: Meters

// Module: unf_yb4835va_cutout
// Usage:
//   unf_yb4835va_cutout(&lt;args&gt;);
// Description:
//   The cutout for a YB4835VA Digital Volt/Amp Panel Meter.
// Arguments:
//   wall = thickness of the panel the meter is mounted in (2)
module unf_yb4835va_cutout(wall=2){
  unf_PopinCustom_Negative(size=[66, 37], wall=wall, ridge=[3, 0]);
}

// Module: unf_yb4835va_popin
// Usage:
//   unf_yb4835va_popin(&lt;args&gt;);
// Description:
//   The positive part for a YB4835VA Digital Volt/Amp Panel Meter.
// Arguments:
//   ---
//   wall = thickness of the panel the meter is mounted in (2)
//   body_color = color of the generated part (Blue)
//   support_color = color of generated supports (Yellow)
//   support_skin = thickness of support skin, 0 for none (0)
module unf_yb4835va_popin(wall=2, body_color="Blue", support_color="Yellow", support_skin=0){
  unf_PopinCustom_Positive(size=[66, 37], wall=wall, ridge=[3, 0], body_color=body_color, support_color=support_color, support_skin=support_skin);
}

// Function: unf_yb4835va_dims
// Synopsis: YB4835VA Dimensions
// Description:
//   Returns the [x, y] dimensions of a YB4835VA Digital Volt/Amp Panel Meter.
// Usage:
//   unf_yb4835va_dims()
function unf_yb4835va_dims() = [70, 40];

//******************End Random Items************************


panel_dim = unf_Popin_Dims(device=device);
unf_Popin(location=[margin, margin, 0], rotation=0, device=device, wall=wall, body_color=body_color, support_color=support_color, support_skin=support_skin){
  color(body_color){
    cube([panel_dim.x + (2*margin), panel_dim.y + (2*margin), wall]);
  }
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
