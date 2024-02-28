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

$over = 1;

module unfy_popin_cutout(size=[10, 5], ridge=[2, 1], wall_thickness=2){
  translate([0, 0, -$over]){
    cube([size.x+(2*ridge.x), size.y+(2*ridge.y), wall_thickness + (2*$over)]);
  }
}

module unfy_popin(size=[10, 5], catch_thickness=1.2, ridge=[2,1], wall_thickness=2){
  z_offset = 0 < (wall_thickness-catch_thickness) ? wall_thickness-catch_thickness : 0;
  translate([0, 0, z_offset]){
    difference(){
      cube([size.x+(2*ridge.x), size.y+(2*ridge.y), catch_thickness]);
      translate([ridge.x, ridge.y, -$over]){
	cube([size.x, size.y, catch_thickness+(2*$over)]);
      }
    }
  }
}

//**********************Switches****************************

//RLEIL RL2 series Rocker Switch
module unfy_rleil_rl2_popin(wall_thickness=2){
  unfy_popin(size=[30.2, 22], catch_thickness=1.75, ridge=[1.5, 0], wall_thickness=wall_thickness);
}

//RLEIL RL2 series Rocker Switch
module unfy_rleil_rl2_cutout(wall_thickness=2){
  unfy_popin_cutout(size=[30.2, 22], ridge=[1.5, 0], wall_thickness=wall_thickness);
}


//********************End Switches**************************


//********************Random Items**************************

//YB4835VA Volt/Amp meter - common on Amazon, Alibaba, etc...
module unfy_yb4835va_cutout(wall_thickness=2){
  unfy_popin_cutout(size=[66, 37], wall_thickness=wall_thickness, ridge=[3, 0]);
}

//YB4835VA Volt/Amp meter - common on Amazon, Alibaba, etc...
module unfy_yb4835va_popin(wall_thickness=2){
  unfy_popin(size=[66, 37], wall_thickness=wall_thickness, ridge=[3, 0]);
}


//******************End Random Items************************


