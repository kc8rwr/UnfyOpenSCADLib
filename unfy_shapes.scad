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

use <unfy_fasteners.scad>
use <unfy_math.scad>

$over = 1;

module unfy_roundedRectangle(v=[18, 5], r=1){
  translate([r, r]){
    hull(){
      circle(r=r);
      translate([0, v.y - (2*r)]){
	circle(r=r);
      }
      translate([v.x - (2*r), v.y - (2*r)]){
	circle(r=r);
      }
      translate([v.x - (2*r), 0]){
	circle(r=r);
      }
    }
  }
}

module unfy_bezier_wedge(width=1, height=1, v=[[0.5, 0]]){
  h = concat([[0, height]], v, [[width, 0]]);
  echo(str(h));
  bez = unfy_bezier(h);
  echo(str(bez));
  polygon(concat([[0, 0]], bez, [[0, 0]]));
}

