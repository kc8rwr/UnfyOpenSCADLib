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

use <unfy_lists.scad>
use <unfy_math.scad>

parm_part = "Collection"; // ["Collection", "HexHeadBolt_Test_Block", "CapHeadBolt_Test_Block", "CountersunkBolt_Test_Block", "HexNut_Test_Block", "SquareNut_Test_Block", "Washer_Test_Block", "Heatset_Test_Block", "Bolt_Distortion_Test"]

parm_size = "m3"; // ["m2", "m2.5", "m3", "m4", "#00", "#000", "#0000", "#6", "#8", "1/4\"", "1/2\""]

//horizontal bolt shaft distortion height (as percentage of diameter)
$unf_hdist_y = 10; //[0:100]

//horizontal bolt shaft distortion width (as percentage of diameter)
$unf_hdist_x = 80; //[0:100]

//distance subtractions should "hang over"
$over = 0.1;
$wall = 2;

/* [Horizontal Shaft Distortion Test Block] */
//depth
parm_dist_depth = 10;

//steps
parm_dist_steps = 5;

//minimum distance between holes
parm_dist_min_spacing = 3;

//minimum distortion width
parm_dist_min_dist_x = 25;

//maximum distortion width
parm_dist_max_dist_x = 100;

//minimum distortion height
parm_dist_min_dist_y = 5;

//maximum distortion height
parm_dist_max_dist_y = 20;

//include a non-distorted control hole
parm_dist_include_control = true;

$fn = $preview ? 36 : 360;

/************************ Common *********************************************/

function unf_fnr_name(in) = is_list(in) ? in[0] : in;

function unf_fnr_shaft_diameter(in) = is_list(in) ? in[1] : (
  "m" == in[0] || "M" == in[0] ? (
    unf_stToNum(unf_sub(in, 1))
  ) : (
    "\"" == in[len(in)-1] ? 25.4 * unf_stToNum(unf_sub(in, 0, len(in)-1)) : (
      "#0000" == in ? 0.533 : ( // 0.021"
	"#000" == in ? 0.864 : ( // 0.034"
	  "#00" == in ? 1.194 : ( // 0.047"
	    "#" != in[0] ? unf_fnr_shaft_diameter("M3") : (
	      unf_round(place=-3,
			num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
				       [[0, 1.524], //0.06"
					[1, 1.854], //0.073"
					[2, 2.184], //0.086"
					[3, 2.515], //0.099"
					[4, 2.845], //0.112"
					[5, 3.175], //0.125"
					[6, 3.505], //0.138"
					[8, 4.166], //0.164"
					[10, 4.826], //0.19"
					[12, 5.486]]) //0.216"
	      )
	    )
	  )
	)
      )
    )
  )
);

/************************ Distorted Shafts ***********************************/

module unf_shaft(diameter=3, length=10, distorted=false){
  if (distorted || 0 == $unf_hdist_y || 0 == $unf_hdist_x){
    dist_d =(diameter * $unf_hdist_x) / 100;
    linear_extrude(length) {
      hull(){
	circle(d=diameter);
	translate([0, ((diameter-dist_d)/2)+((diameter*$unf_hdist_y)/200)]){
	  circle(d=dist_d);
	}
      }
    }
  } else { // !distorted
    cylinder(d=diameter, h=length);
  }
}


/*********************** Cap Bolts unf_cap_ **********************************/
//[name, bolt_diameter, head_diameter, head_height, default_length]

function unf_cap_v(size) = is_list(size) ? size : [
  unf_fnr_name(size),
  unf_fnr_shaft_diameter(size),
  unf_cap_head_diameter(size),
  unf_cap_head_height(size),
  unf_cap_default_length(size)
];

function unf_cap_head_diameter(in) = is_list(in) ? in[2] : (
  "m" == in[0] || "M" == in[0] ? (
    unf_round(place=-3,
	      num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
			     [[0, 0],
			      [3, 5.05], //verified
			      [4, 7], //verified
			      [5, 8.5],
			      [6, 10],
			      [8, 13],
			      [10, 16],
			      [12, 18],
			      [14, 21],
			      [16, 24],
			      [20, 30],
			      [24, 36],
			      [30, 45],
			      [36, 54],
			      [42, 63],
			      [48, 72]])
    )
  ) : (
    "\"" == in[len(in)-1] ? (
      unf_round(place=-3,
		num=unf_lookup(25.4*unf_stToNum(unf_sub(in, 0, len(in)-1)),
			       [[0, 0],
				[4.763, 7.925], // 3/16", 0.312"
				[6.35, 9.525], // 1/4", 0.375"
				[7.938, 11.1], // 5/16", 0.437"
				[9.525, 14.275], // 3/8", 0.562"
				[11.113, 15.875], // 7/16", 0.625"
				[12.7, 19.05], // 1/2", 0.750"
				[15.875, 22.225], // 5/8", 0.875"
				[19.05, 25.4], // 3/4", 1.00"
				[22.225, 28.575], // 7/8", 1.125"
				[25.4, 33.325]]) // 1", 1.312"
      )
    ) : (
      "#0000" == in ? unf_cap_head_diameter("M0.53") : (
	"#000" == in ? unf_cap_head_diameter("M0.86") : (
	  "#00" == in ? unf_cap_head_diameter("M1.19") : (
	    "#" != in[0] ? unf_cap_head_diameter("M3") : (
	      unf_round(place=-3,
			num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
				       [[0, 2.438], // 0.096 
					[8, 6.858], //0.27"
					[10, 7.925]]) //0.312"
	      )
	    )
	  )
	)
      )
    )
  )
);

function unf_cap_head_height(in) = is_list(in) ? in[3] : unf_fnr_shaft_diameter(in);

function unf_cap_default_length(in) = is_list(in) ? in[4] : unf_fnr_shaft_diameter(in) * 15 / 3;

module unf_cap(screw = "m3", length = -1, head_ext = -1, distorted = false){
  let (head_ext = (0 <= head_ext) ? head_ext : $over,
       screw = is_list(screw) ? screw : unf_cap_v(screw),
       length = 0 < length ? length : unf_cap_default_length(screw)){
    echo (str("CAP: ", screw));
    head_d = unf_cap_head_diameter(screw);
    head_height = unf_cap_head_height(screw);
    shaft_d = unf_fnr_shaft_diameter(screw);
    if (0 < head_ext){
      translate([0, 0, -head_ext]){
	color("grey", 0.25){
	  cylinder(h = head_ext, d = head_d);
	}
      }
    }
    cylinder(h = head_height, d = head_d);
    unf_shaft(length = length + head_height, diameter = shaft_d, distorted = distorted);
  }
}



/************************ Countersunk Bolts unf_csk_ *************************/

//[name, bolt_diameter, head_diameter, head_height, default_length]

function unf_csk_v(size) = is_list(size) ? size : [
  unf_fnr_name(size),
  unf_fnr_shaft_diameter(size),
  unf_csk_head_diameter(size),
  unf_csk_head_height(size),
  unf_csk_default_length(size)
];

function unf_csk_head_diameter(in) = is_list(in) ? in[2] : (
  "m" == in[0] || "M" == in[0] ? (
    unf_round(place=-3,
	      unf_lookup(unf_stToNum(unf_sub(in, 1)),
			 [[0, 0],
			  [3, 6], // verified
			  [4, 8], // verified
			  [5, 10],
			  [6, 12],
			  [8, 16],
			  [10, 20],
			  [12, 24],
			  [14, 27],
			  [16, 30],
			  [20, 36],
			  [24, 39]])
    )
  ) : (
    "\"" == in[len(in)-1] ? (
      unf_round(place=-3,
		num=unf_lookup(25.4*unf_stToNum(unf_sub(in, 0, len(in)-1)),
			       [[0, 0],
				[3.175, 5.461], // 1/8", 0.215"
				[4.763, 8.204], // 3/16", 0.323"
				[6.35, 10.973], // 1/4", 0.432"
				[7.938, 13.767], // 5/16", 0.542"
				[9.525, 16.535], // 3/8", 0.651"
				[11.113, 19.304], // 7/16", 0.76"
				[12.7, 22.098], // 1/2", 0.87"
				[15.875, 27.661], // 5/8", 1.089"
				[19.05, 33.223]]) // 3/4", 1.308"
      )
    ) : (
      "#0000" == in ? 0.94 : ( // 0.037"
	"#000" == in ? 1.473 : ( // 0.058"
	  "#00" == in ? 2.159 : ( // 0.085"
	    "#" != in[0] ? unf_csk_head_diameter("M3") : (
	      unf_round(place=-3,
			num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
				       [[0, 3.023], //0.119"
					[1, 3.708], //0.146"
					[2, 4.369], //0.172"
					[3, 5.055], //0.199"
					[4, 5.715], //0.225"
					[6, 7.087], //0.279"
					[8, 8.433], //0.332"
					[10, 9.779]]) //0.385"
	      )
	    )
	  )
	)
      )
    )
  )
);

function unf_csk_head_height(in) = is_list(in) ? in[3] : (
  "m" == in[0] || "M" == in[0] ? (
    unf_round(place=-3,
	      num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
			     [[0, 0],
			      [3, 2], // verified
			      [4, 2.3], // verified
			      [5, 2.8],
			      [6, 3.3],
			      [8, 4.4],
			      [10, 5.5],
			      [12, 6.5],
			      [14, 7],
			      [16, 7.5],
			      [20, 8.5],
			      [24, 14]])
    )
  ) : (
    "\"" == in[len(in)-1] ? (
      unf_round(place=-3,
		num=unf_lookup(25.4*unf_stToNum(unf_sub(in, 0, len(in)-1)),
			       [[0, 0],
				[3.175, 1.448], // 1/8", 0.057"
				[4.763, 2.134], // 3/16", 0.084"
				[6.35, 2.845], // 1/4", 0.112"
				[7.938, 3.556], // 5/16", 0.140"
				[9.525, 4.267], // 3/8", 0.168"
				[11.113, 4.978], // 7/16", 0.196"
				[12.7, 5.715], // 1/2", 0.225"
				[15.875, 7.137], // 5/8", 0.281"
				[19.05, 8.56]]) // 3/4", 0.337"
      )
    ) : (
      "#0000" == in ? 0.229 : ( // 0.009"
	"#000" == in ? 0.356 : ( // 0.014"
	  "#00" == in ? 0.508 : ( // 0.020"
	    "#" != in[0] ? unf_csk_head_height("M3") : (
	      unf_round(place=-3,
			num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
				       [[0, 0.660], // 0.026"
					[1, 0.787], // 0.031"
					[2, 0.94], // 0.037"
					[3, 1.092], // 0.043"
					[4, 1.245], // 0.049"
					[6, 1.524], // 0.060"
					[8, 1.83], // 0.072"
					[10, 2.108]]) // 0.083"
	      )
	    )
	  )
	)
      )
    )
  )
);

function unf_csk_default_length(in) = is_list(in) ? in[4] : unf_fnr_shaft_diameter(in) * 15 / 3;

module unf_csk(screw = "m3", length = -1, head_ext = -1, distorted = false){
  let (head_ext = (0 <= head_ext) ? head_ext : $over,
       screw = is_list(screw) ? screw : unf_csk_v(screw),
       length = 0 < length ? length : unf_csk_default_length(screw)){
    echo (str("CSK: ", screw));
    head_d = unf_csk_head_diameter(screw);
    head_height = unf_csk_head_height(screw);
    shaft_d = unf_fnr_shaft_diameter(screw);
    if (0 < head_ext){
      translate([0, 0, -head_ext]){
	color("grey", 0.25){
	  cylinder(h = head_ext, d = head_d);
	}
      }
    }
    cylinder(h = head_height, d1 = head_d, d2 = shaft_d);
    unf_shaft(length = length + head_height, diameter = shaft_d, distorted = distorted);
  }
}


/************************ Hex Head Bolts unf_hex_ *************************/

//[name, bolt_diameter, head_diameter, head_height, default_length]

function unf_hex_v(size) = is_list(size) ? size : [
  unf_fnr_name(size),
  unf_fnr_shaft_diameter(size),
  unf_hex_head_diameter(size),
  unf_hex_head_height(size),
  unf_hex_default_length(size)
];

function unf_hex_head_diameter(in) = is_list(in) ? in[2] : (
  "m" == in[0] || "M" == in[0] ? (
    unf_round(place=-3,
	      unf_lookup(unf_stToNum(unf_sub(in, 1)),
			 [[0, 0],
			  [3, 6.1], // verified
			  [4, 7.66], // verified
			  [5, 8.79],
			  [6, 11.05],
			  [8, 14.38],
			  [10, 18.9],
			  [12, 21.1],
			  [14, 24.49],
			  [16, 26.75],
			  [20, 35.53],
			  [22, 35.72],
			  [24, 39.98],
			  [27, 45.2],
			  [30, 50.85],
			  [33, 55.37],
			  [36, 60.79],
			  [42, 71.3],
			  [48, 82.6]])
    )
  ) : (
    "\"" == in[len(in)-1] ? (
      unf_round(place=-3,
		num=unf_lookup(25.4*unf_stToNum(unf_sub(in, 0, len(in)-1)),
			       [[0, 0],
				[6.35, 12.45], // 1/4", lst .55
				[7.938, 14.224], // 5/16", 0.56" verified
				[9.525, 16.078], // 3/8", 0.633" verified
				[11.113, 20.828], // 7/16", 0.82"
				[12.7, 24.13], // 1/2", 0.95"
				[14.288, 26.924], // 9/16", 1.06"
				[15.875, 29.718], // 5/8", 1.17"
				[19.05, 35.306], // 3/4", 1.39"
				[22.225, 38.1], // 7/8", 1.5"
				[25.4, 43.434], // 1", 1.71"
				[28.575, 49.022], // 1 1/8", 1.93"
				[31.75, 54.61], // 1 1/4", 2.15"
				[34.925, 60.198], // 1 3/8", 2.37"
				[38.1, 65.024], // 1 1/2", 2.56"
				[44.45, 75.692], // 1 3/4", 2.98"
				[50.8, 81.026]]) // 2", 3.19"
      )
    ) : (
      "#0000" == in ? unf_hex_head_diameter(str("M", in)) : ( // no real data
	"#000" == in ? unf_hex_head_diameter(str("M", in)) : ( // no real data
	  "#00" == in ? unf_hex_head_diameter(str("M", in)) : ( // no real data
	    "#" != in[0] ? unf_hex_head_diameter("M3") : (
	      unf_hex_head_diameter(str("M", unf_fnr_shaft_diameter(in))) // no real data
	    )
	  )
	)
      )
    )
  )
);

function unf_hex_head_height(in) = is_list(in) ? in[3] : (
  "m" == in[0] || "M" == in[0] ? (
    unf_round(place=-3,
	      num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
			     [[0, 0],
			      [3, 2], // verified
			      [4, 2.8], // verified
			      [5, 3.5],
			      [6, 4.0],
			      [8, 5.3],
			      [10, 6.4],
			      [12, 7.5],
			      [14, 8.8],
			      [16, 10],
			      [20, 12.5],
			      [18, 11.5],
			      [20, 12.5],
			      [22, 14],
			      [24, 15],
			      [27, 17.0],
			      [30, 18.7],
			      [33, 21],
			      [36, 22.5],
			      [42, 26],
			      [45, 28],
			      [48, 30]])
    )
  ) : (
    "\"" == in[len(in)-1] ? (
      unf_round(place=-3,
		num=unf_lookup(25.4*unf_stToNum(unf_sub(in, 0, len(in)-1)),
			       [[0, 0],
				[6.35, 4.2], // 1/4", last 4.3
				[7.938, 5.530], // 5/16" 0.218" // verified
				[9.525, 6.604], // 3/8" 0.26" // verified
				[11.113, 7.671], // 7/16" 0.302"
				[12.7, 8.458], // 1/2" 0.333"
				[14.288, 9.271], // 9/16" 0.365"
				[15.875, 10.592], // 5/8" 0.417"
				[19.05, 12.7], // 3/4" 0.5"
				[22.225, 14.808], // 7/8" 0.583"
				[25.4, 16.916], // 1" 0.666"
				[28.575, 19.05], // 1 1/8", 0.75"
				[31.75, 21.082], // 1 1/4", 0.83"
				[34.925, 23.368], // 1 3/8", 0.92"
				[38.1, 25.4], // 1 1/2", 1"
				[44.45, 29.718], // 1 3/4", 1.17"
				[50.8, 33.782]]) // 2", 1.33"
      )
    ) : (
      "#0000" == in ? unf_hex_head_height(str("M", in)) : ( // no real data
	"#000" == in ? unf_hex_head_height(str("M", in)) : ( // no real data
	  "#00" == in ? unf_hex_head_height(str("M", in)) : ( // no real data
	    "#" != in[0] ? unf_hex_head_height("M3") : (
	      unf_hex_head_height(str("M", unf_fnr_shaft_diameter(in))) // no real data
	    )
	  )
	)
      )
    )
  )
);

function unf_hex_default_length(in) = is_list(in) ? in[4] : unf_fnr_shaft_diameter(in) * 15 / 3;

module unf_hex(screw = "m3", length = -1, head_ext = -1, distorted = false){
  let (head_ext = (0 <= head_ext) ? head_ext : $over,
       screw = is_list(screw) ? screw : unf_hex_v(screw),
       length = 0 < length ? length : unf_hex_default_length(screw)){
    echo (str("HEX: ", screw));
    head_d = unf_hex_head_diameter(screw);
    head_height = unf_hex_head_height(screw);
    shaft_d = unf_fnr_shaft_diameter(screw);
    rotate([0, 0, 30]){
      if (0 < head_ext){
	translate([0, 0, -head_ext]){
	  color("grey", 0.25){
	    cylinder(h = head_ext, d = head_d, $fn=6);
	  }
	}
      }
      cylinder(h = head_height, d = head_d, $fn=6);
    }
    unf_shaft(length = length + head_height, diameter = shaft_d, distorted = distorted);
  }
}


/************************ Heatset Inserts unf_hst_ ***************************/

//[name, shaft_diameter, insert_diameter, length]
// note - these are pilot hole dimensions, not dimensions of the actual insert

function unf_hst_v(size="m3", length="medium") = is_list(size) ? size : (
  [unf_fnr_name(size),
   unf_fnr_shaft_diameter(size),
   unf_hst_diameter(size),
   unf_hst_length(size, length)]
);
  


function unf_hst_diameter(in="m3") = is_list(in) ? in[2] : (
  "m" == in[0] || "M" == in[0] ? (
    unf_round(place=-3,
	      num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
			     [[0, 0],
			      [2, 2.6], //verified
			      [2.5, 3.5], // verified? much variance, this size hole is almost to small for some, almost too big for others
			      [3, 4.5], // verified
			      [4, 5]]) // verified
    )
  ) : (
    "\"" == in[len(in)-1] ? (
      unf_hst_diameter(str("M", 25.4*unf_stToNum(unf_sub(in, 0, len(in)-1))))
    ) : (
      "#0000" == in ? unf_hst_diameter(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	"#000" == in ? unf_hst_diameter(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	  "#00" == in ? unf_hst_diameter(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	    "#" != in[0] ? unf_hst_diameter("M3") : (
	      unf_round(place=-3,
			num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
				       [[0, unf_hst_diameter(str("M", unf_fnr_shaft_diameter("#0")))], // No Data
					[4, 3.5], // verified
					[6, 4.5], // verified
					[8, 5.5], // verified
					[10, 6.1]]) // verified
	      )
	    )
	  )
	)
      )
    )
  )
);

function unf_hst_length(in="m3", length="medium") = is_num(length) ? length : (
  is_list(in) ? in[3] : (
    "m" == in[0] || "M" == in[0] ? (
      unf_round(place=-3,
		num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
			       "small" == length ?
			       [[0, 0],
				[2, 3],
				[2.5, 3],
				[3, 3.1],
				[4, 4.1]]
			       :
			       ("large" == length ?
				[[0, 0],
				 [2, 8.1],
				 [2.5, 5.1],
				 [3, 8],
				 [4, 8.1]]
				:
				[[0, 0],
				 [2, 4],
				 [2.5, 4],
				 [3, 5],
				 [4, 6.2]])
		)
      )
      
    ) : (
      "\"" == in[len(in)-1] ? (
	unf_hst_length(str("M", 25.4*unf_stToNum(unf_sub(in, 0, len(in)-1))), length) // No Data
      ) : (
	"#0000" == in ? unf_hst_length(str("M", unf_fnr_shaft_diameter(in)), length) : ( // No Data
	  "#000" == in ? unf_hst_length(str("M", unf_fnr_shaft_diameter(in)), length) : ( // No Data
	    "#00" == in ? unf_hst_length(str("M", unf_fnr_shaft_diameter(in)), length) : ( // No Data
	      "#" != in[0] ? unf_hst_length("M3") : (
		unf_round(place=-3,
			  num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
					 [[0, unf_hst_length(str("M", unf_fnr_shaft_diameter("#0")), length=length)], // No Data
					  [4, 5.8],
					  [6, 7.14],
					  [8, 9.06],
					  [10, 10.64]])
		)
	      )
	    )
	  )
	)
      )
    )
  )
);

function unf_hst_width(size, opening_taper_percent=10) =
  unf_hst_diameter(size)+(unf_hst_diameter(size)*opening_taper_percent/100);

module unf_hst(size="m3", opening_taper_percent=10, length="medium", head_ext=-1, extra_room=true, bolt_hole_depth=0){
  let (
    size = is_list(size) ? size : unf_hst_v(size=size, length=length)){
    let (
      bolt_diameter = unf_fnr_shaft_diameter(size),
      opening_diameter = unf_hst_width(size, opening_taper_percent),
      diameter = unf_hst_diameter(size),
      length = unf_hst_length(size),
      head_ext = (0 <= head_ext) ? head_ext : $over
    ) {
      echo(str("HST: ", size));
      //main body
      cylinder(h=length, d1=opening_diameter, d2=diameter);
      //head extension
      if (0 < head_ext){
	translate([0, 0, -head_ext]){
	  color("gray", 0.25){
	    cylinder(h=head_ext, d=opening_diameter);
	  }
	}
      }
      //extra room
      if (extra_room){
	er=0.2;
	translate([0, 0, length]){
	  color("blue"){
	    cylinder(d1=diameter, d2=(1-er)*diameter, h=er*diameter);
	  }
	} 
      }
      //bolt hole
      if (0 < bolt_hole_depth){
	translate([0, 0, length]){
	  color("orange"){
	    cylinder(d=bolt_diameter, h=olt_hole_depth);
	  }
	}
      }
    }
  }
}

/************************ Hex Nut unf_nut_ *************************/

//[name, nut_diameter, height]

function unf_nut_v(size) = is_list(size) ? size : [
  unf_fnr_name(size),
  unf_fnr_shaft_diameter(size),
  unf_nut_diameter(size),
  unf_nut_height(size)
];

function unf_nut_diameter(in) = is_list(in) ? in[2] : (
  "m" == in[0] || "M" == in[0] ? (
    unf_round(place=-3,
	      unf_lookup(unf_stToNum(unf_sub(in, 1)),
			 [[0, 0],
			  [1.6, 3.7],
			  [2, 4.62],
			  [2.5, 5.77],
			  [3, 6.35],
			  [3.5, 6.93],
			  [4, 8.08],
			  [5, 9.24],
			  [6, 11.55],
			  [8, 12.73],
			  [10, 18.48],
			  [12, 20.78],
			  [14, 24.25],
			  [16, 27.71],
			  [20, 34.64],
			  [24, 41.57],
			  [30, 53.12],
			  [36, 63.51]])
    )
  ) : (
    "\"" == in[len(in)-1] ? (
      unf_round(place=-3,
		num=unf_lookup(25.4*unf_stToNum(unf_sub(in, 0, len(in)-1)),
			       [[0, 0],
				[6.35, 15.723], // 1/4", 0.619"
				[7.938, 20.193], // 5/16", 0.795"
				[9.525, 22.454]]) // 3/8", 0.884"
      )
    ) : (
      "#0000" == in ? unf_nut_diameter(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	"#000" == in ? unf_nut_diameter(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	  "#00" == in ? unf_nut_diameter(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	    "#" != in[0] ? unf_nut_diameter("M3") : (
	      unf_round(place=-3,
			num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
				       [[0, 5.613], //0.221"
					[1, 5.613], //0.221"
					[2, 6.731], //0.265"
					[3, 6.731], //0.265"
					[4, 8.992], //0.354"
					[5, 11.227], //0.442"
					[6, 11.227], //0.442"
					[8, 12.344], //0.486"
					[10, 13.462], //0.530"
					[12, 15.723]]) //0.619"
	      )
	    )
	  )
	)
      )
    )
  )
);

function unf_nut_height(in) = is_list(in) ? in[3] : (
  "m" == in[0] || "M" == in[0] ? (
    unf_round(place=-3,
	      num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
			     [[0, 0],
			      [1.6, 1.3],
			      [2, 1.6],
			      [2.5, 2],
			      [3, 2.4],
			      [3.5, 2.8],
			      [4, 3.2],
			      [5, 4.7],
			      [6, 5.2],
			      [8, 6.8],
			      [10, 8.4],
			      [12, 10.8],
			      [14, 12.8],
			      [16, 14.8],
			      [20, 18],
			      [24, 21.6],
			      [30, 25.6],
			      [36, 31]])
    )
  ) : (
    "\"" == in[len(in)-1] ? (
      unf_round(place=-3,
		num=unf_lookup(25.4*unf_stToNum(unf_sub(in, 0, len(in)-1)),
			       [[0, 0],
				[6.35, 4.902], // 1/4", 0.193"
				[7.938, 5.625], // 5/16", 0.225"
				[9.525, 6.528]]) // 3/8", 0.257"
      )
    ) : (
      "#0000" == in ? unf_nut_height(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	"#000" == in ? unf_nut_height(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	  "#00" == in ? unf_nut_height(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	    "#" != in[0] ? unf_nut_height("M3") : (
	      unf_round(place=-3,
			num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
				       [[0, 1.27], // 0.050"
					[1, 1.27], // 0.050"
					[2, 1.676], // 0.066"
					[3, 1.676], // 0.066"
					[4, 2.489], // 0.098"
					[5, 2.896], // 0.114"
					[6, 2.896], // 0.114"
					[8, 3.302], // 0.130"
					[10, 3.302], // 0.130"
					[12, 4.089]]) // 0.161"
	      )
	    )
	  )
	)
      )
    )
  )
);

module unf_nut(size = "m3", ext = -1){
  let (ext = (0 <= ext) ? ext : $over,
       size = is_list(size) ? size : unf_nut_v(size)){
    echo (str("Nut: ", size));
    diameter = unf_nut_diameter(size);
    height = unf_nut_height(size);
    if (0 < ext){
      translate([0, 0, -ext]){
	color("grey", 0.25){
	  cylinder(h=ext, d=diameter, $fn=6);
	}
      }
    }
    cylinder(h=height, d=diameter, $fn=6);
  }
}


/************************ Square Nut unf_sqr_ *************************/

//[name, side_length, height]

function unf_sqr_v(size) = is_list(size) ? size : [
  unf_fnr_name(size),
  unf_fnr_shaft_diameter(size),
  unf_sqr_length(size),
  unf_sqr_height(size)
];

function unf_sqr_length(in) = is_list(in) ? in[2] : (
  "m" == in[0] || "M" == in[0] ? (
    unf_round(place=-3,
	      unf_lookup(unf_stToNum(unf_sub(in, 1)),
			 [[0, 0],
			  [5, 8],
			  [6, 10],
			  [8, 13],
			  [10, 17],
			  [12, 19],
			  [16, 24]])
    )
  ) : (
    "\"" == in[len(in)-1] ? (
      unf_round(place=-3,
		num=unf_lookup(25.4*unf_stToNum(unf_sub(in, 0, len(in)-1)),
			       [[0, 0],
				[6.35, 11.125], // 1/4", 0.438"
				[7.938, 14.275], // 5/16", 0.562"
				[9.525, 15.875]]) // 3/8", 0.625"
      )
    ) : (
      "#0000" == in ? unf_sqr_length(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	"#000" == in ? unf_sqr_length(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	  "#00" == in ? unf_sqr_length(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	    "#" != in[0] ? unf_sqr_length("M3") : (
	      unf_round(place=-3,
			num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
				       [[0, 3.962], //0.156"
					[1, 3.962], //0.156"
					[2, 4.775], //0.188"
					[3, 4.775], //0.188"
					[4, 6.350], //0.250"
					[5, 7.925], //0.312"
					[6, 7.925], //0.312"
					[8, 8.738], //0.344"
					[10, 9.525], //0.375"
					[12, 11.125]]) //0.438"
	      )
	    )
	  )
	)
      )
    )
  )
);

function unf_sqr_height(in) = is_list(in) ? in[3] : (
  "m" == in[0] || "M" == in[0] ? (
    unf_round(place=-3,
	      num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
			     [[5, 4],
			      [6, 5],
			      [8, 6.5],
			      [10, 8],
			      [12, 10],
			      [16, 13]])
    )
  ) : (
    "\"" == in[len(in)-1] ? (
      unf_round(place=-3,
		num=unf_lookup(25.4*unf_stToNum(unf_sub(in, 0, len(in)-1)),
			       [[6.35, 4.902], // 1/4", 0.193"
				[7.938, 5.625], // 5/16", 0.225"
				[9.525, 6.528]]) // 3/8", 0.257"
      )
    ) : (
      "#0000" == in ? unf_sqr_height(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	"#000" == in ? unf_sqr_height(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	  "#00" == in ? unf_sqr_height(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	    "#" != in[0] ? unf_nut_height("M3") : (
	      unf_round(place=-3,
			num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
				       [[0, 1.27], // 0.050"
					[1, 1.27], // 0.050"
					[2, 1.676], // 0.066"
					[3, 1.676], // 0.066"
					[4, 2.489], // 0.098"
					[5, 2.896], // 0.114"
					[6, 2.896], // 0.114"
					[8, 3.302], // 0.130"
					[10, 3.302], // 0.130"
					[12, 4.089]]) // 0.161"
	      )
	    )
	  )
	)
      )
    )
  )
);

module unf_sqr(size = "m3", ext = -1){
  let (ext = (0 <= ext) ? ext : $over,
       size = is_list(size) ? size : unf_nut_v(size)){
    echo (str("Sqr: ", size));
    length = unf_sqr_length(size);
    height = unf_nut_height(size);
    translate([-length/2, -length/2, 0]){
      if (0 < ext){
	translate([0, 0, -ext]){
	  color("grey", 0.25){
	    cube([length, length, ext]);
	  }
	}
      }
      cube([length, length, height]);
    }
  }
}


/************************ Washer unf_wsh_ *************************/

//[name, washer_diameter, height]

function unf_wsh_v(size) = is_list(size) ? size : [
  unf_fnr_name(size),
  unf_fnr_shaft_diameter(size),
  unf_wsh_diameter(size),
  unf_wsh_height(size)
];

function unf_wsh_diameter(in) = is_list(in) ? in[2] : (
  "m" == in[0] || "M" == in[0] ? (
    unf_round(place=-3,
	      unf_lookup(unf_stToNum(unf_sub(in, 1)),
			 [[0, 0],
			  [1, 3.2],
			  [1.2, 3.8],
			  [1.4, 3.8],
			  [1.6, 4],
			  [2, 5],
			  [2.5, 6],
			  [3, 7],
			  [3.5, 8],
			  [4, 9], 
			  [5, 10],
			  [6, 12],
			  [7, 14],
			  [8, 16],
			  [10, 20],
			  [11, 24],
			  [12, 24],
			  [14, 28],
			  [16, 30],
			  [18, 34],
			  [20, 37],
			  [22, 39],
			  [24, 44],
			  [27, 50],
			  [30, 56],
			  [33, 60],
			  [36, 66],
			  [39, 72],
			  [42, 78],
			  [45, 85],
			  [48, 92],
			  [52, 98],
			  [56, 105],
			  [60, 110],
			  [64, 115]])
    )
  ) : (
    "\"" == in[len(in)-1] ? (
      unf_round(place=-3,
		num=unf_lookup(25.4*unf_stToNum(unf_sub(in, 0, len(in)-1)),
			       [[0, 0],
				[6.35, 15.875], // 1/4", 5/8"
				[7.938, 17.463], // 5/16", 11/16"
				[9.525, 20.638], // 3/8", 13/16"
				[11.113, 23.813], // 7/16", 15/16"
				[12.700, 26.988], // 1/2", 1 1/16"
				[14.288, 29.369], // 9/16", 1 5/32"
				[15.875, 33.338], // 5/8",  1 5/16"
				[19.050, 37.306], // 3/4", 1 15/32"
				[22.225, 44.450], // 7/8", 1 3/4"
				[25.400, 50.80]]) // 1", 2"
      )
    ) : (
      "#0000" == in ? unf_wsh_diameter(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	"#000" == in ? unf_wsh_diameter(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	  "#00" == in ? unf_wsh_diameter(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	    "#" != in[0] ? unf_wsh_diameter("M3") : (
	      unf_round(place=-3,
			num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
				       [[0, unf_wsh_diameter(str("M", unf_fnr_shaft_diameter("#0")))],
					[2, 6.35], // 1/4"
					[4, 7.738], // 5/16"
					[6, 9.525], // 3/8"
					[8, 11.113], // 7/16"
					[10, 12.7], // 1/2"
					[12, 14.288]]) // 9/16"
	      )
	    )
	  )
	)
      )
    )
  )
);

function unf_wsh_height(in) = is_list(in) ? in[3] : (
  "m" == in[0] || "M" == in[0] ? (
    unf_round(place=-3,
	      num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
			     [[0, 0],
			      [1, 0.3],
			      [1.2, 0.3],
			      [1.4, 0.3],
			      [1.6, 0.3],
			      [2, 0.3],
			      [2.5, 0.5],
			      [3, 0.5],
			      [3.5, 0.5],
			      [4, 0.8],
			      [5, 1],
			      [6, 1.6],
			      [7, 1.6],
			      [8, 1.6],
			      [10, 2],
			      [11, 2.5],
			      [12, 2.5],
			      [14, 2.5],
			      [16, 3],
			      [18, 3],
			      [20, 3],
			      [22, 3],
			      [24, 4],
			      [27, 4],
			      [30, 4],
			      [33, 5],
			      [36, 5],
			      [39, 6],
			      [42, 7],
			      [45, 7],
			      [48, 8],
			      [52, 8],
			      [56, 9],
			      [60, 9],
			      [64, 9]])
    )
  ) : (
    "\"" == in[len(in)-1] ? (
      unf_round(place=-3,
		num=unf_lookup(25.4*unf_stToNum(unf_sub(in, 0, len(in)-1)),
			       [[0, 0],
				[6.35, 1.651], // 1/4", 0.065"
				[7.938, 1.651], // 5/16", 0.065"
				[9.525, 1.651], // 3/8", 0.065"
				[11.113, 1.651], // 7/16", 0.065"
				[12.700, 2.413], // 1/2", 0.095"
				[14.288 , 2.413], // 9/16", 0.095"
				[15.875, 2.413], // 5/8", 0.095"
				[19.050, 3.404], // 3/4", 0.134"
				[22.225, 3.404], // 7/8", 0.134"
				[25.400, 3.404]]) // 1", 0.134"
      )
    ) : (
      "#0000" == in ? 0.229 : ( // 0.009"
	"#000" == in ? 0.356 : ( // 0.014"
	  "#00" == in ? 0.508 : ( // 0.020"
	    "#" != in[0] ? unf_csk_head_height("M3") : (
	      unf_round(place=-3,
			num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
				       [[0, 0.660], // 0.026"
					[1, 0.787], // 0.031"
					[2, 0.94], // 0.037"
					[3, 1.092], // 0.043"
					[4, 1.245], // 0.049"
					[6, 1.524], // 0.060"
					[8, 1.83], // 0.072"
					[10, 2.108]]) // 0.083"
	      )
	    )
	  )
	)
      )
    )
  )
);

module unf_wsh(size = "m3", ext = -1){
  let (ext = (0 <= ext) ? ext : $over,
       size = is_list(size) ? size : unf_wsh_v(size)){
    echo (str("Wsh: ", size));
    diameter = unf_wsh_diameter(size);
    height = unf_wsh_height(size);
    if (0 < ext){
      translate([0, 0, -ext]){
	color("grey", 0.25){
	  cylinder(h=ext, d=diameter);
	}
      }
    }
    cylinder(h=height, d=diameter);
  }
}


/************************ Preview *************************/

module collection(size="m3", spacing=2){
  let (csk = unf_csk_v(size),
       cap = unf_cap_v(size),
       hex = unf_hex_v(size),
       hst=unf_hst_v(size),
       nut = unf_nut_v(size),
       wsh = unf_wsh_v(size),
       sqr = unf_sqr_v(size)
  ){
    echo(str("csk: ", csk));
    echo(str("cap: ", cap));
    echo(str("hex: ", hex));
    echo(str("hst: ", hst));
    echo(str("nut: ", nut));
    echo(str("wsh: ", wsh));
    echo(str("sqr: ", sqr));
    unf_csk(screw = csk);
    translate([(unf_csk_head_diameter(csk) + unf_cap_head_diameter(cap))/2 + spacing, 0, 0]){
      unf_cap(screw = cap);
      translate([(unf_cap_head_diameter(cap) + unf_hex_head_diameter(hex))/2 + spacing, 0, 0]){
	unf_hex(hex);
	translate([(unf_hex_head_diameter(hex) + unf_hst_width(hst))/2 + spacing, 0, 0]){
	  unf_hst(hst);
	  translate([(unf_hst_width(hst) + unf_nut_diameter(nut))/2 + spacing, 0, 0]){
	    unf_nut(nut);
	    translate([(unf_nut_diameter(nut) + unf_wsh_diameter(wsh))/2 + spacing, 0, 0]){
	      unf_wsh(wsh);
	      translate([(unf_wsh_diameter(wsh) + unf_sqr_length(sqr))/2 + spacing, 0, 0]){
		unf_sqr(sqr);
	      }
	    }
	  }
	}
      }
    }
  }
}

module distortion_test_block(
  diameter = 3,
  depth = 10,
  steps = 5,
  min_spacing = 3,
  min_dist_x = 25,
  max_dist_x = 100,
  min_dist_y = 5,
  max_dist_y = 20,
  include_control = true
){
  x_inc = diameter + min_spacing;
  y_inc = x_inc + ((diameter * max_dist_x) / 200);
   
  width = (steps * x_inc) + min_spacing;
  height = (steps * y_inc) + min_spacing;
   
  difference(){
    cube([width, depth, height]);
    for (ix = [0:1:steps-1], iy = [0:1:steps-1]){
      dist_x = min_dist_x + (ix * (max_dist_x-min_dist_x) / steps);
      dist_y = min_dist_y + (iy * (max_dist_y-min_dist_y) / steps);
      translate([min_spacing + (diameter/2) + (ix * x_inc), -1, min_spacing + (diameter/2) + (iy * y_inc)]){
	rotate([270, 180, 0]){
	  unf_shaft(length = depth+2, diameter = diameter, $unf_hdist_x=dist_x, $unf_hdist_y=dist_y, distorted=true);
	}
      }
    }
  }
   
  if (include_control){
    side = diameter + (2 * min_spacing);
    translate([-side, 0, 0]){
      difference(){
	cube([side, depth, side]);
	translate([side/2, -1, side/2]){
	  rotate([270, 0, 0]){
	    cylinder(d=diameter, h=depth + 2);
	  }
	}     
      }
    }
  }
}

module unf_hst_test_block(size="M3"){
  height = unf_hst_length(size, "large") + 0.2*unf_fnr_shaft_diameter(size)+2;
  spacing = unf_hst_width(size) + 4;
  length = 4 + (3*spacing) + unf_hst_width(size);
  width = unf_hst_width(size) + 5;

  translate([0, width/2, height]){
    rotate([0, 180, 180]){
      difference(){

	translate([0, -width/2, 0]){
	  cube([length, width, height]);
	}
	translate([4, 0, 0]){
	  translate([-3, 01.5, -1]){
	    linear_extrude(2){
	      rotate([180, 0]){
		text(size, size=3);
	      }
	    }
	  }
	  translate([spacing, 0, 0]){
	    unf_hst(size, length="small");
	    translate([spacing, 0, 0]){
	      unf_hst(size, length="medium");
	      translate([spacing, 0, 0]){
		unf_hst(size, length="large");
	      }
	    }
	  }
	}
      }
    }
  }
}

module unf_nut_test_block(size="M3"){
  let (size=unf_nut_v(size)){
    height = 2 * max(unf_nut_height(size), $wall);
    spacing = unf_nut_diameter(size) + $wall;
    length = 4 + (2*spacing) + unf_nut_diameter(size);
    width = unf_nut_diameter(size) + (2*$wall);

    translate([0, width/2, height]){
      rotate([0, 180, 180]){
	difference(){

	  translate([0, -width/2, 0]){
	    cube([length, width, height]);
	  }
	  translate([4, 0, 0]){
	    translate([-3, 01.5, -1]){
	      linear_extrude(2){
		rotate([180, 0]){
		  text(unf_fnr_name(size), size=3);
		}
	      }
	    }
	    translate([spacing, 0, 0]){
	      unf_nut(size);
	      unf_shaft(unf_fnr_shaft_diameter(size), height + (2*$over));
	      translate([spacing, 0, 0]){
		unf_nut(size);
		unf_shaft(unf_fnr_shaft_diameter(size), height + (2*$over));
	      }
	    }
	  }
	}
      }
    }
  }
}

module unf_wsh_test_block(size="M3"){
  let (size=unf_wsh_v(size)){
    height = 2 * max(unf_wsh_height(size), $wall);
    spacing = unf_wsh_diameter(size) + $wall;
    length = 4 + (2*spacing) + unf_wsh_diameter(size);
    width = unf_wsh_diameter(size) + (2*$wall);

    translate([0, width/2, height]){
      rotate([0, 180, 180]){
	difference(){

	  translate([0, -width/2, 0]){
	    cube([length, width, height]);
	  }
	  translate([4, 0, 0]){
	    translate([-3, 01.5, -1]){
	      linear_extrude(2){
		rotate([180, 0]){
		  text(unf_fnr_name(size), size=3);
		}
	      }
	    }
	    translate([spacing, 0, 0]){
	      unf_wsh(size);
	      unf_shaft(unf_fnr_shaft_diameter(size), height + (2*$over));
	      translate([spacing, 0, 0]){
		unf_wsh(size);
		unf_shaft(unf_fnr_shaft_diameter(size), height + (2*$over));
	      }
	    }
	  }
	}
      }
    }
  }
}

module unf_sqr_test_block(size="M3"){
  let (size=unf_sqr_v(size)){
    height = 2 * max(unf_sqr_height(size), $wall);
    spacing = unf_sqr_length(size) + (2*$wall);
    length = 4 + (2*spacing) + unf_sqr_length(size);
    width = unf_sqr_length(size) + (2*$wall);

    translate([0, width/2, height]){
      rotate([0, 180, 180]){
	difference(){

	  translate([0, -width/2, 0]){
	    cube([length, width, height]);
	  }
	  translate([4, 0, 0]){
	    translate([-3, 01.5, -1]){
	      linear_extrude(2){
		rotate([180, 0]){
		  text(unf_fnr_name(size), size=3);
		}
	      }
	    }
	    translate([spacing, 0, 0]){
	      unf_sqr(size);
	      unf_shaft(unf_fnr_shaft_diameter(size), height + (2*$over));
	      translate([spacing, 0, 0]){
		unf_sqr(size);
		unf_shaft(unf_fnr_shaft_diameter(size), height + (2*$over));
	      }
	    }
	  }
	}
      }
    }
  }
}

module unf_cap_test_block(size="M3"){
  let (size=unf_cap_v(size)){
    height = unf_cap_head_height(size) + 5;
    spacing = unf_cap_head_diameter(size) + $wall;
    length = 4 + (2*spacing) + unf_cap_head_diameter(size);
    width = unf_cap_head_diameter(size) + (2*$wall);

    translate([0, width/2, height]){
      rotate([0, 180, 180]){
	difference(){

	  translate([0, -width/2, 0]){
	    cube([length, width, height]);
	  }
	  translate([4, 0, 0]){
	    translate([-3, 01.5, -1]){
	      linear_extrude(2){
		rotate([180, 0]){
		  text(unf_fnr_name(size), size=3);
		}
	      }
	    }
	    translate([spacing, 0, 0]){
	      unf_cap(size);
	      unf_shaft(unf_fnr_shaft_diameter(size), height + (2*$over));
	      translate([spacing, 0, 0]){
		unf_cap(size);
		unf_shaft(unf_fnr_shaft_diameter(size), height + (2*$over));
	      }
	    }
	  }
	}
      }
    }
  }
}

module unf_csk_test_block(size="M3"){
  let (size=unf_csk_v(size)){
    height = unf_csk_head_height(size) + 5;
    spacing = unf_csk_head_diameter(size) + $wall;
    length = 4 + (2*spacing) + unf_csk_head_diameter(size);
    width = unf_csk_head_diameter(size) + (2*$wall);

    translate([0, width/2, height]){
      rotate([0, 180, 180]){
	difference(){

	  translate([0, -width/2, 0]){
	    cube([length, width, height]);
	  }
	  translate([4, 0, 0]){
	    translate([-3, 01.5, -1]){
	      linear_extrude(2){
		rotate([180, 0]){
		  text(unf_fnr_name(size), size=3);
		}
	      }
	    }
	    translate([spacing, 0, 0]){
	      unf_csk(size);
	      unf_shaft(unf_fnr_shaft_diameter(size), height + (2*$over));
	      translate([spacing, 0, 0]){
		unf_csk(size);
		unf_shaft(unf_fnr_shaft_diameter(size), height + (2*$over));
	      }
	    }
	  }
	}
      }
    }
  }
}

module unf_hex_test_block(size="M3"){
  let (size=unf_hex_v(size)){
    height = unf_hex_head_height(size) + 5;
    spacing = unf_hex_head_diameter(size) + $wall;
    length = 4 + (2*spacing) + unf_hex_head_diameter(size);
    width = unf_hex_head_diameter(size) + (2*$wall);

    translate([0, width/2, height]){
      rotate([0, 180, 180]){
	difference(){

	  translate([0, -width/2, 0]){
	    cube([length, width, height]);
	  }
	  translate([4, 0, 0]){
	    translate([-3, 01.5, -1]){
	      linear_extrude(2){
		rotate([180, 0]){
		  text(unf_fnr_name(size), size=3);
		}
	      }
	    }
	    translate([spacing, 0, 0]){
	      unf_hex(size);
	      unf_shaft(unf_fnr_shaft_diameter(size), height + (2*$over));
	      translate([spacing, 0, 0]){
		unf_hex(size);
		unf_shaft(unf_fnr_shaft_diameter(size), height + (2*$over));
	      }
	    }
	  }
	}
      }
    }
  }
}

if (parm_part == "Collection") {
  collection(size=parm_size);
 }

if (parm_part == "HexHeadBolt_Test_Block"){
  unf_hex_test_block(size=parm_size);
 }

if (parm_part == "CapHeadBolt_Test_Block") {
  unf_cap_test_block(size=parm_size);
 }

if (parm_part == "CountersunkBolt_Test_Block") {
  unf_csk_test_block(size=parm_size);
 }

if (parm_part == "Heatset_Test_Block") {
  unf_hst_test_block(size=parm_size);
 }

if (parm_part == "HexNut_Test_Block") {
  unf_nut_test_block(size=parm_size);
 }

if (parm_part == "SquareNut_Test_Block") {
  unf_sqr_test_block(size=parm_size);
 }

if (parm_part == "Washer_Test_Block") {
  unf_wsh_test_block(size=parm_size);
 }

if (parm_part == "Bolt_Distortion_Test"){
  distortion_test_block(
    diameter = unf_fnr_shaft_diameter(parm_size),
    depth = parm_dist_depth,
    steps = parm_dist_steps,
    min_spacing = parm_dist_min_spacing,
    min_dist_x = parm_dist_min_dist_x,
    max_dist_x = parm_dist_max_dist_x,
    min_dist_y = parm_dist_min_dist_y,
    max_dist_y = parm_dist_max_dist_y,
    include_control = parm_dist_include_control
  );
 }
