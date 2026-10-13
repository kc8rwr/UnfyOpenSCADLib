// LibFile: unfy_c14socket.scad
//   UnfyOpenSCADLib Copyright Leif Burrow 2026
//   kc8rwr@unfy.us
//   unforgettability.net
//   .
//   This file is part of UnfyOpenSCADLib.
//   .
//   unfy_c14socket contains modules for creating a cutout and mount for a panel mounted IEC C14 power inlet socket, the type commonly found on computer power supplies.

hood_thickness = 2;
wall = 3;

bolt = "M4"; //["M3", "M4", "#4", "#5", "#6", "#8"]
slope = 45; //[45,0]
fastener = "Heatset"; //["Heatset", "HexNut", "PlainHole"]
heatset_length = "Medium"; //["Small", "Medium", "Large"]

restriction_l = -1; //[-1:0.1:10]
restriction_r = -1; //[-1:0.1:10]

support_skin = "none"; //["none", "horizontal", "vertical"]
support_skin_t = 0.02;

body_color = "Blue"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]
support_color = "Yellow"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

$over = 0.01;

use <../unfy_fasteners.scad>
use <../unfy_lists.scad>

$fn = $preview ? 15 : 360;

// Module: unf_C14Socket_Positive
// Usage:
//   unf_C14Socket_Positive(&lt;args&gt;);
// Description:
//   Just the positive part of a C14 socket mount. This is the pillars which hold the socket's screws, plus any optional support skin for printing.
// Arguments:
//   ---
//   bolt = size of the bolts which hold the socket in place (M4)
//   fastener = how the bolts are held, "Heatset", "HexNut" or "PlainHole", case insensitive. No pillars are generated for "PlainHole". (plainhole)
//   heatset_length = length of heatset insert, "Small", "Medium" or "Large" (Medium)
//   support_skin = optional support for printing, "none", "horizontal" or "vertical" (none)
//   support_skin_t = thickness of support skin, if generating supports, probably good to use the minimum your slicer will include (0.2)
//   body_color = color of the generated part (Blue)
//   support_color = color of generated supports (Yellow)
//   restriction_l = if set, limits how far the pillars may extend to the left beyond the socket's ears, for fitting against nearby walls (false)
//   restriction_r = if set, limits how far the pillars may extend to the right beyond the socket's ears, for fitting against nearby walls (false)
//   wall = thickness of the panel the socket is mounted in (4)
// Figure(Spin;VPD=140;VPT=[26,11,-5];NoAxes): fastener="Heatset"
//   $over = 0.01;
//   $fn = 36;
//   use <cutouts/unfy_c14socket.scad>;
//   unf_C14Socket_Positive(fastener="Heatset");
module unf_C14Socket_Positive(bolt="M4", fastener="plainhole", heatset_length="Medium", support_skin="none", support_skin_t=0.2, body_color="Blue", support_color="Yellow", restriction_l=false, restriction_r=false, wall=4){
  let(fastener = unf_stToLower(fastener),
      support_skin = unf_stToLower(support_skin),
      body_x = 26,
      body_y = 22.7,
      body_depth=18,
      screw_separation = 40,
      ear_x=13,
      restriction_l = is_num(restriction_l) ? (abs(restriction_l) < 0.001 ? 0 : restriction_l) : -1, //rounding numbers really close to zero because odd really small magnitudes have been seen from custimizer value of "zero"
      restriction_r = is_num(restriction_r) ? (abs(restriction_r) < 0.001 ? 0 : restriction_r) : -1){
      
    intersection(){
      if ("plainhole" != fastener && (0 <= restriction_l || 0 <= restriction_r)){
	translation = [0 > restriction_l ? -100 : -restriction_l , -39, -100];
	dims = [0 > restriction_r ? 126 : (body_x + (2*ear_x) + restriction_r - translation.x) , 100, 100];
	translate(translation){
	  cube(dims);
	}
      }

      //fastener pillars  
      if ("plainhole" != fastener){
	difference(){
	  color(body_color){
	    for (x = [ear_x/2, screw_separation+(ear_x/2)]){
	      translate([x, body_y/2]){
		rotate([0, 180, 0]){
		  unf_pillar(fastener=fastener, heatset_length=heatset_length, bolt=bolt, slope=slope, length=5);
		}
	      }
	    }
	  }
	  translate([ear_x, 0, $over]){
	    unf_C14Body(depth=body_depth+$over);
	  }
	}
      }
    }
      
    //support skin
    if ("none" != support_skin && $over < support_skin_t){
      color(support_color, alpha=0.5){
	translate([0, 0, wall-support_skin_t]){
	  unf_C14Cape(hood_thickness=support_skin_t);
	}
	translate([ear_x, 0, 0]){
	  unf_C14Body(depth=support_skin_t);
	}
      }
    }
  
    //vertical support (bar between screw holes for supporting pillars when printed on end)
    if ("vertical" == support_skin && "plainhole" != fastener && $over < support_skin_t) {
      color(support_color, alpha=0.5){
	hull(){
	  intersection() {
	    unf_C14Socket_Positive(bolt=bolt, fastener=fastener, heatset_length=heatset_length, support_skin="none", support_skin_t=0, wall=wall);
	    translate([ear_x/2, (body_y/2)-(support_skin_t/2), -body_depth]){
	      cube([screw_separation, support_skin_t, body_depth]);
	    }
	  }
	}
      }
    }
  }
}


// Module: unf_C14Socket_Negative
// Usage:
//   unf_C14Socket_Negative(&lt;args&gt;);
// Description:
//   Just the negative part of a C14 socket mount. This is the cutout for the socket body, the recess for the socket's flange and the screw holes.
// Arguments:
//   ---
//   bolt = size of the bolts which hold the socket in place (M4)
//   hood_thickness = depth of the recess for the socket's flange (3)
//   wall = thickness of the panel the socket is mounted in (4)
// Figure(Spin;VPD=140;VPT=[26,11,-10];NoAxes): defaults
//   $over = 0.01;
//   $fn = 36;
//   use <cutouts/unfy_c14socket.scad>;
//   unf_C14Socket_Negative();
module unf_C14Socket_Negative(bolt="M4", hood_thickness=3, wall=4){  
  let(bolt_d = unf_fnr_shaft_diameter(bolt),
      body_x = 26,
      body_y = 22.7,
      body_depth = 18,
      ear_x=13,
      screw_separation=40){
    unf_C14Cape(hood_thickness=hood_thickness);
    translate([ear_x, 0, -$over]){
      unf_C14Body(depth=body_depth+$over);
    }
    translate([0, 0, -(wall+body_depth)]){
      //screw holes
      for (x = [ear_x/2, screw_separation+(ear_x/2)]){
	translate([x, body_y/2]){
	  cylinder(d=bolt_d, h=body_depth+wall);
	}
      }
    }
  }
}

// Module: unf_C14Cape
// Usage:
//   unf_C14Cape(&lt;args&gt;);
// Description:
//   The shape of the flange (cape) around the front of a C14 socket, including the ears with the screw holes. Used for cutting a recess for the flange or for support skins.
// Arguments:
//   ---
//   hood_thickness = thickness of the flange (3)
// Figure(Spin;VPD=120;VPT=[26,11,0];NoAxes): defaults
//   $over = 0.01;
//   $fn = 36;
//   use <cutouts/unfy_c14socket.scad>;
//   unf_C14Cape();
module unf_C14Cape(hood_thickness=3){
  body_x = 26;
  body_y = 22.7;
  screw_separation = 40;
  ear_x = 13;
  translate([ear_x, 0, -hood_thickness]){
    linear_extrude(hood_thickness){
      hull(){
	//body
	square([body_x, body_y]);

	//ears
	for (x = [(body_x/2)-(screw_separation/2), (body_x/2)+(screw_separation/2)]){
	  translate([x, body_y/2]){
	    circle(r = ear_x - ((screw_separation/2)-(body_x/2)));
	  }
	}
      }
    }
  }  
}

// Module: unf_C14Body
// Usage:
//   unf_C14Body(&lt;args&gt;);
// Description:
//   The shape of the body of a C14 socket, behind the flange. Used for cutting the hole that the socket fits through.
// Arguments:
//   ---
//   depth = depth of the body (18)
// Figure(Spin;VPD=100;VPT=[13,11,-9];NoAxes): defaults
//   $over = 0.01;
//   $fn = 36;
//   use <cutouts/unfy_c14socket.scad>;
//   unf_C14Body();
module unf_C14Body(depth=18){
  body_x = 26;
  body_y = 22.7;
  ear_x=13;
  cutaway_bottom_x = 27.2;
  cutaway_bottom_y = 13.33;
  cutaway_top_x = 21;
  cutaway_y = 20;
  translate([0, 0, -depth]){
    linear_extrude(depth){
      //body
      bottom_y = (body_y - cutaway_y)/2;
      mid_y = bottom_y + cutaway_bottom_y;
      top_y = bottom_y + cutaway_y;
      left_x = (body_x - cutaway_bottom_x) /2;
      top_left_x = left_x + ((cutaway_bottom_x - cutaway_top_x)/2);
      top_right_x = top_left_x + cutaway_top_x;
      right_x = left_x + cutaway_bottom_x;
      polygon([[left_x, bottom_y], [left_x, mid_y], [top_left_x, top_y], [top_right_x, top_y], [right_x, mid_y], [right_x, bottom_y]]);
    }
  }
}

// Module: unf_C14Socket
// Usage:
//   unf_C14Socket(&lt;args&gt;){<br/>&nbsp;&nbsp;&nbsp;child_stuff();<br/>}
// Description:
//   Operator module that uses unf_C14Socket_Positive() and unf_C14Socket_Negative() to cut a C14 socket hole through the child object(s) and add any mounting pillars.
// Arguments:
//   ---
//   location = where to place the socket relative to the child/childrens' origin ([0, 0, 0])
//   rotation = how to orientate the socket relative to the child/children objects (0)
//   hood_thickness = depth of the recess for the socket's flange (3)
//   bolt = size of the bolts which hold the socket in place (M4)
//   fastener = how the bolts are held, "Heatset", "HexNut" or "PlainHole", case insensitive (plainhole)
//   heatset_length = length of heatset insert, "Small", "Medium" or "Large" (Medium)
//   support_skin = optional support for printing, "none", "horizontal" or "vertical" (none)
//   support_skin_t = thickness of support skin, if generating supports, probably good to use the minimum your slicer will include (0.2)
//   body_color = color of the generated part (Blue)
//   support_color = color of generated supports (Yellow)
//   restriction_l = if set, limits how far the pillars may extend to the left beyond the socket's ears, for fitting against nearby walls (false)
//   restriction_r = if set, limits how far the pillars may extend to the right beyond the socket's ears, for fitting against nearby walls (false)
//   wall = thickness of the panel the socket is mounted in (4)
// Figure(Spin;VPD=150;VPT=[32,15,-5];NoAxes): fastener="Heatset"
//   $over = 0.01;
//   $fn = 36;
//   use <cutouts/unfy_c14socket.scad>;
//   unf_C14Socket(location=[6, 4, 0], fastener="Heatset", hood_thickness=2, wall=3){
//     color("Blue") cube([65, 30, 3]);
//   }
module unf_C14Socket(location=[0, 0, 0], rotation=0, hood_thickness=3, bolt="M4", fastener="plainhole", heatset_length="Medium", support_skin="none", support_skin_t=0.2, body_color="Blue", support_color="Yellow", restriction_l=false, restriction_r=false, wall=4){

  difference(){
    children();
    translate(location){
      rotate(rotation){
	translate([0, 0, wall+$over]){
	  unf_C14Socket_Negative(bolt=bolt, hood_thickness=hood_thickness+$over, wall=wall);
	}
      }
    }
  }
  translate(location){
    rotate(rotation){
      unf_C14Socket_Positive(bolt=bolt, fastener=fastener, heatset_length=heatset_length, support_skin=support_skin, support_skin_t=support_skin_t, body_color=body_color, support_color=support_color, restriction_l=restriction_l, restriction_r=restriction_r, wall=wall);
    }
  }
}

// Function: unf_c14_size
// Synopsis: C14 Socket Size
// Description:
//   Returns the [x, y] size of the front of a C14 socket including the ears.
// Usage:
//   unf_c14_size()
function unf_c14_size() = let(body_x = 26,
			      body_y = 22.7,
			      ear_x=13,
			      screw_separation=40) [body_x+(2*ear_x), body_y];


back_size=[65, 25, wall];

unf_C14Socket(bolt=bolt,
	      fastener=fastener,
	      heatset_length=heatset_length,
	      support_skin=support_skin,
	      support_skin_t=support_skin_t,
	      hood_thickness=hood_thickness,
	      restriction_r = restriction_r,
	      restriction_l = restriction_l,
	      wall=wall,
	      rotation = [0, -0, 0],
	      body_color = body_color,
	      support_color = support_color
){
  rotate([0, -0, 0]){
    translate([-6, -1, 0]){
      color(body_color, alpha=0.25){
	cube(back_size);
      }
    }
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
