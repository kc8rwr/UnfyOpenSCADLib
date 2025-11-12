//
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

use <unfy_fasteners.scad>
use <unfy_math.scad>

test_shape="round_cube"; //["round_cube", "round_rectangle", "oval", "bezier_wedge_2d", "bezier_wedge_3d", "bezier_frustrum"]

$fn = $preview ? 36 : 360;
$over = 0.1;

/* [ Rounded Cube ] */
cube_size=[20, 10, 5];
cube_corners=[1, 1, 1, 1];
cube_edge_r=[1, 2, 1, 2, 1, 2, 1, 2];

/* [ Rounded Rectangle ] */
rectangle_size=[50, 25];
rectangle_corners=[0, 1, 2, 3];

/* [ Oval ] */
oval_xdiameter = 20;
oval_ydiameter = 10;

/* [ Bezier Wedge 2d] */
bez2d_size=[5, 15];
bez2d_use_custom_v = false;
bez2d_custom_v = [1.25, 3.75];

/* [ Bezier Wedge 3d ] */
bez3d_size=[5, 15, 15];
bez3d_rounded_edges = [1, 2];

/* [ Bezier Frustrum ] */
bezfr_base_dx = 8; //[1:10]
bezfr_base_dy = 6; //[1:10]
bezfr_base_edge_r = 0; //[0:0.01:4]
bezfr_end_dx = 3; //[1:10]
bezfr_end_dy = 5; //[1:10]
bezfr_end_edge_r = 0; //[0:0.01:4]
bezfr_control_height_pct = 50; //[0:100]
bezfr_control_pinch_pct = 50; //[0:200]
bezfr_length = 15; //[1:30]

/*
  Creates a 2d rectangle with rounded corners
  size: may be a 2d vector [x, y] or may be a single number creating a square equivalent to [x, x]
  corners: a vector containing the radiuses of each rounded corner (0 for no-rounding) [(0, 0), (x, 0), (x, y), (0, y)]
           or a single number to make all corners the same
 */
module unf_roundedRectangle(size=[18, 5], corners=[1, 1, 1, 1]){
  let (size = is_num(size) ? [size, size] : size,
       corners = is_num(corners) ? [corners, corners, corners, corners] : corners){

    if (!is_list(size) || 2 != len(size) || 0 >=size.x || 0 >= size.y){
      assert(false, "size must be a positive number or a vector of 2 positive numbers");
    }
    
    if (!is_list(corners) || 4 != len(corners) || 0 > corners[0] || 0 > corners[1] || 0 > corners[2] || 0 > corners[3]){
      assert(false, "corners must be zero, a positive number or a vector of 4 such numbers");
    }

    intersection(){ //intersection with the non-rounded square is a hacky way to deal with
      square(size); //a requested corner radius being greater than the side's length
      hull(){       //FIXME - Do Better
	for (v=[[0, 0, corners[0], -90], [size.x, 0, corners[1], 0], [size.x, size.y, corners[2], 90], [0, size.y, corners[3], 180]]){
	  r = 0 < v.z ? v.z : $over;
	  translate([v.x, v.y]){
	    if (0 < v.z){
	      translate([(0==v.x?v.z:-v.z) ,(0==v.y?v.z:-v.z)]){
		rotate([0, 0, v[3]]){
		  intersection(){
		    circle(r=v.z);
		    translate([0, -v.z]){
		      square(v.z);
		    }
		  }
		}
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
}

/*
  Creates a 3d cuboid with rounded corners
  size: may be a 3d vector [x, y, z] or may be a single number creating a cube equivalent to [x, x, x]
  corners: a vector containing the radiuses of each rounded corner (0 for no-rounding) [(0, 0), (x, 0), (x, y), (0, y)]
           or a single number to make all corners the same
  edge_r: an 8-dimensional vector containing the radiuses of each rounded edge (0 for no-rounding) [FT, RT, BT, LT, FB, RB, BB, LB] - F-Front R-Right B-Back L-Left | T-Top B-Bottom
           or a 4-dimensional vector, creating a cuboid where the top matches the bottom [F, R, B, L]
	   or a 2-dimensional vector, creating a cuboid where the top edges are all one value, the bottom all another [T, B]
           or a single number to make all edges the same
 */
module unf_roundedCuboid(size=[20, 10, 5], corners=[1, 1, 1, 1], edge_r=[1, 2, 1, 2, 1, 2, 1, 2]){
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

       edge_r = is_num(edge_r) ? [edge_r, edge_r, edge_r, edge_r, edge_r, edge_r, edge_r, edge_r] : (
	 (!is_list(edge_r)) ? edge_r : (
	   8==len(edge_r) ? edge_r : (
	     4==len(edge_r) ? [edge_r[0], edge_r[1], edge_r[2], edge_r[3], edge_r[0], edge_r[1], edge_r[2], edge_r[3]] : (
	       2==len(edge_r) ? [edge_r[0], edge_r[0], edge_r[0], edge_r[0], edge_r[1], edge_r[1], edge_r[1], edge_r[1]] : edge_r
	     )
	   )
	 )
       )
  ){
    
    if (!is_list(size) || 3 != len(size) || 0 >=size.x || 0 >= size.y || 0 >= size.z){
      assert(false, "size must be a positive number or a vector of 3 positive numbers");
    }
    
    if (!is_list(corners) || 4 != len(corners) || 0 > corners[0] || 0 > corners[1] || 0 > corners[2] || 0 > corners[3]){
      assert(false, "corners must be zero, a positive number or a vector of 4 such numbers");
    }

    if (!is_list(edge_r) || 8 != len(edge_r) || 0 > edge_r[0] || 0 > edge_r[1] || 0 > edge_r[2] || 0 > edge_r[3] || 0 > edge_r[4] || 0 > edge_r[5] || 0 > edge_r[6] || 0 > edge_r[7]){
      assert(false, "edge_r must be zero, a positive number or a vector of 4 or 8 such numbers");
    }
    
    top_calcs = (0 < max(edge_r[0], edge_r[1], edge_r[2], edge_r[3])) ? calc(size.x, size.y, edge_r[0], edge_r[1], edge_r[2], edge_r[3]) : false;
    top_height = is_list(top_calcs) ? top_calcs[len(top_calcs)-1][4] : 0;
    bottom_calcs = (0 < max(edge_r[4], edge_r[5], edge_r[6], edge_r[7])) ? calc(size.x, size.y, edge_r[4], edge_r[5], edge_r[6], edge_r[7]) : false;
    bottom_height = is_list(bottom_calcs) ? bottom_calcs[len(bottom_calcs)-1][4] : 0;
    middle_height = size.z - (top_height + bottom_height);
    
    // Do Bottom
    if (0 < bottom_height){
      for(i = [len(bottom_calcs)-1:-1:1]) {
	let(top = bottom_calcs[(i-1)],
	    bottom = bottom_calcs[i]){
	  if (0 < bottom[2] && 0 < bottom[3]){
	    hull(){
	      translate([bottom[0], bottom[1], bottom_height-bottom[4]]){
		linear_extrude($over){
		  unf_roundedRectangle(size=[bottom[2], bottom[3]], corners=corners);
		}
	      }
	      translate([top[0], top[1], bottom_height-top[4]]){
		linear_extrude($over){
		  unf_roundedRectangle(size=[max($over, top[2]), max($over, top[3])], corners=corners);
		}
	      }
	    }
	  }
	}
      }
    }

    // Do Middle
    if (0 < middle_height){
      translate([0, 0, bottom_height]){
	linear_extrude(middle_height){
	  unf_roundedRectangle(size=[size.x, size.y], corners=corners);
	}
      }
    }

    // Do Top
    if (0 < top_height){
      translate([0, 0, bottom_height + middle_height - $over]){
	for(i = [1:len(top_calcs)-1]) {
	  let(top = top_calcs[i],
	      bottom = top_calcs[(i-1)]){
	    if (0 < top[2] && 0 < top[3]){
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
}

/*
  Draw an oval by size
*/
module unf_oval(size = [8, 4]){
	if (size.x == size.y){
		circle(d=size.x);
	} else {
		resize(size){
			circle(1);
		}
	}
}

/*
  Sort of a right-triangle but the hypotenuse is a bezier curve pulled in rather than a straight line
  Good for building up inside-corners for a more rounded look or added strength
  size = a 2d vector [x, y] or a single number to be used for both, same as [x, x]
  v - a vector to affect the shape of the bezier curve
*/
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

/*
  A 3-dimensional wedge shape, fits inside a right-angle with a bezier curve along the hypotenuse
  Good for building up inside-corners for a more rounded look or added strength
  size = a 3d vector [x, y, z] or a single number to be used for both, same as [x, x, x]
  v - a vector to affect the shape of the bezier curve
*/
module unf_bezierWedge3d(size=[5, 15, 15], rounded_edges=[1, 1]){
  let(size = is_num(size) ? [size, size, size] : size,
      rounded_edges = is_num(rounded_edges) ? [rounded_edges, rounded_edges] : rounded_edges){
    
    if (!is_list(size) || 3 != len(size) || 0 >=size.x || 0 >= size.y || 0 >= size.z){
      assert(false, "size must be a positive number or a vector of 3 positive numbers");
    }
    
    if (!is_list(rounded_edges) || 2 != len(rounded_edges) || 0 > rounded_edges.x || 0 > rounded_edges.y){
      assert(false, str("rounded_edges, '", rounded_edges, "' must be zero, a positive number or a vector of 2 such numbers"));
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

module unf_bezier_frustrum(
	base_d = 0,
	base_dx = 80,
	base_dy = 60,
	base_edge_r = 0,
	end_d = 0,
	end_dx = 20,
	end_dy = 40,
	end_edge_r = 0,
	control_height_pct = 50,
	control_pinch_pct = 50,
	length = 300,
) {
	let (
		base_dx = 0 < base_d ? base_d : base_dx,
		base_dy = 0 < base_d ? base_d : base_dy,
		end_dx = 0 < end_d ? end_d : end_dx,
		end_dy = 0 < end_d ? end_d : end_dy,
		base_edge_r = min(base_edge_r, (base_dx/2), (base_dy/2), (length/2)),
		end_edge_r = min(end_edge_r, (end_dx/2), (end_dy/2), (length/2)),
	){
		assert(0 < base_dx, "Either base_d or base_dx must be greater than zero");
		assert(0 < base_dy, "Either base_d or base_dy must be greater than zero");
		assert(0 <= base_edge_r, "Base_edge_r must not be below zero");
		assert(0 < end_dx, "Either end_d or end_dx must be greater than zero");
		assert(0 < end_dy, "Either end_d or end_dy must be greater than zero");
		assert(0 <= end_edge_r, "End_edge_r must not be below zero");
		assert(0 < length, "Length must be greater than zero");

		control_z = length * control_height_pct / 100;
		control_x = (base_dx + ((end_dx-base_dx)*control_height_pct/100)) * control_pinch_pct / 100;
		control_y = (base_dy + ((end_dy-base_dy)*control_height_pct/100)) * control_pinch_pct / 100;
		bez_x = unfy_bezier([[base_dx, 0], [control_x, control_z], [end_dx, length]]);
		bez_y = unfy_bezier([[0, base_dy], [control_z, control_y], [length, end_dy]]);

		for (i = [0: len(bez_x)-2]){
			x1 = bez_x[i][0];
			z1 = bez_x[i][1];
			y1 = lookup(z1, bez_y);
			x2 = bez_x[i+1][0];
			z2 = bez_x[i+1][1]-$over;
			y2 = lookup(z2, bez_y);
			lip = (z1 < base_edge_r) ? (base_edge_r-(sqrt(pow(base_edge_r, 2)-pow(base_edge_r-z1, 2)))) : (
				(z2 > (length - end_edge_r) ? (end_edge_r-sqrt(pow(end_edge_r,2)-pow((z2-(length-end_edge_r)),2))) : (
					0)));;
			hull(){
				translate([0, 0, z1]){
					linear_extrude($over){
						unf_oval([x1-lip, y1-lip]);
					}
				}
				translate([0, 0, z2]){
					linear_extrude($over){
						unf_oval([x2-lip, y2-lip]);
					}
				}
			}
		}
	}
}

if ("round_cube" == test_shape){
  unf_roundedCuboid(size=cube_size, corners=cube_corners, edge_r=cube_edge_r);
}

if ("round_rectangle" == test_shape){
  unf_roundedRectangle(size=rectangle_size, corners=rectangle_corners);
}

if ("oval" == test_shape){
	unf_oval([oval_xdiameter, oval_ydiameter]);
 }

if ("bezier_wedge_2d" == test_shape){
  let (v = bez2d_use_custom_v ? bez2d_custom_v : [bez2d_size.x/4, bez2d_size.y/4]){
    unf_bezierWedge2d(size=bez2d_size, v=v);
  }
}

if ("bezier_wedge_3d" == test_shape){
  unf_bezierWedge3d(size=bez3d_size, rounded_edges=bez3d_rounded_edges);
}

if ("bezier_frustrum" == test_shape){
	unf_bezier_frustrum(
		base_dx = bezfr_base_dx,
		base_dy = bezfr_base_dy,
		base_edge_r = bezfr_base_edge_r,
		end_dx = bezfr_end_dx,
		end_dy = bezfr_end_dy,
		end_edge_r = bezfr_end_edge_r,
		length = bezfr_length,
		control_height_pct = bezfr_control_height_pct,
		control_pinch_pct = bezfr_control_pinch_pct,
	);
 }

module unf_mount_tab(tab_length, tab_height, bolt_d, washer_v, wall){
  difference(){
    unf_roundedCuboid([tab_length+(4*wall), tab_length, tab_height], edge_r=[wall, wall, 0, wall, 0, 0, 0, 0], corners=[wall, wall, 0, 0]);
    translate([(tab_length/2)+(2*wall), tab_length/2, -$over]){
      cylinder(d=bolt_d, h=tab_height+(2*$over));
      translate([0, 0, wall+(2*$over)]){
	unf_wsh(size=washer_v, ext=$over);
      }
    }
  }
  translate([wall, tab_length, tab_height]){
    rotate([0, 0, -90]){
      unf_bezierWedge3d(size=[wall, wall, tab_length+(2*wall)]);
      for(y=[0, tab_length+wall]){
	translate([0, y, 0]){
	  unf_bezierWedge3d(size=[tab_length-wall, tab_length-wall, wall], rounded_edges=wall/2);
	}
      }
    }
  }
}
