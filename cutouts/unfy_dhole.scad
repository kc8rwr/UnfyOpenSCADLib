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

//diameter of full circle
a = 11.3;

//single - measurement from flat to opposite diameter, double - measurement from flat to flat
b=10.54;

//double-d
isDouble = false;

//rotation angle, 0 is flat on top, rotates counter-clockwise
angle = 0; //[0:360]

//depth of hole to make
z = 4;

$over = 0.01;
$fn = $preview ? 36 : 360;

module unf_DHole(a=11.3, b=10.54, z=4, isDouble=false){
  linear_extrude(z){
    rotate(angle){
      intersection(){
	circle(d = a);
	translate([-a/2, -b/2 - (isDouble?0:(a-b)/2) , 0]){
	  square([a, b]);
	}
      }
    }
  }
}

unf_DHole(a=a, b=b, z=z, isDouble=isDouble);
