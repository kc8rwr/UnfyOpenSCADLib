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

test_shape="round_cube"; //["round_cube", "round_rectangle", "bezier_wedge"]

$fn = $preview ? 36 : 360;
$over = 0.1;

/* [ Rounded Cube ] */
cube_size=[20, 10, 5];
cube_corners=[1, 1, 1, 1];
cube_round_edges=[1, 2, 1, 2, 1, 2, 1, 2];

/* [ Rounded Rectangle ] */
rectangle_size=[50, 25];
rectangle_corners=[0, 1, 2, 3];


module unf_roundedRectangle(size=[18, 5], corners=[1, 1, 1, 1]){
  let (corners = is_num(corners) ? [corners, corners, corners, corners] : corners){
    hull(){
      for (v=[[0, 0, corners[0]], [size.x, 0, corners[1]], [size.x, size.y, corners[2]], [0, size.y, corners[3]]]){
	r = 0 < v.z ? v.z : $over;
	translate([v.x, v.y]){
	  if (0 < v.z){
	    translate([(0==v.x?v.z:-v.z) ,(0==v.y?v.z:-v.z)]){
	      circle(r=v.z);
	    }
	  } else {
	    translate([(0==v.x?0:-$over) ,(0==v.y?0:-$over)]){
	      square([$over, $over]);
	    }
	  }
	}
      }
    }
  }
}

module unf_roundedCube(size=[20, 10, 5], corners=[1, 1, 1, 1], round_edges=[1, 2, 1, 2, 1, 2, 1, 2]){
  //[x_offset, y_offset, x_length, y_length, z]
  function calc(base_x, base_y, r1, r2, r3, r4) = let(r_max = max(r1, r2, r3, r4),
						      req_slices = unf_effective_fn(radius=r_max, angle=90),
						      practical_slices = min(r_max/req_slices < $over*2 ? r_max/($over*2) : req_slices),
						      slices = 0 == practical_slices%2 ? practical_slices : practical_slices+1,
						      zs = [ for (x = [0 : r_max/slices : r_max]) x],
						      diff1 = r_max - r1,
						      diff2 = r_max - r2,
						      diff3 = r_max - r3,
						      diff4 = r_max - r4,
						      zoffs = [for (z=zs) [z,
							      z < diff1 ? 0 : r1 - (sqrt(pow(r1, 2) - pow(z-diff1, 2))),
							      z < diff2 ? 0 : r2 - (sqrt(pow(r2, 2) - pow(z-diff2, 2))),
							      z < diff3 ? 0 : r3 - (sqrt(pow(r3, 2) - pow(z-diff3, 2))),
							      z < diff4 ? 0 : r4 - (sqrt(pow(r4, 2) - pow(z-diff4, 2)))]])
    [ for(zoff=zoffs) [zoff[4], zoff[1], base_x-((zoff[2])+(zoff[4])), base_y-((zoff[1])+(zoff[3])), zoff[0]] ]
    ;
  let (size = is_num(size) ? [size, size, size] : size,
       corners = is_num(corners) ? [corners, corners, corners, corners] : corners,
       round_edges = is_num(round_edges) ? [round_edges, round_edges, round_edges, round_edges, round_edges, round_edges, round_edges, round_edges] : round_edges){
    top_calcs = (0 < max(round_edges[0], round_edges[1], round_edges[2], round_edges[3])) ? calc(size.x, size.y, round_edges[0], round_edges[1], round_edges[2], round_edges[3]) : false;
    top_height = is_list(top_calcs) ? top_calcs[len(top_calcs)-1][4] : 0;
    bottom_calcs = (0 < max(round_edges[4], round_edges[5], round_edges[6], round_edges[7])) ? calc(size.x, size.y, round_edges[4], round_edges[5], round_edges[6], round_edges[7]) : false;
    bottom_height = is_list(bottom_calcs) ? bottom_calcs[len(top_calcs)-1][4] : 0;
    middle_height = size.z - (top_height + bottom_height);

    // Do Bottom
    if (0 < bottom_height){
      for(i = [len(bottom_calcs)-1:-1:1]) {
	let(top = bottom_calcs[(i-1)],
	    bottom = bottom_calcs[i]){
	  hull(){
	    translate([bottom[0], bottom[1], bottom_height-bottom[4]]){
	      linear_extrude($over){
		unf_roundedRectangle(size=[bottom[2], bottom[3]], corners=corners);
	      }
	    }
	    translate([top[0], top[1], bottom_height-top[4]]){
	      linear_extrude($over){
		unf_roundedRectangle(size=[top[2], top[3]], corners=corners);
	      }
	    }
	  }
	}
      }
    }

    // Do Middle
    if (0 < middle_height){
      translate([0, 0, bottom_height]){
	hull(){
	  linear_extrude($over){
	    unf_roundedRectangle(size=[size[0], size[1]], corners=corners);
	  }
	  translate([0, 0, middle_height - $over]){
	    linear_extrude($over){
	      unf_roundedRectangle(size=[size[0], size[1]], corners=corners);
	    }
	  }
	}
      }
    }

    // Do Top
    if (0 < top_height){
      translate([0, 0, bottom_height + middle_height]){
	for(i = [1:len(top_calcs)-1]) {
	  let(top = top_calcs[i],
	      bottom = top_calcs[(i-1)]){
	    hull(){
	      translate([bottom[0], bottom[1], bottom[4]]){
		linear_extrude($over){
		  unf_roundedRectangle(size=[bottom[2], bottom[3]], corners=corners);
		}
	      }
	      translate([top[0], top[1], top[4]]){
		linear_extrude($over){
		  unf_roundedRectangle(size=[top[2], top[3]], corners=corners);
		}
	      }
	    }
	  }
	}
      }
    }
  }
}


module unf_bezier_wedge(width=1, height=1, v=false){
  let (v = is_list(v) ? v : [width/4, height/4]){
    h = concat([[0, height]], [v], [[width, 0]]);
    bez = unfy_bezier(h);
    polygon(concat([[0, 0]], bez, [[0, 0]]));
  }
}

if ("round_cube" == test_shape){
  unf_roundedCube(size=cube_size, corners=cube_corners, round_edges=cube_round_edges);
  echo(str("cube_round_edges", cube_round_edges));
 }

if ("round_rectangle" == test_shape){
  unf_roundedRectangle(size=rectangle_size, corners=rectangle_corners);
 }

