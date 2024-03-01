// For simple rectangular shapes such as switches which push into a hole and have fingers that grab
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

use <../unfy_lists.scad>

//Device 
device="rleil_r2"; //["RLEIL_R2 | RLEIL_R2-Rleil R2 Series Switch", "YB4835VA | Digital Volt/Amp Panel Meter"]
wall = 3;
margin = 5;
support_skin = 0.6;

$over = 1;

module unf_popin_cutout_custom(size=[10, 5], ridge=[2, 1], wall_thickness=2){
  translate([0, 0, -$over]){
    cube([size.x+(2*ridge.x), size.y+(2*ridge.y), wall_thickness + (2*$over)]);
  }
}

module unf_popin_custom(size=[10, 5], catch_thickness=1.2, ridge=[2,1], wall_thickness=2, support_skin=0){
  z_offset = 0 < (wall_thickness-catch_thickness) ? wall_thickness-catch_thickness : 0;
  if (0 < support_skin){
    color("LightGrey", alpha=0.5){
      translate([ridge.x, ridge.y, -support_skin/2]){
	cube([size.x, size.y, support_skin]);
      }
      translate([0, 0, wall-(support_skin/2)]){
	cube([size.x+(2*ridge.x), size.y+(2*ridge.y), support_skin]);
      }
    }
    difference(){
      cube([size.x+(2*ridge.x), size.y+(2*ridge.y), catch_thickness]);
      translate([ridge.x, ridge.y, -$over]){
	cube([size.x, size.y, catch_thickness+(2*$over)]);
      }
    }
  }
}


//call a popin switch module by name
module unf_popin(model, wall_thickness=2, support_skin=0){
  let(model = unf_stToLower(unf_stCutAfter(model, "|"))){
    if ("rleil_r2" == model){
      unf_rleil_rl2_popin(wall_thickness=wall_thickness, support_skin=support_skin);
    } else if ("yb4835va" == model){
      unf_yb4835va_popin(wall_thickness=wall_thickness, support_skin=support_skin);
    }
  }
}

//call a popin switch cutout module by name
module unf_popin_cutout(model, wall_thickness=2){
  let(model = unf_stToLower(unf_stCutAfter(model, "|"))){
    if ("rleil_r2" == model){
      unf_rleil_rl2_cutout(wall_thickness);
    } else if ("yb4835va" == model){
      unf_yb4835va_cutout(wall_thickness);
    }
  }
}

//get a popin switch's dimensions by name
function unf_popin_dims(model) =
  let(model = unf_stToLower(unf_stCutAfter(model, "|"))) (
    "rleil_r2" == model ? unf_rleil_r2_dims() : (
      "yb4835va" == model ? unf_yb4835va_dims() : [0, 0]
    )
  );


//**********************Switches****************************

//RLEIL RL2 series Rocker Switch
module unf_rleil_rl2_popin(wall_thickness=2, support_skin=0){
  unf_popin_custom(size=[30.2, 22], catch_thickness=1.75, ridge=[1.5, 0], wall_thickness=wall_thickness, support_skin=support_skin);
}

//RLEIL RL2 series Rocker Switch
module unf_rleil_rl2_cutout(wall_thickness=2){
  unf_popin_cutout_custom(size=[30.2, 22], ridge=[1.5, 0], wall_thickness=wall_thickness);
}

//RLEIL RL2 series Rocker Switch
function unf_rleil_r2_dims() = [33, 25];

//********************End Switches**************************


//********************Random Items**************************

//YB4835VA Volt/Amp meter
module unf_yb4835va_cutout(wall_thickness=2){
  unf_popin_cutout_custom(size=[66, 37], wall_thickness=wall_thickness, ridge=[3, 0]);
}

//YB4835VA Volt/Amp meter
module unf_yb4835va_popin(wall_thickness=2, support_skin=0){
  unf_popin_custom(size=[66, 37], wall_thickness=wall_thickness, ridge=[3, 0], support_skin=support_skin);
}

//YB4835VA Volt/Amp meter
function unf_yb4835va_dims() = [70, 40];

//******************End Random Items************************


panel_dim = unf_popin_dims(model=device);

difference(){
  cube([panel_dim.x + (2*margin), panel_dim.y + (2*margin), wall]);
  translate([margin, margin, 0]){
    unf_popin_cutout(model=device, wall_thickness=wall);
  }
}
translate([margin, margin, 0]){
  unf_popin(model=device, wall_thickness=wall, support_skin=support_skin);
}
