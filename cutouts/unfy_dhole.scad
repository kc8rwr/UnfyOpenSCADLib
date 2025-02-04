// UnfyOpenSCADLib Copyright Leif Burrow 2025
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
diameter = 11.3;

//single - measurement from flat to opposite diameter, double - measurement from flat to flat
flat_width = 10.54;

//shape
shape = "D"; //["D", "DoubleD", "Circle"]

//rotation angle, 0 is flat on top, rotates counter-clockwise
angle = 0; //[0:360]

//depth of hole to make
z = 4;

$over = 0.01;
$fn = $preview ? 36 : 360;

use <../unfy_lists.scad>

/*
  Creates d, double-d and circle shapes for cutouts such as fuse holder, toggle switch, etc.. mounts.
  Reason for circle (which could obviously be done without this) is to make easy user-customization.
  diameter - diameter of the fully round part of the circle
  falt_width - distance from flat to opposite side of circle in a d-shape
               distance between flats for double-d
  angle - 
*/
module unf_DHole(diameter=11.3, flat_width=10.54, angle=0, z=4, shape="d"){
  let (shape = unf_stToLower(shape)){
    assert ("d" == shape || "doubled" == shape || "circle" == shape, "Shape must be one of 'd', 'doubled' or 'circle'.");
    assert (0 < diameter, "Diameter must be greater than 0.");
    assert (shape == "circle" || 0 < flat_width, "Flat_width must be greater than zero.");
    assert (shape == "circle" || flat_width < diameter, "Flat_width must be less than diameter.");
    linear_extrude(z){
      rotate(180+angle){
	intersection(){
	  circle(d = diameter);
	  if ("circle" != shape){
	    translate([-diameter/2, -flat_width/2 - (("doubled"==shape)?0:(diameter-flat_width)/2) , 0]){
	      square([diameter, flat_width]);
	    }
	  }
	}
      }
    }
  }
}

unf_DHole(diameter=diameter, flat_width=flat_width, angle=angle, z=z, shape=shape);
