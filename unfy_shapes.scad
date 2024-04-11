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

use <unfy_fasteners.scad>
use <unfy_math.scad>

test_shape="round_cube"; //["round_cube", "round_rectangle", "bezier_wedge_2d", "bezier_wedge_3d"]

$fn = $preview ? 36 : 360;
$over = 0.1;

/* [ Rounded Cube ] */
cube_size=[20, 10, 5];
cube_corners=[1, 1, 1, 1];
cube_round_edges=[1, 2, 1, 2, 1, 2, 1, 2];

/* [ Rounded Rectangle ] */
rectangle_size=[50, 25];
rectangle_corners=[0, 1, 2, 3];

/* [ Bezier Wedge 2d] */
bez2d_size=[5, 15];
bez2d_use_custom_v = false;
bez2d_custom_v = [1.25, 3.75];

/* [ Bezier Wedge 3d] */
bez3d_size=[5, 15, 15];
bez3d_rounded_edges = [1, 2];

module unf_roundedRectangle(size=[18, 5], corners=[1, 1, 1, 1]){
  let (size = is_num(size) ? [size, size] : size,
       corners = is_num(corners) ? [corners, corners, corners, corners] : corners){

    if (!is_list(size) || 2 != len(size) || 0 >=size.x || 0 >= size.y){
      assert(false, "size must be a positive number or a vector of 2 positive numbers");
    }
    
    if (!is_list(corners) || 4 != len(corners) || 0 > corners[0] || 0 > corners[1] || 0 > corners[2] || 0 > corners[3]){
      assert(false, "corners must be zero, a positive number or a vector of 4 such numbers");
    }
    
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
       round_edges = is_num(round_edges) ? [round_edges, round_edges, round_edges, round_edges, round_edges, round_edges, round_edges, round_edges] : (is_list(round_edges) ? (8==len(round_edges) ? round_edges : [round_edges[0], round_edges[1], round_edges[2], round_edges[3], round_edges[0], round_edges[1], round_edges[2], round_edges[3]]) : round_edges)){

    if (!is_list(size) || 3 != len(size) || 0 >=size.x || 0 >= size.y || 0 >= size.z){
      assert(false, "size must be a positive number or a vector of 3 positive numbers");
    }
    
    if (!is_list(corners) || 4 != len(corners) || 0 > corners[0] || 0 > corners[1] || 0 > corners[2] || 0 > corners[3]){
      assert(false, "corners must be zero, a positive number or a vector of 4 such numbers");
    }

    if (!is_list(round_edges) || 8 != len(round_edges) || 0 > round_edges[0] || 0 > round_edges[1] || 0 > round_edges[2] || 0 > round_edges[3] || 0 > round_edges[4] || 0 > round_edges[5] || 0 > round_edges[6] || 0 > round_edges[7]){
      assert(false, "round_edges must be zero, a positive number or a vector of 4 or 8 such numbers");
    }
    
    
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

module unf_bezierWedge2d(size=[5, 15], v=false){
  let (size = is_num(size) ? [size, size] : size,
       v = is_list(v) ? v : (is_list(size) && 2 <= len(size) ? [size.x/4, size.y/4] : false)){

    if (!is_list(size) || 2 != len(size) || 0 >=size.x || 0 >= size.y){
      assert(false, "size must be a positive number or a vector of 2 positive numbers");
    }
    
    if (!is_list(v) || 2 != len(v)){
      assert(false, "v must be a number or a vector of 2 numbers");
    }

    
    h = concat([[0, size.y]], [v], [[size.x, 0]]);
    bez = unfy_bezier(h);
    polygon(concat([[0, 0]], bez, [[0, 0]]));
  }
}

module unf_bezierWedge3d(size=[5, 15, 15], rounded_edges=[1, 1]){
  let(size = is_num(size) ? [size, size, size] : size,
      rouded_edges = is_num(rounded_edges) ? [rounded_edges, rounded_edges] : rounded_edges){

    if (!is_list(size) || 3 != len(size) || 0 >=size.x || 0 >= size.y || 0 >= size.z){
      assert(false, "size must be a positive number or a vector of 3 positive numbers");
    }
    
    if (!is_list(rounded_edges) || 2 != len(rounded_edges) || 0 > rounded_edges.x || 0 > rounded_edges.y){
      assert(false, "rounded_edges must be zero, a positive number or a vector of 2 such numbers");
    }
    
    middle_height = size.z - (rounded_edges.y + rounded_edges.x);
    bottom_fn = min(unf_effective_fn(radius=rounded_edges.y, angle=90), rounded_edges.y/$over);
    bottom_fs = rounded_edges.y/bottom_fn;
    bottom_diffs = [ for(i=[0:1/bottom_fn:1]) [rounded_edges.y-(sqrt(pow(rounded_edges.y, 2)-pow(i*rounded_edges.y, 2))), (1-i)*rounded_edges.y] ];
    top_fn = min(unf_effective_fn(radius=rounded_edges.x, angle=90), rounded_edges.x/$over);
    top_fs = rounded_edges.x/top_fn;
    top_diffs = [ for(i=[0:1/top_fn:1]) [rounded_edges.x-(sqrt(pow(rounded_edges.x, 2)-pow(i*rounded_edges.x, 2))), i*rounded_edges.x] ];


    translate([0, size.z, 0]){
      rotate([90, 0, 0]){
	
	// Do Bottom
	if (0 < rounded_edges.y){
	  for (i = [1 : len(bottom_diffs)-1]){
	    bottom = bottom_diffs[i];
	    translate([0, 0, bottom.y]){
	      linear_extrude(bottom_fs){
		unf_bezierWedge2d(size = [size.x-bottom.x, size.y-bottom.x]);
	      }
	    }
	  }
	}
	
	// Do Middle
	if (0 < middle_height){
	  translate([0, 0, rounded_edges.y]){
	    linear_extrude(middle_height){
	      unf_bezierWedge2d(size=[size.x, size.y]);
	    }
	  }
	}

	// Do Top
	if (0 < rounded_edges.x){
	  translate([0, 0, rounded_edges.y + middle_height]){
	    for (i = [len(top_diffs)-2 : -1 : 0]){
	      bottom = top_diffs[i];
	      translate([0, 0, bottom.y]){
		linear_extrude(top_fs){
		  unf_bezierWedge2d(size = [size.x-bottom.x, size.y-bottom.x]);
		}
	      }
	    }
	  }
	}
      
	
      }
    }
  }
}

if ("round_cube" == test_shape){
  unf_roundedCube(size=cube_size, corners=cube_corners, round_edges=cube_round_edges);
}

if ("round_rectangle" == test_shape){
  unf_roundedRectangle(size=rectangle_size, corners=rectangle_corners);
}

if ("bezier_wedge_2d" == test_shape){
  let (v = bez2d_use_custom_v ? bez2d_custom_v : [bez2d_size.x/4, bez2d_size.y/4]){
    unf_bezierWedge2d(size=bez2d_size, v=v);
  }
}

if ("bezier_wedge_3d" == test_shape){
  unf_bezierWedge3d(size=bez3d_size, rounded_edges=bez3d_rounded_edges);
}

