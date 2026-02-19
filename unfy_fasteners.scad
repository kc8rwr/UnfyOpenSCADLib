// LibFile: unfy_fasteners.scad
//   UnfyOpenSCADLib Copyright Leif Burrow 2026
//   kc8rwr@unfy.us
//   unforgettability.net
//   .
//   This file is part of UnfyOpenSCADLib.
//   .
//   Unfy_fasteners.scad contains modules for creating bolts, screws, nuts, washers, heatsink inserts and more. These models at the time do not include threads. Their purpose is for subtracting from a model to create holes and countersinks. Realistic models with threads could be added later if there is a use for them.
//   .
//   Fasteners may be generated to size by passing the size as a string. Metric sizes may be passed as "M&lt;number&gt;" such as "M4" or "M3". It is case insensitie so "m4" or "m3" will work as well. Numbered SAE sizes are represented as "#&lt;number&gt;", such as "#6" or "#8". Inch sizes are represented as a decimal number or as a fraction. "1/4" or "0.25" would both represent 1/4".
//   .
//   Tables are included for looking up dimensions based on these sizes. Shaft diameter of course is the size itself in it's respective units. Tables also include things like typical diameters and thicknesses of heads for various bolt types, nut, washer and heatset insert dimensions, etc... Most sizes commonly used in 3d-printed projects as well as larger fasteners commonly available in hardware stores are included. If sizes that are outside of the built in tables are requested then the code will attempt to interpolate the missing value.
//   .
//   Functions are included to look up the various dimensions of fasteners by size and type. This way one using this library may allow the end user to choose fastener sizes from the customizer menu. Then the script may adapt, re-sizing or re-positioning things based on the outer dimensions of the requested fastener sizes. Sizes may be looked up as scalars describing just one dimension. Or they may be looked up as a vector which may then be passed to the functions that look up the individual dimensions or the module which renders the part. This way the lookup and/or interpolation need only happen once.
//   .
//   The goal here is to allow the user to create customizable designs where the end user may choose parts that they already have on hand or parts that are easily available. Designers are encouraged to give the end-user plenty of choices. Perfectly valid arguments regarding the merits of measurement systems aside, the best fastener size is the one you already have on hand. The next best is the one your local hardware store sells in bulk rather than the specialty isle.
//   .
//   Provisions are included for distorting horizontal bolt holes, to remove some extra material from the top side. This way when printing via fused filament fabrication plastic which sags down will just cancel this distortion out rather than requiring drilling so the bolt can fit cleanly. The distortion is defined by two special variables, $unf-hdist_y and $unf_hdist_x. These define the extra removed material by height and width respectively, both as a percentage of the shaft diameter.
//   .
//   So far this feature has been developed only for bolt holes and not the other parts. The original intention was to distort every part depending on the angle at which it is rendered. Unfortunately there is no good way to know what angle a part is being rendered in OpenSCAD so it relies on the user telling it. Thus this feature has not been furtner developed.

use <unfy_lists.scad>
use <unfy_math.scad>

parm_part = "Collection"; // ["Collection", "HexHeadBolt_Test_Block", "CapHeadBolt_Test_Block", "CountersunkBolt_Test_Block", "HexNut_Test_Block", "SquareNut_Test_Block", "Washer_Test_Block", "Heatset_Test_Block", "Bolt_Distortion_Test"]

parm_size = "m3"; // ["m2", "m2.5", "m3", "m4", "m8", "#00", "#000", "#0000", "#4", "#6", "#8", "#10", "#12", "1/4\"", "5/16\"", "3/8\""]

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

// Function: unf_fnr_type
// Usage:
//   unf_fnr_type(fastener_vector)
// Description:
//   Takes a vector describing a fastener and returns a string representing the fastener type.
// Arguments:
//   in = vector describing an unfy_fastener
function unf_fnr_type(in) = is_list(in) ? in[0] : unf_stToUpper(in);
					
// Function: unf_fnr_size
// Usage:
//   unf_fnr_size(fastener_size_or_vector)
// Description:
//   Takes a vector describing a fastener or a string representing the fastener size and returns a string representing the fastener size.
//   .
//   Of course this isnt't doing much when it is passed the string. This is done so that a variable may hold the size string which the user requested before it is expanded into the vector and still work in the same code.
// Arguments:
//   in = vector describing an unfy_fastener or a string representing the size of one.
function unf_fnr_size(in) = is_list(in) ? in[1] : unf_stToUpper(in);

// Function: unf_fnr_diameter
// Usage:
//   unf_fnr_diameter(fastener_size_or_vector)
// Description:
//   Takes a vector describing a fastener or a string representing the fastener size and returns the diameter of the widest part in millimeters. Useful for calculating positioning or sizes of parts that will contain the fastener when the end-user is allowed to pick from a variety of sizes of fasteners.
// Arguments:
//   in = vector describing an unfy_fastener or a string representing the size of one.
function unf_fnr_diameter(in) = is_list(in) ? in[2] : (is_num(in) ? in : 5);

// Function: unf_fnr_shaft_diameter
// Usage:
//   unf_fnr_shaft_diameter(fastener_size_or_vector)
// Description:
//   Takes a vector describing a fastener or a string representing the fastener size and returns the shaft diameter in millimeters.
// Arguments:
//   in = vector describing an unfy_fastener or a string representing the size of one.
function unf_fnr_shaft_diameter(in) = is_list(in) ? in[3] : (
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

// Module: unf_shaft
// Usage:
//   unf_shaft(diameter, length, distorted, $unf_hdist_x, $unf_hdist_y)
// Description:
//   Render a fastener shaft hole, optionally with distortions to account for overhang sagging when 3d-printing.
// Arguments:
//   diameter = shaft diameter in mm
//   length = length in mm
//   distorted = true/false should this be distorted
//   ---
//   $unf_hdist_x = width of distortion as a percentage of the diameter (0-100)
//   $unf_hdist_y = height of distortion as a percentage of the diameter (0-100)
// Figure(2D;NoAxes): various values of unf_hdist_x and unf_hdist_y. (0, 0) or distorted=false would be a perfect circle.
//   $over = 0.01;
//   $fn = 36;
//   use <unfy_fasteners.scad>
//   for (i = [0:11]){
//      c = i % 4;
//      r = floor(i / 4);
//      tx = c * 35;
//      ty = r * -55;
//      dx = 90 * (c+1) / 4;
//      dy = 33 * (r+1) / 3;
//      translate([tx, ty]){
//         color("Yellow"){
//            projection(){
//               unf_shaft(30, 1, true, $unf_hdist_x=dx, $unf_hdist_y=dy);
//            }
//         }
//         translate([-15, -30]){
//            resize([30, 10]){
//               color("Blue") text(str("(", dx, ", ", dy, ")"));
//            }
//         }
//      }
//   }
module unf_shaft(diameter=3, length=10, distorted=false){
	if (distorted){
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

// Section: Cap Bolts - unf_cap_*
//   The vector representing a cap bolt will consist of, in order:
//   * name
//   * bolt_diameter
//   * head_diameter
//   * head_height
//   * default_length


// Function: unf_cap_v
// Usage:
//   unf_cap_v(size_or_vector)
// Description:
//   Retrieve a vector representing the dimensions of a cap-head bolt given the size. Will return the passed parameter if passed a vector. Thus sizes and dimension vectors may be treated interchangably.
//   .
// Arguments:
//   size = size as a string or the vector itself
function unf_cap_v(size) = is_list(size) ? size : [
  "CAP", //0
  unf_fnr_size(size), //1
  unf_cap_head_diameter(size), //2
  unf_fnr_shaft_diameter(size), //3
  unf_cap_head_height(size), //4
  unf_cap_default_length(size) //5
];

// Function: unf_cap_head_diameter
// Usage:
//   unf_cap_head_diameter(size_or_vector)
// Description:
//   Retrieve the diameter in mm of the head of a cap-head bolt given the size.
// Arguments:
//   size = size as a string or the unf_cap_v() vector itself
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

// Function: unf_cap_head_height
// Usage:
//   unf_cap_head_height(size_or_vector)
// Description:
//   Retrieve the height or thickness in mm of the head of a cap-head bolt given the size.
// Arguments:
//   size = size as a string or the unf_cap_v() vector itself
function unf_cap_head_height(in) = is_list(in) ? in[4] : unf_fnr_shaft_diameter(in);

// Function: unf_cap_default_length
// Usage:
//   unf_cap_default_length(size_or_vector)
// Description:
//   Retrieve a default length for a cap head bolt given it's size. Probably not very useful in a real design, good for picking a length to demonstrate an example of a unf_cap bolt.
// Arguments:
//   size = size as a string or the unf_cap_v() vector itself
function unf_cap_default_length(in) = is_list(in) ? in[5] : unf_fnr_shaft_diameter(in) * 15 / 3;

// Module: unf_cap
// Usage:
//   unf_cap(size, length, head_ext, distorted, $unf_hdist_x, $unf_hdist_y)
// Description:
//   Render a negative for a shaft and/or head-recess for a cap-head bolt. Note, the cap head is rendered as a simple cylinder with the diameter of the widest part of the actual head. This is because it is meant for being a negative, to recess a bolt and not for printing an actual bolt.
// Arguments:
//   size = string representing the size or the unf_cap_v() vector.
//   length = length in mm
//   head_ext = length in mm to recess the head beyond just it's thickness
//   distorted = true/false, should the bolt hole be distorted
//   ---
//   $unf_hdist_x = width of distortion as a percentage of the diameter (0-100)
//   $unf_hdist_y = height of distortion as a percentage of the diameter (0-100)
// Figure(Spin;VPD=50; VPT=[0, 0, 5];  NoAxes): note - the head_ext area is semi-transparent.
//   $fn = 36;
//   $over = 0.1;
//   $wall=2;
//   $unf_hdist_x = 80;
//   $unf_hdist_y = 10;
//   use <unfy_fasteners.scad>;
//   unf_cap(size="m3", length=10, head_ext=2, distorted=true);
module unf_cap(size = "m3", length = -1, head_ext = -1, distorted = false){
  let (head_ext = (0 <= head_ext) ? head_ext : $over,
       size = is_list(size) ? size : unf_cap_v(size),
       length = 0 < length ? length : unf_cap_default_length(size)){
    head_d = unf_cap_head_diameter(size);
    head_height = unf_cap_head_height(size);
    shaft_d = unf_fnr_shaft_diameter(size);
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


// Section: Countersunk Bolts unf_csk_*
//   The vector representing a countersunk bolt will consist of, in order:
//   * name
//   * bolt_diameter
//   * head_diameter
//   * head_height
//   * default_length

// Function: unf_csk_v
// Usage:
//   unf_csk_v(size_or_vector)
// Description:
//   Retrieve a vector representing the dimensions of a countersunk bolt given the size. Will return the passed parameter if passed a vector. Thus sizes and dimension vectors may be treated interchangably.
//   .
// Arguments:
//   size = size as a string or the vector itself
function unf_csk_v(size) = is_list(size) ? size : [
  "CSK", //0
  unf_fnr_size(size), //1
  unf_csk_head_diameter(size), //2
  unf_fnr_shaft_diameter(size), //3
  unf_csk_head_height(size), //4
  unf_csk_default_length(size) //5
];

// Function: unf_csk_head_diameter
// Usage:
//   unf_csk_head_diameter(size_or_vector)
// Description:
//   Retrieve the diameter in mm of the head of a countersunk bolt given the size.
// Arguments:
//   size = size as a string or the unf_csk_v() vector itself
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
					[6, 6.6], // verified 
					[10, 8.6], //verified
					[12, 10.47]]) //verified
	      )
	    )
	  )
	)
      )
    )
  )
);

// Function: unf_csk_head_height
// Usage:
//   unf_csk_head_height(size_or_vector)
// Description:
//   Retrieve the height or thickness in mm of the head of a countersunk bolt given the size.
// Arguments:
//   size = size as a string or the unf_cap_v() vector itself
function unf_csk_head_height(in) = is_list(in) ? in[4] : (
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
															  [6, 2.5], 
															  [10, 3.4],
															  [12, 4.2]]) 
							)
						)
					)
				)
			)
		)
	)
);

// Function: unf_csk_default_length
// Usage:
//   unf_csk_default_length(size_or_vector)
// Description:
//   Retrieve a default length for a countersunk bolt given it's size. Probably not very useful in a real design, good for picking a length to demonstrate an example of a unf_csk bolt.
// Arguments:
//   size = size as a string or the unf_cap_v() vector itself
function unf_csk_default_length(in) = is_list(in) ? in[5] : unf_fnr_shaft_diameter(in) * 15 / 3;

// Module: unf_csk
// Usage:
//   unf_csk(size, length, head_ext, distorted, $unf_hdist_x, $unf_hdist_y)
// Description:
//   Render a negative for a shaft and/or head-recess for a cap-head bolt. Note, the cap head is rendered as a simple cylinder with the diameter of the widest part of the actual head. This is because it is meant for being a negative, to recess a bolt and not for printing an actual bolt.
// Arguments:
//   size = string representing the size or the unf_cap_v() vector.
//   length = length in mm
//   head_ext = length in mm to recess the head beyond just it's thickness
//   distorted = true/false, should the bolt hole be distorted
//   ---
//   $unf_hdist_x = width of distortion as a percentage of the diameter (0-100)
//   $unf_hdist_y = height of distortion as a percentage of the diameter (0-100)
// Figure(Spin;VPD=50; VPT=[0, 0, 5];  NoAxes): note - the head_ext area is semi-transparent.
//   $fn = 36;
//   $over = 0.1;
//   $wall=2;
//   $unf_hdist_x = 80;
//   $unf_hdist_y = 10;
//   use <unfy_fasteners.scad>;
//   unf_csk(size="m3", length=10, head_ext=2, distorted=true);
module unf_csk(size = "m3", length = -1, head_ext = -1, distorted = false){
  let (head_ext = (0 <= head_ext) ? head_ext : $over,
       size = is_list(size) ? size : unf_csk_v(size),
       length = 0 < length ? length : unf_csk_default_length(size)){
    head_d = unf_csk_head_diameter(size);
    head_height = unf_csk_head_height(size);
    shaft_d = unf_fnr_shaft_diameter(size);
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

// Section: Hex Head Bolts - unf_hex_*
//   The vector representing a hex head bolt will consist of, in order:
//   * name
//   * bolt_diameter
//   * head_diameter
//   * head_height
//   * default_length

// Function: unf_hex_v
// Usage:
//   unf_hex_v(size_or_vector)
// Description:
//   Retrieve a vector representing the dimensions of a hex-head bolt given the size. Will return the passed parameter if passed a vector. Thus sizes and dimension vectors may be treated interchangably.
//   .
// Arguments:
//   size = size as a string or the vector itself
function unf_hex_v(size) = is_list(size) ? size : [
  "HEX", //0
  unf_fnr_size(size), //1
  unf_hex_head_diameter(size), //2
  unf_fnr_shaft_diameter(size), //3
  unf_hex_head_height(size), //4
  unf_hex_default_length(size) //5
];

// Function: unf_hex_head_diameter
// Usage:
//   unf_hex_head_diameter(size_or_vector)
// Description:
//   Retrieve the diameter in mm of the head of a hex-head bolt given the size.
// Arguments:
//   size = size as a string or the unf_hex_v() vector itself
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
      "#0000" == in ? unf_hex_head_diameter(str("M", unf_fnr_shaft_diameter(in))) : ( // no real data
	"#000" == in ? unf_hex_head_diameter(str("M", unf_fnr_shaft_diameter(in))) : ( // no real data
	  "#00" == in ? unf_hex_head_diameter(str("M", unf_fnr_shaft_diameter(in))) : ( // no real data
	    "#" != in[0] ? unf_hex_head_diameter("M3") : (
	      unf_hex_head_diameter(str("M", unf_fnr_shaft_diameter(in))) // no real data
	    )
	  )
	)
      )
    )
  )
);

// Function: unf_hex_head_height
// Usage:
//   unf_hex_head_height(size_or_vector)
// Description:
//   Retrieve the height or thickness in mm of the head of a hex-head bolt given the size.
// Arguments:
//   size = size as a string or the unf_hex_v() vector itself
function unf_hex_head_height(in) = is_list(in) ? in[4] : (
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
      "#0000" == in ? unf_hex_head_height(str("M", unf_fnr_shaft_diameter(in))) : ( // no real data
	"#000" == in ? unf_hex_head_height(str("M", unf_fnr_shaft_diameter(in))) : ( // no real data
	  "#00" == in ? unf_hex_head_height(str("M", unf_fnr_shaft_diameter(in))) : ( // no real data
	    "#" != in[0] ? unf_hex_head_height("M3") : (
	      unf_hex_head_height(str("M", unf_fnr_shaft_diameter(in))) // no real data
	    )
	  )
	)
      )
    )
  )
);

// Function: unf_hex_default_length
// Usage:
//   unf_hex_default_length(size_or_vector)
// Description:
//   Retrieve a default length for a hex head bolt given it's size. Probably not very useful in a real design, good for picking a length to demonstrate an example of a unf_hrx bolt.
// Arguments:
//   size = size as a string or the unf_hex_v() vector itself
function unf_hex_default_length(in) = is_list(in) ? in[5] : unf_fnr_shaft_diameter(in) * 15 / 3;

// Module: unf_hex
// Usage:
//   unf_hex(size, length, head_ext, distorted, $unf_hdist_x, $unf_hdist_y)
// Description:
//   Render a negative for a shaft and/or head-recess for a hex-head bolt.
// Arguments:
//   size = string representing the size or the unf_hex_v() vector.
//   length = length in mm
//   head_ext = length in mm to recess the head beyond just it's thickness
//   distorted = true/false, should the bolt hole be distorted
//   ---
//   $unf_hdist_x = width of distortion as a percentage of the diameter (0-100)
//   $unf_hdist_y = height of distortion as a percentage of the diameter (0-100)
// Figure(Spin;VPD=50; VPT=[0, 0, 5];  NoAxes): note - the head_ext area is semi-transparent.
//   $fn = 36;
//   $over = 0.1;
//   $wall=2;
//   $unf_hdist_x = 80;
//   $unf_hdist_y = 10;
//   use <unfy_fasteners.scad>;
//   unf_hex(size="m3", length=10, head_ext=2, distorted=true);
module unf_hex(size = "m3", length = -1, head_ext = -1, distorted = false){
  let (head_ext = (0 <= head_ext) ? head_ext : $over,
       size = is_list(size) ? size : unf_hex_v(size),
       length = 0 < length ? length : unf_hex_default_length(size)){
    head_d = unf_hex_head_diameter(size);
    head_height = unf_hex_head_height(size);
    shaft_d = unf_fnr_shaft_diameter(size);
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

// Section: Heatset Inserts - unf_hst_*
//   The vector representing a heatset insert will contain, in order:
//   * name
//   * shaft_diameter
//   * insert_diameter
//   * length
//   note - these are pilot hole dimensions, not dimensions of the actual insert

// Function: unf_hst_v
// Usage:
//   unf_hst_v(size_or_vector)
// Description:
//   Retrieve a vector representing the dimensions of a heatset insert given the size. Will return the passed parameter if passed a vector. Thus sizes and dimension vectors may be treated interchangably.
//   .
// Arguments:
//   size = size as a string or the vector itself
function unf_hst_v(size="m3", length="medium", opening_taper_percent=10) = is_list(size) ? size : (
  let (length=unf_stToLower(length)) (
    ["HST", //0
     unf_fnr_size(size), //1
     unf_hst_diameter(size)+(unf_hst_diameter(size)*opening_taper_percent/100), //2
     unf_fnr_shaft_diameter(size), //3
     opening_taper_percent, //4
     unf_hst_diameter(size), //5
     unf_hst_length(size, length)] //6
  )
);
  
// Function: unf_hst_diameter
// Usage:
//   unf_hst_diameter(size_or_vector)
// Description:
//   Retrieve the diameter in mm of the hole for a heatset insert given the size.
// Arguments:
//   size = size as a string or the unf_hst_v() vector itself
function unf_hst_diameter(in="m3") = is_list(in) ? in[5] : (
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

// Function: unf_hst_height
// Usage:
//   unf_hst_height(size_or_vector)
// Description:
//   Retrieve the length in mm of the hole for a heatset insert given the size.
// Arguments:
//   size = size as a string or the unf_hst_v() vector itself
function unf_hst_length(size="m3", length="medium") = is_num(length) ? length : (
  let (length = unf_stToLower(length)) (
    is_list(size) ? size[6] : (
      "m" == size[0] || "M" == size[0] ? (
	unf_round(place=-3,
		  num=unf_lookup(unf_stToNum(unf_sub(size, 1)),
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
	"\"" == size[len(size)-1] ? (
	  unf_hst_length(str("M", 25.4*unf_stToNum(unf_sub(size, 0, len(size)-1))), length) // No Data
	) : (
	  "#0000" == size ? unf_hst_length(str("M", unf_fnr_shaft_diameter(size)), length) : ( // No Data
	    "#000" == size ? unf_hst_length(str("M", unf_fnr_shaft_diameter(size)), length) : ( // No Data
	      "#00" == size ? unf_hst_length(str("M", unf_fnr_shaft_diameter(size)), length) : ( // No Data
		"#" != size[0] ? unf_hst_length("M3") : (
		  unf_round(place=-3,
			    num=unf_lookup(unf_stToNum(unf_sub(size, 1)),
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
  )
);

// Module: unf_hst
// Usage:
//   unf_hst(size, opening_taper_percent, length, head_ext, extra_room, bolt_hole_depth)
// Description:
//   Render a negative for a heatset-insert hole.
// Arguments:
//   size = string representing the size or the unf_cap_v() vector.
//   opening_taper_percent = enlarge the opening with a taper for ease of insertion.
//   length = one of small, medium or large
//   head_ext = length in mm to recess the head beyond just it's thickness
//   extra_room = extra distance at the top of the insert hole for recessing it. Rendered in blue.
//   bolt_hole_depth = distance to extend the bolt hole beyond the bottom of the insert
// Figure(Spin;VPD=50; VPT=[0, 0, 5];  NoAxes): note - the head_ext area is semi-transparent.
//   $fn = 36;
//   $over = 0.1;
//   $wall=2;
//   $unf_hdist_x = 80;
//   $unf_hdist_y = 10;
//   use <unfy_fasteners.scad>;
//   unf_hst(size="m3", opening_taper_percent=10, length="medium", head_ext=2, extra_room=false, bolt_hole_depth=3);
module unf_hst(size="m3", opening_taper_percent=10, length="medium", head_ext=-1, extra_room=true, bolt_hole_depth=0){
  let (
    length = unf_stToLower(length),
    size = is_list(size) ? size : unf_hst_v(size=size, length=length)){
    let (
      bolt_diameter = unf_fnr_shaft_diameter(size),
      opening_diameter = unf_fnr_diameter(size),
      diameter = unf_hst_diameter(size),
      length = unf_hst_length(size=size, length=length),
      head_ext = (0 <= head_ext) ? head_ext : $over
    ) {
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
	    cylinder(d=bolt_diameter, h=bolt_hole_depth);
	  }
	}
      }
    }
  }
}

/************************ Hex Nut unf_nut_ *************************/

//[name, nut_diameter, height]

function unf_nut_v(size) = is_list(size) ? size : [
  "NUT", //0
  unf_fnr_size(size), //1
  unf_nut_diameter(size), //2
  unf_fnr_shaft_diameter(size), //3
  unf_nut_height(size) //4
];

function unf_nut_diameter(in) = is_list(in) ? in[2] : (
  "m" == in[0] || "M" == in[0] ? (
    unf_round(place=-3,
	      unf_lookup(unf_stToNum(unf_sub(in, 1)),
			 [[0, 0],
			  [1.6, 3.7],
			  [2, 4.62],
			  [2.5, 5.77],
			  [3, 6], // confirmed
			  [3.5, 6.93],
			  [4, 7.5], // confirmed
			  [5, 9.24],
			  [6, 11.55],
			  [8, 14.25], // 14 - just slightly too small, 14.5 just barely too big, maybe ok
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
				[6.35, 12], // 1/4" 11.5-too tight
				[7.938, 14.3], // 5/16" - confirmed
				[9.525, 16.17]]) // 3/8" - confirmed
      )
    ) : (
      "#0000" == in ? unf_nut_diameter(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	"#000" == in ? unf_nut_diameter(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	  "#00" == in ? unf_nut_diameter(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	    "#" != in[0] ? unf_nut_diameter("M3") : (
	      unf_round(place=-3,
			num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
				       [[0, 5.613], //
					[6, 8.5], // verified
					[8, 9.525], // verified
					[10, 10.25], // verified 
					[12, 12]]) // verified
	      )
	    )
	  )
	)
      )
    )
  )
);

function unf_nut_height(in) = is_list(in) ? in[4] : (
  "m" == in[0] || "M" == in[0] ? (
    unf_round(place=-3,
	      num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
			     [[0, 0],
			      [1.6, 1.3],
			      [2, 1.6],
			      [2.5, 2],
			      [3, 2.4], // confirmed
			      [3.5, 2.8],
			      [4, 3.2], //confirmed
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
				[6.35, 5.7], // 1/4"
				[7.938, 6.69], // 5/16" - confirmed
				[9.525, 8.16]]) // 3/8" - confirmed
      )
    ) : (
      "#0000" == in ? unf_nut_height(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	"#000" == in ? unf_nut_height(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	  "#00" == in ? unf_nut_height(str("M", unf_fnr_shaft_diameter(in))) : ( // No Data
	    "#" != in[0] ? unf_nut_height("M3") : (
	      unf_round(place=-3,
			num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
				       [[0, 1.27], //
					[6, 2.76], // verified
					[8, 3.23], // verified (stainless)
					[10, 3.5], // verified
					[12, 4.25]]) // verified
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
       size = is_list(size) ? size : unf_nut_v(size),
       diameter = unf_nut_diameter(size),
       height = unf_nut_height(size)){
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
  "SQR", //0
  unf_fnr_size(size), //1
  unf_fnr_shaft_diameter(size), //2
  unf_sqr_length(size), //3
  unf_sqr_height(size) //4
];

function unf_sqr_length(in) = is_list(in) ? in[3] : (
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

function unf_sqr_height(in) = is_list(in) ? in[4] : (
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
  "WSH",
  unf_fnr_size(size),
  unf_wsh_diameter(size),
  unf_fnr_shaft_diameter(size),
  unf_wsh_diameter(size),
  unf_wsh_height(size)
];

function unf_wsh_diameter(in) = is_list(in) ? in[4] : (
  "m" == in[0] || "M" == in[0] ? (
    unf_round(place=-3,
	      unf_lookup(unf_stToNum(unf_sub(in, 1)),
			 [[0, 0],
			  [1, 3.2],
			  [1.2, 3.8],
			  [1.4, 3.8],
			  [1.6, 4],
			  [2, 5],
			  [2.5, 6], // verified
			  [3, 7],
			  [3.5, 8],
			  [4, 9], 
			  [5, 10],
			  [6, 12],
			  [7, 14],
			  [8, 16.8],
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
				[6.35, 18.75], // 1/4" verified
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
					[4, 9.6], // verified
					[6, 9.8], // verified
					[8, 11.36], // verified
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

function unf_wsh_height(in) = is_list(in) ? in[5] : (
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
			      [3, 0.5], // verified
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
				[6.35, 2.1], // 1/4" verified
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
					[4, 1.33], // verified
					[6, 1.33], // verified
					[8, 1.33], // verified
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


/************************ Pillar **************************/

module unf_pillar_pos(fastener="Heatset", bolt="M3", heatset_length="Medium", length=5, slope=45, wall=1){
  let(fastener = unf_stToLower(fastener)){

    if ("hexnut" == fastener){
      let (nut_v = unf_nut_v(bolt),
	   nut_diameter = unf_nut_diameter(nut_v),
	   nut_height = unf_nut_height(nut_v),
	   top_d=(2*wall)+nut_diameter,
	   bottom_d = top_d+(2*length*tan(slope))
      ){
	cylinder(d1=bottom_d, d2=top_d, h=length);
	translate([0, 0, length+$over]){
	  rotate([0, 180, 0]){
	    unf_nut(size=nut_v, ext=$over);
	  }
	}
      }
    }

    else if ("heatset" == fastener){
      let(fastener = unf_hst_v(size=bolt, length=heatset_length),
	  hst_diameter = unf_hst_diameter(fastener),
	  hst_length = unf_hst_length(fastener, length=heatset_length),
	  length = (wall+hst_length)>length ? (wall+hst_length) : length,
	  top_d=(2*wall)+hst_diameter,
	  bottom_d = top_d+(2*length*tan(slope))
      ){
	cylinder(d1=bottom_d, d2=top_d, h=length);
      }
    }
    
  }
}

module unf_pillar_neg(fastener="Heatset", bolt="M3", length=5, heatset_length="Medium", scale=2, wall=1, ext=2){
  let(fastener = unf_stToLower(fastener)){

    if ("hexnut" == fastener){
      let (nut_v = unf_nut_v(bolt),
	   nut_diameter = unf_nut_diameter(nut_v),
	   nut_height = unf_nut_height(nut_v)
      ){
	translate([0, 0, length+$over]){
	  rotate([0, 180, 0]){
	    unf_nut(size=nut_v, ext=$over);
	  }
	}
	translate([0, 0, -ext]){
	  cylinder(d=unf_fnr_shaft_diameter(bolt), h=$over+ext+length);
	}
      }
    }

    else if ("heatset" == fastener){
      let(fastener = unf_hst_v(size=bolt, length=heatset_length),
	  hst_diameter = unf_hst_diameter(fastener),
	  hst_length = unf_hst_length(fastener, length=heatset_length),
	  length = (wall+hst_length)>length ? (wall+hst_length) : length
      ){
	translate([0, 0, length]){
	  rotate([0, 180, 0]){
	    unf_hst(size=fastener, length=heatset_length, bolt_hole_depth=length-hst_length+$over);
	  }
	}
      }      
    }
    
  }
}

module unf_pillar(fastener="Heatset", heatset_length="Medium", bolt="M3", length=5, slope=45, wall=1){
  difference(){
    unf_pillar_pos(fastener=fastener, bolt=bolt, heatset_length=heatset_length, length=length, slope=slope, wall=wall);
    unf_pillar_neg(fastener=fastener, bolt=bolt, heatset_length=heatset_length, length=length);
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
    unf_csk(size = csk);
    translate([(unf_csk_head_diameter(csk) + unf_cap_head_diameter(cap))/2 + spacing, 0, 0]){
      unf_cap(size = cap);
      translate([(unf_cap_head_diameter(cap) + unf_hex_head_diameter(hex))/2 + spacing, 0, 0]){
	unf_hex(hex);
	translate([(unf_hex_head_diameter(hex) + unf_fnr_diameter(hst))/2 + spacing, 0, 0]){
	  unf_hst(hst);
	  translate([(unf_fnr_diameter(hst) + unf_nut_diameter(nut))/2 + spacing, 0, 0]){
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
  spacing = unf_fnr_diameter(size) + 4;
  length = 4 + (3*spacing) + unf_fnr_diameter(size);
  width = unf_fnr_diameter(size) + 5;

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
		  text(unf_fnr_size(size), size=5);
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
		  text(unf_fnr_size(size), size=6);
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
		  text(unf_fnr_size(size), size=3);
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
		  text(unf_fnr_size(size), size=3);
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
		  text(unf_fnr_size(size), size=5);
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
    length = 2*spacing;
    width = unf_hex_head_diameter(size) + (2*$wall);

    difference(){
      linear_extrude(height){
	
	hull(){
	  
	  translate([-length, 0]){
	    square([length, width]);
	  }

	  unf_enbox(margin=$wall){
	    resize([0, width-(2*$wall)], auto=true){
	      text(text=unf_fnr_size(size));
	    }
	  }
        }
      }
      translate([$wall, $wall, height-$wall]){
        linear_extrude($wall + $over){
	  resize([0, width-(2*$wall)], auto=true){
	    text(text=unf_fnr_size(size));
	  }
	}
      }
      for(tv=[[-spacing/2, width/2, height], [-3/2*spacing, width/2, height]]){
        translate(tv){
	  rotate([0, 180, 0]){
	    unf_hex(size, length=height);
	  }
	}
      }
    }
  }
}

module unf_fastener_test_block(type="hex", size="M3"){
  let (size=unf_hex_v(size)){
    height = unf_hex_head_height(size) + 5;
    spacing = unf_hex_head_diameter(size) + $wall;
    length = 2*spacing;
    width = unf_hex_head_diameter(size) + (2*$wall);

    difference(){
      linear_extrude(height){
	
	hull(){
	  
	  translate([-length, 0]){
	    square([length, width]);
	  }

	  unf_enbox(margin=$wall){
	    resize([0, width-(2*$wall)], auto=true){
	      text(text=unf_fnr_size(size));
	    }
	  }
        }
      }
      translate([$wall, $wall, height-$wall]){
        linear_extrude($wall + $over){
	  resize([0, width-(2*$wall)], auto=true){
	    text(text=unf_fnr_size(size));
	  }
	}
      }
      for(tv=[[-spacing/2, width/2, height], [-3/2*spacing, width/2, height]]){
        translate(tv){
	  rotate([0, 180, 0]){
	    unf_hex(size, length=height);
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
