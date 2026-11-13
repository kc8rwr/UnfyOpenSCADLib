// LibFile: unfy_fasteners.scad
//   UnfyOpenSCADLib Copyright Leif Burrow 2026
//   kc8rwr@unfy.us
//   unforgettability.net
//   .
//   This file is part of UnfyOpenSCADLib.
//   .
//   Unfy_fasteners.scad contains modules for creating bolts, self tapping screws, nuts, washers, heatsink inserts and more. These models at the time do not include threads. Their purpose is for subtracting from a model to create holes and countersinks. Realistic models with threads could be added later if there is a use for them.
//   .
//   Fasteners may be generated to size by passing the size as a string. Metric sizes may be passed as "M&lt;number&gt;" such as "M4" or "M3". It is case insensitive so "m4" or "m3" will work as well. Numbered SAE sizes are represented as "#&lt;number&gt;", such as "#6" or "#8". Inch sizes are represented as a decimal number or as a fraction. "1/4" or "0.25" would both represent 1/4". ISO tapping screw sizes may be passed as "ST&lt;number&gt;" such as "ST2.9". These are treated as the metric size of the same diameter by the fasteners that are not self tapping screws.
//   .
//   Tables are included for looking up dimensions based on these sizes. Shaft diameter of course is the size itself in it's respective units. Tables also include things like typical diameters and thicknesses of heads for various bolt types, nut, washer and heatset insert dimensions, etc... Most sizes commonly used in 3d-printed projects as well as larger fasteners commonly available in hardware stores are included. If sizes that are outside of the built in tables are requested then the code will attempt to interpolate the missing value.
//   .
//   Functions are included to look up the various dimensions of fasteners by size and type. This way one using this library may allow the end user to choose fastener sizes from the customizer menu. Then the script may adapt, re-sizing or re-positioning things based on the outer dimensions of the requested fastener sizes. Sizes may be looked up as scalars describing just one dimension. Or they may be looked up as a vector which may then be passed to the functions that look up the individual dimensions or the module which renders the part. This way the lookup and/or interpolation need only happen once.
//   .
//   The goal here is to allow the user to create customizable designs where the end user may choose parts that they already have on hand or parts that are easily available. Designers are encouraged to give the end-user plenty of choices. Perfectly valid arguments regarding the merits of measurement systems aside, the best fastener size is the one you already have on hand. The next best is the one your local hardware store sells in bulk rather than the specialty isle.
//   .
//   Provisions are included for distorting horizontal bolt holes, to remove some extra material from the top side. This way when printing via fused filament fabrication plastic which sags down will just cancel this distortion out rather than requiring drilling so the bolt can fit cleanly. The distortion is defined by two special variables, $unf-hdist_y and $unf_hdistX. These define the extra removed material by height and width respectively, both as a percentage of the shaft diameter.
//   .
//   So far this feature has been developed only for bolt holes and not the other parts. The original intention was to distort every part depending on the angle at which it is rendered. Unfortunately there is no good way to know what angle a part is being rendered in OpenSCAD so it relies on the user telling it. Thus this feature has not been furtner developed.

use <unfy_lists.scad>
use <unfy_math.scad>
use <unfy_shapes.scad>

parm_part = "Collection"; // ["Collection", "HexHeadBolt_Test_Block", "CapHeadBolt_Test_Block", "CountersunkBolt_Test_Block", "HexNut_Test_Block", "SquareNut_Test_Block", "Washer_Test_Block", "Heatset_Test_Block", "SelfTap_Test_Block", "SelfTap_Pilot_Test_Block", "Bolt_Distortion_Test"]

parm_size = "m3"; // ["m2", "m2.5", "m3", "m4", "m8", "#00", "#000", "#0000", "#4", "#6", "#8", "#10", "#12", "1/4\"", "5/16\"", "3/8\"", "ST2.2", "ST2.9", "ST3.5", "ST4.2", "ST4.8"]

//horizontal bolt shaft distortion height (as percentage of diameter)
$unf_hdistY = 10; //[0:100]

//horizontal bolt shaft distortion width (as percentage of diameter)
$unf_hdistX = 80; //[0:100]

//printer nozzle diameter, sets the spacing of the points of star shaped pilot holes
$unf_nozzle = 0.4;

//self tapping screw star pilot hole inner diameter (as percentage of the thread depth above the root diameter)
$unf_stpPilotId = 0; //[0:100]

//self tapping screw star pilot hole outer diameter (as percentage of the thread depth above the root diameter)
$unf_stpPilotOd = 50; //[0:100]

//distance subtractions should "hang over"
$unf_over = 0.1;
$unf_wall = 2;

body_color = "Blue"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

subtraction_color = "Yellow"; //["Lavender", "Thistle", "Plum", "Violet", "Orchid", "Fuchsia", "Magenta", "MediumOrchid", "MediumPurple", "BlueViolet", "DarkViolet", "DarkOrchid", "DarkMagenta", "Purple", "Indigo", "DarkSlateBlue", "SlateBlue", "MediumSlateBlue", "Pink", "LightPink", "HotPink", "DeepPink", "MediumVioletRed", "PaleVioletRed", "Aqua", "Cyan", "LightCyan", "PaleTurquoise", "Aquamarine", "Turquoise", "MediumTurquoise", "DarkTurquoise", "CadetBlue", "SteelBlue", "LightSteelBlue", "PowderBlue", "LightBlue", "SkyBlue", "LightSkyBlue", "DeepSkyBlue", "DodgerBlue", "CornflowerBlue", "RoyalBlue", "Blue", "MediumBlue", "DarkBlue", "Navy", "MidnightBlue", "IndianRed", "LightCoral", "Salmon", "DarkSalmon", "LightSalmon", "Red", "Crimson", "FireBrick", "DarkRed", "GreenYellow", "Chartreuse", "LawnGreen", "Lime", "LimeGreen", "PaleGreen", "LightGreen", "MediumSpringGreen", "SpringGreen", "MediumSeaGreen", "SeaGreen", "ForestGreen", "Green", "DarkGreen", "YellowGreen", "OliveDrab", "Olive", "DarkOliveGreen", "MediumAquamarine", "DarkSeaGreen", "LightSeaGreen", "DarkCyan", "Teal", "LightSalmon", "Coral", "Tomato", "OrangeRed", "DarkOrange", "Orange", "Gold", "Yellow", "LightYellow", "LemonChiffon", "LightGoldenrodYellow", "PapayaWhip", "Moccasin", "PeachPuff", "PaleGoldenrod", "Khaki", "DarkKhaki", "Cornsilk", "BlanchedAlmond", "Bisque", "NavajoWhite", "Wheat", "BurlyWood", "Tan", "RosyBrown", "SandyBrown", "Goldenrod", "DarkGoldenrod", "Peru", "Chocolate", "SaddleBrown", "Sienna", "Brown", "Maroon", "White", "Snow", "Honeydew", "MintCream", "Azure", "AliceBlue", "GhostWhite", "WhiteSmoke", "Seashell", "Beige", "OldLace", "FloralWhite", "Ivory", "AntiqueWhite", "Linen", "LavenderBlush", "MistyRose", "Gainsboro", "LightGrey", "Silver", "DarkGray", "Gray", "DimGray", "LightSlateGray", "SlateGray", "DarkSlateGray", "Black"]

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

/* [Self Tapping Screws] */
//head style
parm_stp_head = "pan"; // ["pan", "csk", "raised_csk", "cheese", "button", "flange_button", "round", "truss", "binding", "wafer", "hex", "hex_washer"]

//pilot test block, number of holes in each row
parm_stp_pilot_steps = 4;

//pilot test block, smallest star outer diameter (as percentage of the thread depth above the root diameter)
parm_stp_pilot_min_od = 25; //[0:100]

//pilot test block, largest star outer diameter (as percentage of the thread depth above the root diameter)
parm_stp_pilot_max_od = 100; //[0:100]

$fn = $preview ? 36 : 360;

/************************ Common *********************************************/

// Function: unf_fnrType
// Synopsis: Fastener Type
// Description:
//   Takes a vector describing a fastener and returns a string representing the fastener type.
// Usage:
//   unf_fnrType(fastener_vector)
// Arguments:
//   in = vector describing an unfy_fastener
function unf_fnrType(in) = is_list(in) ? in[0] : unf_stToUpper(in);
					
// Function: unf_fnrSize
// Synopsis: Fastener Size
// Description:
//   Takes a vector describing a fastener or a string representing the fastener size and returns a string representing the fastener size.
//   .
//   Of course this isnt't doing much when it is passed the string. This is done so that a variable may hold the size string which the user requested before it is expanded into the vector and still work in the same code.
// Usage:
//   unf_fnrSize(fastener_size_or_vector)
// Arguments:
//   in = vector describing an unfy_fastener or a string representing the size of one.
function unf_fnrSize(in) = is_list(in) ? in[1] : unf_stToUpper(in);

// Function: unf_fnrDiameter
// Synopsis: Fastener Clearance Diameter
// Description:
//   Takes a vector describing a fastener or a string representing the fastener size and returns the diameter of the widest part in millimeters. Useful for calculating positioning or sizes of parts that will contain the fastener when the end-user is allowed to pick from a variety of sizes of fasteners.
// Usage:
//   unf_fnrDiameter(fastener_size_or_vector)
// Arguments:
//   in = vector describing an unfy_fastener or a string representing the size of one.
function unf_fnrDiameter(in) = is_list(in) ? in[2] : (is_num(in) ? in : 5);

// Function: unf_fnrIsSt
// Synopsis: Is this an ISO tapping screw size
// Description:
//   Returns true if the size string is an ISO tapping screw size such as "ST2.9".
// Usage:
//   unf_fnrIsSt(size)
// Arguments:
//   in = size as a string
function unf_fnrIsSt(in) = is_string(in) && ("s" == in[0] || "S" == in[0]) && ("t" == in[1] || "T" == in[1]);

// Function: unf_fnrStToM
// Synopsis: Convert an ISO tapping screw size to a metric size
// Description:
//   Converts an ISO tapping screw size such as "ST2.9" to the metric size of the same diameter, "M2.9", so it may be looked up in the metric tables. Other sizes are returned unchanged.
// Usage:
//   unf_fnrStToM(size)
// Arguments:
//   in = size as a string
function unf_fnrStToM(in) = unf_fnrIsSt(in) ? str("M", unf_sub(in, 2)) : in;

// Function: unf_fnrShaftDiameter
// Synopsis: Fastener Shaft Diameter
// Description:
//   Takes a vector describing a fastener or a string representing the fastener size and returns the shaft diameter in millimeters.
// Usage:
//   unf_fnrShaftDiameter(fastener_size_or_vector)
// Arguments:
//   in = vector describing an unfy_fastener or a string representing the size of one.
function unf_fnrShaftDiameter(in) = is_list(in) ? in[3] : (
	unf_fnrIsSt(in) ? unf_stToNum(unf_sub(in, 2)) :
	"m" == in[0] || "M" == in[0] ? (
		unf_stToNum(unf_sub(in, 1))
	) : (
		"\"" == in[len(in)-1] ? 25.4 * unf_stToNum(unf_sub(in, 0, len(in)-1)) : (
			"#0000" == in ? 0.533 : ( // 0.021"
				"#000" == in ? 0.864 : ( // 0.034"
					"#00" == in ? 1.194 : ( // 0.047"
						"#" != in[0] ? unf_fnrShaftDiameter("M3") : (
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

// Section: Distorted Shafts

// Module: unf_shaft
// Synopsis: Fastener Shaft
// Description:
//   Render a fastener shaft hole, optionally with distortions to account for overhang sagging when 3d-printing.
// Usage:
//   unf_shaft(diameter, length, distorted, $unf_hdistX, $unf_hdistY, body_color)
// Figure(2D;NoAxes;Size=640x480): various values of unf_hdistX and unf_hdistY. (0, 0) or distorted=false would be a perfect circle.
//   $unf_over = 0.01;
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
//               unf_shaft(30, 1, true, $unf_hdistX=dx, $unf_hdistY=dy);
//            }
//         }
//         color("Blue"){
//            translate([-15, -30]){
//               resize([30, 10]){
//                  projection() linear_extrude(1) text(str("(", dx, ", ", dy, ")"));
//               }
//            }
//         }
//      }
//   }
// Arguments:
//   diameter = shaft diameter in mm
//   length = length in mm
//   distorted = true/false should this be distorted
//   body_color = color in which to render the shaft if rendered as a positive, color of the cut surfaces if rendering as a negative.
//   ---
//   $unf_hdistX = width of distortion as a percentage of the diameter (0-100)
//   $unf_hdistY = height of distortion as a percentage of the diameter (0-100)
module unf_shaft(diameter=3, length=10, distorted=false, body_color="Yellow"){
	color(body_color){
		if (distorted){
			dist_d =(diameter * $unf_hdistX) / 100;
			linear_extrude(length) {
				hull(){
					circle(d=diameter);
					translate([0, ((diameter-dist_d)/2)+((diameter*$unf_hdistY)/200)]){
						circle(d=dist_d);
					}
				}
			}
		} else { // !distorted
			cylinder(d=diameter, h=length);
		}
	}
}

// Module: unf_distortionTestBlock
// Synopsis: Shaft Distortion Test Block
// Description:
//   Render a block with a series of distorted bolt shafts with varying values of unf_hdistX and unf_hdistY for choosing the best values to use with a particular setup.
// Usage:
//   unf_distortionTestBlock(diameter, depth, steps, min_spacing, min_dist_x, max_dist_x, min_dist_y, max_dist_y, include_control, body_color, subtraction_color)
// Figure(NoAxes; VPR=[93, 0, 0];Size=640x480):
//   $unf_over = 0.01;
//   $fn=360;
//   use <unfy_fasteners.scad>
//   unf_distortionTestBlock(steps=4, body_color="Blue", subtraction_color="Yellow");
// Arguments:
//   diameter = shaft diameter
//   depth = thickness of the block
//   steps = number of rows, columns
//   min_spacing = minimum spacing between holes
//   min_dist_x = minimum unf_hdistX to try
//   max_dist_x = maximum unf_hdistX to try
//   min_dist_y = minimum unf_hdistY to try
//   max_dist_y = maximum unf_hdistY to try
//   body_color = color of the block
//   subtraction_color = color of the surfaces cut into the block by the test holes
module unf_distortionTestBlock(
	diameter = 3,
	depth = 10,
	steps = 5,
	min_spacing = 3,
	min_dist_x = 25,
	max_dist_x = 100,
	min_dist_y = 5,
	max_dist_y = 20,
	include_control = true,
	body_color="Blue",
	subtraction_color="yellow"
){
	x_inc = diameter + min_spacing;
	y_inc = x_inc + ((diameter * max_dist_x) / 200);
   
	width = (steps * x_inc) + min_spacing;
	height = (steps * y_inc) + min_spacing;

	difference(){
		color(body_color){
			cube([width, depth, height]);
		}
		for (ix = [0:1:steps-1], iy = [0:1:steps-1]){
			dist_x = min_dist_x + (ix * (max_dist_x-min_dist_x) / steps);
			dist_y = min_dist_y + (iy * (max_dist_y-min_dist_y) / steps);
			translate([min_spacing + (diameter/2) + (ix * x_inc), -1, min_spacing + (diameter/2) + (iy * y_inc)]){
				rotate([270, 180, 0]){
					color(subtraction_color){
						unf_shaft(length = depth+2, diameter = diameter, $unf_hdistX=dist_x, $unf_hdistY=dist_y, distorted=true);
					}
				}
			}
		}
	}
	
	if (include_control){
		side = diameter + (2 * min_spacing);
		translate([-side, 0, 0]){
			difference(){
				color(body_color){
					cube([side, depth, side]);
				}
				translate([side/2, -1, side/2]){
					rotate([270, 0, 0]){
						color(subtraction_color){
							cylinder(d=diameter, h=depth + 2);
						}
					}
				}     
			}
		}
	}
}

// Section: Cap Bolts - unf_cap*
//   The vector representing a cap bolt will consist of, in order:
//   * name
//   * bolt_diameter
//   * head_diameter
//   * head_height
//   * default_length


// Function: unf_capV
// Synopsis: Cap Head Bolt Vector
// Description:
//   Retrieve a vector representing the dimensions of a cap-head bolt given the size. Will return the passed parameter if passed a vector. Thus sizes and dimension vectors may be treated interchangably.
// Usage:
//   unf_capV(size_or_vector)
// Arguments:
//   size = size as a string or the vector itself
function unf_capV(size) = is_list(size) ? size : [
	"CAP", //0
	unf_fnrSize(size), //1
	unf_capHeadDiameter(size), //2
	unf_fnrShaftDiameter(size), //3
	unf_capHeadHeight(size), //4
	unf_capDefaultLength(size) //5
];

// Function: unf_capHeadDiameter
// Synopsis: Cap Head Bolt Clearance Diameter
// Description:
//   Retrieve the diameter in mm of the head of a cap-head bolt given the size.
// Usage:
//   unf_capHeadDiameter(size_or_vector)
// Arguments:
//   size = size as a string or the unf_capV() vector itself
function unf_capHeadDiameter(in) = is_list(in) ? in[2] : (
	unf_fnrIsSt(in) ? unf_capHeadDiameter(unf_fnrStToM(in)) :
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
			"#0000" == in ? unf_capHeadDiameter("M0.53") : (
				"#000" == in ? unf_capHeadDiameter("M0.86") : (
					"#00" == in ? unf_capHeadDiameter("M1.19") : (
						"#" != in[0] ? unf_capHeadDiameter("M3") : (
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

// Function: unf_capHeadHeight
// Synopsis: Cap Head Bolt Head Height
// Description:
//   Retrieve the height or thickness in mm of the head of a cap-head bolt given the size.
// Usage:
//   unf_capHeadHeight(size_or_vector)
// Arguments:
//   size = size as a string or the unf_capV() vector itself
function unf_capHeadHeight(in) = is_list(in) ? in[4] : unf_fnrShaftDiameter(in);

// Function: unf_capDefaultLength
// Synopsis: Cap Head Bolt Default Length
// Description:
//   Retrieve a default length for a cap head bolt given it's size. Probably not very useful in a real design, good for picking a length to demonstrate an example of a unf_cap bolt.
// Usage:
//   unf_capDefaultLength(size_or_vector)
// Arguments:
//   size = size as a string or the unf_capV() vector itself
function unf_capDefaultLength(in) = is_list(in) ? in[5] : unf_fnrShaftDiameter(in) * 15 / 3;

// Module: unf_cap
// Synopsis: Cap Head Bolt
// Description:
//   Render a negative for a shaft and/or head-recess for a cap-head bolt. Note, the cap head is rendered as a simple cylinder with the diameter of the widest part of the actual head. This is because it is meant for being a negative, to recess a bolt and not for printing an actual bolt.
// Figure(Spin;VPD=50; VPT=[0, 0, 5];  NoAxes): note - the head_ext area is semi-transparent.
//   $fn = 36;
//   $unf_over = 0.1;
//   $unf_wall=2;
//   $unf_hdistX = 80;
//   $unf_hdistY = 10;
//   use <unfy_fasteners.scad>;
//   unf_cap(size="m3", length=10, head_ext=2, distorted=true, body_color="Yellow");
// Usage:
//   unf_cap(size, length, head_ext, distorted, $unf_hdistX, $unf_hdistY, body_color)
// Arguments:
//   size = string representing the size or the unf_capV() vector.
//   length = length in mm
//   head_ext = length in mm to recess the head beyond just it's thickness
//   distorted = true/false, should the bolt hole be distorted
//   body_color = color in which to render the bolt if rendered as a positive, color of the cut surfaces if rendering as a negative.
//   ---
//   $unf_hdistX = width of distortion as a percentage of the diameter (0-100)
//   $unf_hdistY = height of distortion as a percentage of the diameter (0-100)
module unf_cap(size = "m3", length = -1, head_ext = -1, distorted = false, body_color="Yellow"){
	color(body_color){
		let (head_ext = (0 <= head_ext) ? head_ext : $unf_over,
			  size = is_list(size) ? size : unf_capV(size),
			  length = 0 < length ? length : unf_capDefaultLength(size)){
			head_d = unf_capHeadDiameter(size);
			head_height = unf_capHeadHeight(size);
			shaft_d = unf_fnrShaftDiameter(size);
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
}

// Section: Countersunk Bolts - unf_csk*
//   The vector representing a countersunk bolt will consist of, in order:
//   * name
//   * bolt_diameter
//   * head_diameter
//   * head_height
//   * default_length

// Function: unf_cskV
// Synopsis: Counter Sunk Bolt Vector
// Description:
//   Retrieve a vector representing the dimensions of a countersunk bolt given the size. Will return the passed parameter if passed a vector. Thus sizes and dimension vectors may be treated interchangably.
// Usage:
//   unf_cskV(size_or_vector)
// Arguments:
//   size = size as a string or the vector itself
function unf_cskV(size) = is_list(size) ? size : [
	"CSK", //0
	unf_fnrSize(size), //1
	unf_cskHeadDiameter(size), //2
	unf_fnrShaftDiameter(size), //3
	unf_cskHeadHeight(size), //4
	unf_cskDefaultLength(size) //5
];

// Function: unf_cskHeadDiameter
// Synopsis: Countersunk Head Clearance Diameter
// Description:
//   Retrieve the diameter in mm of the head of a countersunk bolt given the size.
// Usage:
//   unf_cskHeadDiameter(size_or_vector)
// Arguments:
//   size = size as a string or the unf_cskV() vector itself
function unf_cskHeadDiameter(in) = is_list(in) ? in[2] : (
	unf_fnrIsSt(in) ? unf_cskHeadDiameter(unf_fnrStToM(in)) :
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
						"#" != in[0] ? unf_cskHeadDiameter("M3") : (
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

// Function: unf_cskHeadHeight
// Synopsis: Countersunk Head Height
// Description:
//   Retrieve the height or thickness in mm of the head of a countersunk bolt given the size.
// Usage:
//   unf_cskHeadHeight(size_or_vector)
// Arguments:
//   size = size as a string or the unf_cskV() vector itself
function unf_cskHeadHeight(in) = is_list(in) ? in[4] : (
	unf_fnrIsSt(in) ? unf_cskHeadHeight(unf_fnrStToM(in)) :
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
						"#" != in[0] ? unf_cskHeadHeight("M3") : (
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

// Function: unf_cskDefaultLength
// Synopsis: Countersunk Bolt Default Length
// Description:
//   Retrieve a default length for a countersunk bolt given it's size. Probably not very useful in a real design, good for picking a length to demonstrate an example of a unf_csk bolt.
// Usage:
//   unf_cskDefaultLength(size_or_vector)
// Arguments:
//   size = size as a string or the unf_cskV() vector itself
function unf_cskDefaultLength(in) = is_list(in) ? in[5] : unf_fnrShaftDiameter(in) * 15 / 3;

// Module: unf_csk
// Synopsis: Countersunk Bolt
// Description:
//   Render a negative for a shaft and/or head-recess for a countersunk bolt.
// Figure(Spin;VPD=50; VPT=[0, 0, 5];  NoAxes): note - the head_ext area is semi-transparent.
//   $fn = 36;
//   $unf_over = 0.1;
//   $unf_wall=2;
//   $unf_hdistX = 80;
//   $unf_hdistY = 10;
//   use <unfy_fasteners.scad>;
//   unf_csk(size="m3", length=10, head_ext=2, distorted=true);
// Usage:
//   unf_csk(size, length, head_ext, distorted, body_color)
// Arguments:
//   size = string representing the size or the unf_cskV() vector.
//   length = length in mm
//   head_ext = length in mm to recess the head beyond just it's thickness
//   distorted = true/false, should the bolt hole be distorted
//   body_color = color in which to render the bolt if rendered as a positive, color of the cut surfaces if rendering as a negative.
//   ---
//   $unf_hdistX = width of distortion as a percentage of the diameter (0-100)
//   $unf_hdistY = height of distortion as a percentage of the diameter (0-100)
module unf_csk(size = "m3", length = -1, head_ext = -1, distorted = false, body_color = "Yellow"){
	color(body_color){
		let (head_ext = (0 <= head_ext) ? head_ext : $unf_over,
			  size = is_list(size) ? size : unf_cskV(size),
			  length = 0 < length ? length : unf_cskDefaultLength(size)){
			head_d = unf_cskHeadDiameter(size);
			head_height = unf_cskHeadHeight(size);
			shaft_d = unf_fnrShaftDiameter(size);
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
}

// Section: Hex Head Bolts - unf_hex*
//   The vector representing a hex head bolt will consist of, in order:
//   * name
//   * bolt_diameter
//   * head_diameter
//   * head_height
//   * default_length

// Function: unf_hexV
// Synopsis: Hex Head Bolt Vector
// Description:
//   Retrieve a vector representing the dimensions of a hex-head bolt given the size. Will return the passed parameter if passed a vector. Thus sizes and dimension vectors may be treated interchangably.
// Usage:
//   unf_hexV(size_or_vector)
// Arguments:
//   size = size as a string or the vector itself
function unf_hexV(size) = is_list(size) ? size : [
	"HEX", //0
	unf_fnrSize(size), //1
	unf_hexHeadDiameter(size), //2
	unf_fnrShaftDiameter(size), //3
	unf_hexHeadHeight(size), //4
	unf_hexDefaultLength(size) //5
];

// Function: unf_hexHeadDiameter
// Synopsis: Hex Head Bolt Clearance Diameter
// Description:
//   Retrieve the diameter in mm of the head of a hex-head bolt given the size.
// Usage:
//   unf_hexHeadDiameter(size_or_vector)
// Arguments:
//   size = size as a string or the unf_hexV() vector itself
function unf_hexHeadDiameter(in) = is_list(in) ? in[2] : (
	unf_fnrIsSt(in) ? unf_hexHeadDiameter(unf_fnrStToM(in)) :
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
			"#0000" == in ? unf_hexHeadDiameter(str("M", unf_fnrShaftDiameter(in))) : ( // no real data
				"#000" == in ? unf_hexHeadDiameter(str("M", unf_fnrShaftDiameter(in))) : ( // no real data
					"#00" == in ? unf_hexHeadDiameter(str("M", unf_fnrShaftDiameter(in))) : ( // no real data
						"#" != in[0] ? unf_hexHeadDiameter("M3") : (
							unf_hexHeadDiameter(str("M", unf_fnrShaftDiameter(in))) // no real data
						)
					)
				)
			)
		)
	)
);

// Function: unf_hexHeadHeight
// Synopsis: Hex Head Height
// Description:
//   Retrieve the height or thickness in mm of the head of a hex-head bolt given the size.
// Usage:
//   unf_hexHeadHeight(size_or_vector)
// Arguments:
//   size = size as a string or the unf_hexV() vector itself
function unf_hexHeadHeight(in) = is_list(in) ? in[4] : (
	unf_fnrIsSt(in) ? unf_hexHeadHeight(unf_fnrStToM(in)) :
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
			"#0000" == in ? unf_hexHeadHeight(str("M", unf_fnrShaftDiameter(in))) : ( // no real data
				"#000" == in ? unf_hexHeadHeight(str("M", unf_fnrShaftDiameter(in))) : ( // no real data
					"#00" == in ? unf_hexHeadHeight(str("M", unf_fnrShaftDiameter(in))) : ( // no real data
						"#" != in[0] ? unf_hexHeadHeight("M3") : (
							unf_hexHeadHeight(str("M", unf_fnrShaftDiameter(in))) // no real data
						)
					)
				)
			)
		)
	)
);

// Function: unf_hexDefaultLength
// Synopsis: Hex Head Bolt Default Length
// Description:
//   Retrieve a default length for a hex head bolt given it's size. Probably not very useful in a real design, good for picking a length to demonstrate an example of a unf_hex bolt.
// Usage:
//   unf_hexDefaultLength(size_or_vector)
// Arguments:
//   size = size as a string or the unf_hexV() vector itself
function unf_hexDefaultLength(in) = is_list(in) ? in[5] : unf_fnrShaftDiameter(in) * 15 / 3;

// Module: unf_hex
// Synopsis: Hex Head Bolt
// Description:
//   Render a negative for a shaft and/or head-recess for a hex-head bolt.
// Figure(Spin;VPD=50; VPT=[0, 0, 5];  NoAxes): note - the head_ext area is semi-transparent.
//   $fn = 36;
//   $unf_over = 0.1;
//   $unf_wall=2;
//   $unf_hdistX = 80;
//   $unf_hdistY = 10;
//   use <unfy_fasteners.scad>;
//   unf_hex(size="m3", length=10, head_ext=2, distorted=true);
// Usage:
//   unf_hex(size, length, head_ext, distorted, body_color)
// Arguments:
//   size = string representing the size or the unf_hexV() vector.
//   length = length in mm
//   head_ext = length in mm to recess the head beyond just it's thickness
//   distorted = true/false, should the bolt hole be distorted
//   body_color = color in which to render the bolt if rendered as a positive, color of the cut surfaces if rendering as a negative.
//   ---
//   $unf_hdistX = width of distortion as a percentage of the diameter (0-100)
//   $unf_hdistY = height of distortion as a percentage of the diameter (0-100)
module unf_hex(size = "m3", length = -1, head_ext = -1, distorted = false, body_color="Yellow"){
	color(body_color){
		let (head_ext = (0 <= head_ext) ? head_ext : $unf_over,
			  size = is_list(size) ? size : unf_hexV(size),
			  length = 0 < length ? length : unf_hexDefaultLength(size)){
			head_d = unf_hexHeadDiameter(size);
			head_height = unf_hexHeadHeight(size);
			shaft_d = unf_fnrShaftDiameter(size);
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
}

// Section: Self Tapping Screws - unf_stp*
//   Self tapping screws for plastic. These need two different holes. The part being clamped gets a clearance hole, just wide enough for the screw to slide in and out without the threads biting, plus a recess for the head. The part being screwed into gets a pilot hole, narrow enough that the threads cut into the plastic and hold tight but not so narrow that the plastic splits.
//   .
//   Pilot holes may be star shaped rather than round. The plastic displaced by the threads then has somewhere to go between the points instead of pushing outward on the surrounding wall. The points are spaced according to $unf_nozzle so they are not so fine that they just print smooth. The inner and outer diameters of the star are set as a percentage of the thread depth above the root (minor) diameter by $unf_stpPilotId and $unf_stpPilotOd. A round pilot hole is made at the average of the two.
//   .
//   Metric sizes ("M3", "ST2.9", etc...) use ISO 1478 thread dimensions, ISO 273 fine clearance holes and ISO 7049, 7050, 7051, 1481, 1479, 7053, 7380-1 and 7380-2 head dimensions. Numbered and inch sizes ("#6", "1/4"", etc...) use ASME B18.6.4 and B18.6.3 dimensions and ASME close fit clearance holes. Head styles which have no ISO standard use the ASME dimensions for metric sizes too, flange_button has no ASME standard so it uses the ISO dimensions for all sizes. Sizes not in the tables are interpolated by diameter. None of these have been verified against real screws yet.
//   .
//   Available head styles, in the negative these are all rendered as either a cylinder or a cone. Self tapping screws turn as they are driven so even hex heads get a round recess.
//   * "pan"
//   * "csk" (or "flat", "countersunk")
//   * "raised_csk" (or "oval", "raised_countersunk")
//   * "cheese" (or "fillister")
//   * "button"
//   * "flange_button" (or "flanged_button") - button head with a built in washer
//   * "round"
//   * "truss"
//   * "binding"
//   * "wafer" (or "modified_truss") - no standard, typical proportions
//   * "hex"
//   * "hex_washer"
//   .
//   The vector representing a self tapping screw will consist of, in order:
//   * name
//   * size
//   * head_diameter
//   * thread_diameter (major)
//   * head_height
//   * default_length
//   * head_style
//   * head_shape ("cyl" or "cone")
//   * minor_diameter
//   * clearance_diameter
//   * pitch

// Function: unf_stpV
// Synopsis: Self Tapping Screw Vector
// Description:
//   Retrieve a vector representing the dimensions of a self tapping screw given the size and head style. Will return the passed parameter if passed a vector. Thus sizes and dimension vectors may be treated interchangably.
// Usage:
//   unf_stpV(size_or_vector, [head])
// Arguments:
//   size = size as a string or the vector itself
//   head = head style, see the section description for the list ("pan")
function unf_stpV(size="m3", head="pan") = is_list(size) ? size : (
	let (head = unf_stpHeadStyle(head)) [
		"STP", //0
		unf_fnrSize(size), //1
		unf_stpHeadDiameter(size, head), //2
		unf_fnrShaftDiameter(size), //3
		unf_stpHeadHeight(size, head), //4
		unf_stpDefaultLength(size), //5
		head, //6
		unf_stpHeadShape(head), //7
		unf_stpMinorDiameter(size), //8
		unf_stpClearanceDiameter(size), //9
		unf_stpPitch(size) //10
	]
);

// Function: unf_stpHeadStyle
// Synopsis: Self Tapping Screw Head Style
// Description:
//   Takes a vector describing a self tapping screw or a head style name and returns the normalized head style name. Aliases such as "flat" or "oval" are converted to "csk" and "raised_csk".
// Usage:
//   unf_stpHeadStyle(head_or_vector)
// Arguments:
//   in = head style as a string or the unf_stpV() vector itself
function unf_stpHeadStyle(in="pan") = is_list(in) ? in[6] : (
	let (lower = unf_stToLower(in),
		  h = ("flat" == lower || "countersunk" == lower) ? "csk" : (
			  ("oval" == lower || "raised_countersunk" == lower) ? "raised_csk" : (
				  "fillister" == lower ? "cheese" : (
					  "modified_truss" == lower ? "wafer" : (
						  "flanged_button" == lower ? "flange_button" : lower
					  )
				  )
			  )
		  ))
	assert(0 < len([for (s = ["pan", "csk", "raised_csk", "cheese", "button", "flange_button", "round", "truss", "binding", "wafer", "hex", "hex_washer"]) if (s == h) s]), str("unknown self tapping screw head style: ", in))
	h
);

// Function: unf_stpHeadShape
// Synopsis: Self Tapping Screw Head Shape
// Description:
//   Takes a vector describing a self tapping screw or a head style name and returns the shape used for the head recess, "cone" for countersunk heads, otherwise "cyl".
// Usage:
//   unf_stpHeadShape(head_or_vector)
// Arguments:
//   in = head style as a string or the unf_stpV() vector itself
function unf_stpHeadShape(in="pan") = is_list(in) ? in[7] : (
	let (h = unf_stpHeadStyle(in)) ("csk" == h || "raised_csk" == h) ? "cone" : "cyl"
);

// Function: unf_stpIsImperial
// Synopsis: Is this a numbered or inch size
// Description:
//   Returns true if the size string is a numbered ("#6") or inch ("1/4"") size, which use ASME tables, false for metric sizes which use ISO tables.
// Usage:
//   unf_stpIsImperial(size)
// Arguments:
//   in = size as a string
function unf_stpIsImperial(in) = "#" == in[0] || "\"" == in[len(in)-1];

// Function: unf_stpInch
// Synopsis: Convert a table in inches to mm
// Description:
//   Multiplies every value in a table of rows by 25.4. Lets the ASME tables be written in inches as published.
// Usage:
//   unf_stpInch(table)
// Arguments:
//   t = table, a list of rows of numbers in inches
function unf_stpInch(t) = [for (r = t) r * 25.4];

// Function: unf_stpLookup
// Synopsis: Self Tapping Screw Table Lookup
// Description:
//   Look up a dimension by thread diameter from the ISO table for metric sizes or the ASME table for numbered and inch sizes, interpolating if the size is not in the table. Tables are lists of rows in mm, the first column being the thread diameter.
// Usage:
//   unf_stpLookup(size, iso, asme, [col])
// Arguments:
//   in = size as a string
//   iso = table for metric sizes
//   asme = table for numbered and inch sizes
//   col = column of the table holding the wanted dimension (1)
function unf_stpLookup(in, iso, asme, col=1) = let (t = unf_stpIsImperial(in) ? asme : iso) (
	unf_round(place=-3, num=unf_lookup(unf_fnrShaftDiameter(in), [for (r = t) [r[0], r[col]]]))
);

// Function: unf_stpHeadTable
// Synopsis: Self Tapping Screw Head Table
// Description:
//   Returns a table of head dimensions for a head style. Each row is [thread diameter, head diameter, head height] in mm. Head diameter is the widest part of the head, across the corners or the washer face for hex heads, the theoretical sharp diameter for countersunk heads.
// Usage:
//   unf_stpHeadTable(head, imperial)
// Arguments:
//   head = head style
//   imperial = true for the ASME table, false for the ISO table
function unf_stpHeadTable(head="pan", imperial=false) = let (head = unf_stpHeadStyle(head)) (
	imperial ? (
		("csk" == head || "raised_csk" == head) ? unf_stpInch(
			[[0.086, 0.172, 0.051], // #2
			 [0.112, 0.225, 0.067], // #4
			 [0.138, 0.279, 0.083], // #6
			 [0.164, 0.332, 0.100], // #8
			 [0.190, 0.385, 0.116], // #10
			 [0.216, 0.438, 0.132], // #12
			 [0.242, 0.507, 0.153], // #14
			 [0.3125, 0.635, 0.191], // 5/16"
			 [0.375, 0.762, 0.230]]) : ( // 3/8"
		"cheese" == head ? unf_stpInch(
			[[0.086, 0.140, 0.083], // #2
			 [0.112, 0.183, 0.107], // #4
			 [0.138, 0.226, 0.132], // #6
			 [0.164, 0.270, 0.156], // #8
			 [0.190, 0.313, 0.180], // #10
			 [0.216, 0.357, 0.205], // #12
			 [0.25, 0.414, 0.237], // 1/4"
			 [0.3125, 0.518, 0.295], // 5/16"
			 [0.375, 0.622, 0.355]]) : ( // 3/8"
		("round" == head || "button" == head) ? unf_stpInch(
			[[0.086, 0.162, 0.069], // #2
			 [0.112, 0.211, 0.086], // #4
			 [0.138, 0.260, 0.103], // #6
			 [0.164, 0.309, 0.120], // #8
			 [0.190, 0.359, 0.137], // #10
			 [0.216, 0.408, 0.153], // #12
			 [0.25, 0.472, 0.175], // 1/4"
			 [0.3125, 0.590, 0.216], // 5/16"
			 [0.375, 0.708, 0.256]]) : ( // 3/8"
		"truss" == head ? unf_stpInch(
			[[0.086, 0.194, 0.053], // #2
			 [0.112, 0.257, 0.069], // #4
			 [0.138, 0.321, 0.086], // #6
			 [0.164, 0.384, 0.102], // #8
			 [0.190, 0.448, 0.118], // #10
			 [0.216, 0.511, 0.134], // #12
			 [0.25, 0.573, 0.150], // 1/4"
			 [0.3125, 0.698, 0.183], // 5/16"
			 [0.375, 0.823, 0.215]]) : ( // 3/8"
		"binding" == head ? unf_stpInch(
			[[0.086, 0.181, 0.050], // #2
			 [0.112, 0.235, 0.064], // #4
			 [0.138, 0.290, 0.079], // #6
			 [0.164, 0.344, 0.093], // #8
			 [0.190, 0.399, 0.108], // #10
			 [0.216, 0.454, 0.122], // #12
			 [0.25, 0.513, 0.137], // 1/4"
			 [0.3125, 0.641, 0.168], // 5/16"
			 [0.375, 0.769, 0.201]]) : ( // 3/8"
		"wafer" == head ? unf_stpHeadTable("wafer", false) : (
		"flange_button" == head ? unf_stpHeadTable("flange_button", false) : ( // no ASME standard, use ISO
		"hex" == head ? unf_stpInch(
			[[0.086, 0.144, 0.050], // #2, 1/8" across flats
			 [0.112, 0.217, 0.060], // #4, 3/16" across flats
			 [0.138, 0.289, 0.080], // #6, 1/4" across flats
			 [0.164, 0.289, 0.110], // #8, 1/4" across flats
			 [0.190, 0.360, 0.120], // #10, 5/16" across flats
			 [0.216, 0.360, 0.155], // #12, 5/16" across flats
			 [0.242, 0.433, 0.190], // #14, 3/8" across flats
			 [0.3125, 0.577, 0.230], // 5/16", 1/2" across flats
			 [0.375, 0.649, 0.295]]) : ( // 3/8", 9/16" across flats
		"hex_washer" == head ? unf_stpInch(
			[[0.086, 0.166, 0.050], // #2
			 [0.112, 0.225, 0.060], // #4
			 [0.138, 0.332, 0.080], // #6
			 [0.164, 0.332, 0.110], // #8
			 [0.190, 0.422, 0.120], // #10
			 [0.216, 0.422, 0.155], // #12
			 [0.242, 0.500, 0.190], // #14
			 [0.3125, 0.656, 0.230], // 5/16"
			 [0.375, 0.750, 0.295]]) : ( // 3/8"
		unf_stpInch( // pan
			[[0.086, 0.167, 0.062], // #2
			 [0.112, 0.219, 0.080], // #4
			 [0.138, 0.270, 0.097], // #6
			 [0.164, 0.322, 0.115], // #8
			 [0.190, 0.373, 0.133], // #10
			 [0.216, 0.425, 0.151], // #12
			 [0.242, 0.492, 0.175], // #14
			 [0.3125, 0.615, 0.218], // 5/16"
			 [0.375, 0.740, 0.261]]) // 3/8"
		)))))))))
	) : (
		("csk" == head || "raised_csk" == head) ? // ISO 7050, ISO 7051
			[[2.2, 4.4, 1.1],
			 [2.9, 6.3, 1.7],
			 [3.5, 8.2, 2.35],
			 [4.2, 9.4, 2.6],
			 [4.8, 10.4, 2.8],
			 [5.5, 11.5, 3.0],
			 [6.3, 12.6, 3.15],
			 [8, 17.3, 4.65],
			 [9.5, 20.0, 5.25]] : (
		"cheese" == head ? // ISO 1481
			[[2.2, 4.0, 1.3],
			 [2.9, 5.6, 1.8],
			 [3.5, 7.0, 2.1],
			 [4.2, 8.0, 2.4],
			 [4.8, 9.5, 3.0],
			 [5.5, 11.0, 3.2],
			 [6.3, 12.0, 3.6],
			 [8, 16.0, 4.8],
			 [9.5, 20.0, 6.0]] : (
		"flange_button" == head ? // ISO 7380-2, flange diameter
			[[3, 6.9, 1.65],
			 [4, 9.4, 2.2],
			 [5, 11.8, 2.75],
			 [6, 13.6, 3.3],
			 [8, 17.8, 4.4],
			 [10, 21.9, 5.5],
			 [12, 26.0, 6.6]] : (
		"button" == head ? // ISO 7380-1
			[[3, 5.7, 1.65],
			 [4, 7.6, 2.2],
			 [5, 9.5, 2.75],
			 [6, 10.5, 3.3],
			 [8, 14.0, 4.4],
			 [10, 17.5, 5.5]] : (
		"wafer" == head ? // no standard, typical proportions
			[[1, 2.5, 0.4],
			 [10, 25, 4]] : (
		"hex" == head ? // ISO 1479, across corners
			[[2.2, 3.695, 1.6], // 3.2 across flats
			 [2.9, 5.774, 2.3], // 5 across flats
			 [3.5, 6.351, 2.6], // 5.5 across flats
			 [4.2, 8.083, 3.0], // 7 across flats
			 [4.8, 9.238, 3.8], // 8 across flats
			 [5.5, 9.238, 4.1], // 8 across flats
			 [6.3, 11.547, 4.7], // 10 across flats
			 [8, 15.011, 6.0], // 13 across flats
			 [9.5, 18.475, 7.5]] : ( // 16 across flats
		"hex_washer" == head ? // ISO 7053, washer face diameter
			[[2.2, 4.2, 2.0],
			 [2.9, 6.3, 2.8],
			 [3.5, 8.3, 3.4],
			 [4.2, 8.8, 4.1],
			 [4.8, 10.5, 4.3],
			 [5.5, 11.0, 5.4],
			 [6.3, 13.5, 5.9]] : (
		"pan" == head ? // ISO 7049
			[[2.2, 4.0, 1.6],
			 [2.9, 5.6, 2.4],
			 [3.5, 7.0, 2.6],
			 [4.2, 8.0, 3.1],
			 [4.8, 9.5, 3.7],
			 [5.5, 11.0, 4.0],
			 [6.3, 12.0, 4.6],
			 [8, 16.0, 6.0],
			 [9.5, 20.0, 7.5]] : (
		unf_stpHeadTable(head, true) // no ISO standard, use ASME
		))))))))
	)
);

// Function: unf_stpHeadDiameter
// Synopsis: Self Tapping Screw Head Clearance Diameter
// Description:
//   Retrieve the diameter in mm of the head of a self tapping screw given the size and head style.
// Usage:
//   unf_stpHeadDiameter(size_or_vector, [head])
// Arguments:
//   in = size as a string or the unf_stpV() vector itself
//   head = head style ("pan")
function unf_stpHeadDiameter(in, head="pan") = is_list(in) ? in[2] : (
	unf_stpLookup(in, unf_stpHeadTable(head, false), unf_stpHeadTable(head, true), 1)
);

// Function: unf_stpHeadHeight
// Synopsis: Self Tapping Screw Head Height
// Description:
//   Retrieve the height or thickness in mm of the head of a self tapping screw given the size and head style. For a raised countersunk head this is just the countersunk part, the raised dome stands above the surface.
// Usage:
//   unf_stpHeadHeight(size_or_vector, [head])
// Arguments:
//   in = size as a string or the unf_stpV() vector itself
//   head = head style ("pan")
function unf_stpHeadHeight(in, head="pan") = is_list(in) ? in[4] : (
	unf_stpLookup(in, unf_stpHeadTable(head, false), unf_stpHeadTable(head, true), 2)
);

// Function: unf_stpDefaultLength
// Synopsis: Self Tapping Screw Default Length
// Description:
//   Retrieve a default length for a self tapping screw given it's size. Probably not very useful in a real design, good for picking a length to demonstrate an example of a unf_stp screw.
// Usage:
//   unf_stpDefaultLength(size_or_vector)
// Arguments:
//   in = size as a string or the unf_stpV() vector itself
function unf_stpDefaultLength(in) = is_list(in) ? in[5] : unf_fnrShaftDiameter(in) * 15 / 3;

// Function: unf_stpMinorDiameter
// Synopsis: Self Tapping Screw Minor Diameter
// Description:
//   Retrieve the minor (root) diameter in mm of the threads of a self tapping screw given the size.
// Usage:
//   unf_stpMinorDiameter(size_or_vector)
// Arguments:
//   in = size as a string or the unf_stpV() vector itself
function unf_stpMinorDiameter(in) = is_list(in) ? in[8] : (
	unf_stpLookup(in,
						[[1.5, 0.91], // ISO 1478
						 [1.9, 1.24],
						 [2.2, 1.63],
						 [2.6, 1.90],
						 [2.9, 2.18],
						 [3.3, 2.39],
						 [3.5, 2.64],
						 [3.9, 2.92],
						 [4.2, 3.10],
						 [4.8, 3.58],
						 [5.5, 4.17],
						 [6.3, 4.88],
						 [8, 6.20],
						 [9.5, 7.85]],
						unf_stpInch(
							[[0.086, 0.064], // #2
							 [0.112, 0.081], // #4
							 [0.138, 0.095], // #6
							 [0.164, 0.110], // #8
							 [0.190, 0.123], // #10
							 [0.216, 0.148], // #12
							 [0.242, 0.171], // #14
							 [0.3125, 0.232], // 5/16"
							 [0.375, 0.287]])) // 3/8"
);

// Function: unf_stpClearanceDiameter
// Synopsis: Self Tapping Screw Clearance Hole Diameter
// Description:
//   Retrieve the diameter in mm of a hole a self tapping screw will slide through without the threads biting, given the size.
// Usage:
//   unf_stpClearanceDiameter(size_or_vector)
// Arguments:
//   in = size as a string or the unf_stpV() vector itself
function unf_stpClearanceDiameter(in) = is_list(in) ? in[9] : (
	unf_stpLookup(in,
						[[1.6, 1.7], // ISO 273 fine
						 [2, 2.2],
						 [2.5, 2.7],
						 [3, 3.2],
						 [3.5, 3.7],
						 [4, 4.3],
						 [5, 5.3],
						 [6, 6.4],
						 [8, 8.4],
						 [10, 10.5],
						 [12, 13]],
						unf_stpInch(
							[[0.086, 0.094], // #2, ASME close fit
							 [0.112, 0.120], // #4
							 [0.138, 0.145], // #6
							 [0.164, 0.171], // #8
							 [0.190, 0.196], // #10
							 [0.216, 0.221], // #12
							 [0.25, 0.257], // 1/4"
							 [0.3125, 0.323], // 5/16"
							 [0.375, 0.386]])) // 3/8"
);

// Function: unf_stpPitch
// Synopsis: Self Tapping Screw Thread Pitch
// Description:
//   Retrieve the thread pitch in mm of a self tapping screw given the size. Used to leave room for the tip of the screw at the bottom of a pilot hole.
// Usage:
//   unf_stpPitch(size_or_vector)
// Arguments:
//   in = size as a string or the unf_stpV() vector itself
function unf_stpPitch(in) = is_list(in) ? in[10] : (
	unf_stpLookup(in,
						[[1.5, 0.5], // ISO 1478
						 [1.9, 0.6],
						 [2.2, 0.8],
						 [2.6, 0.9],
						 [2.9, 1.1],
						 [3.3, 1.3],
						 [3.5, 1.3],
						 [3.9, 1.3],
						 [4.2, 1.4],
						 [4.8, 1.6],
						 [5.5, 1.8],
						 [6.3, 1.8],
						 [8, 2.1],
						 [9.5, 2.1]],
						unf_stpInch(
							[[0.086, 1/32], // #2
							 [0.112, 1/24], // #4
							 [0.138, 1/20], // #6
							 [0.164, 1/18], // #8
							 [0.190, 1/16], // #10
							 [0.216, 1/14], // #12
							 [0.242, 1/14], // #14
							 [0.3125, 1/12], // 5/16"
							 [0.375, 1/12]])) // 3/8"
);

// Function: unf_stpEngagement
// Synopsis: Self Tapping Screw Recommended Engagement
// Description:
//   Retrieve a recommended depth in mm of thread engagement into plastic, twice the thread diameter. Useful as a minimum depth for a pilot hole or boss.
// Usage:
//   unf_stpEngagement(size_or_vector)
// Arguments:
//   in = size as a string or the unf_stpV() vector itself
function unf_stpEngagement(in) = 2 * unf_fnrShaftDiameter(in);

// Function: unf_defaultNozzle
// Synopsis: Printer Nozzle Diameter
// Description:
//   Returns $unf_nozzle if it is set, otherwise 0.4.
// Usage:
//   unf_defaultNozzle()
function unf_defaultNozzle() = is_undef($unf_nozzle) ? 0.4 : $unf_nozzle;

// Function: unf_stpDefaultPilotId
// Synopsis: Default Star Pilot Inner Diameter Percentage
// Description:
//   Returns $unf_stpPilotId if it is set, otherwise 0, the root of the threads.
// Usage:
//   unf_stpDefaultPilotId()
function unf_stpDefaultPilotId() = is_undef($unf_stpPilotId) ? 0 : $unf_stpPilotId;

// Function: unf_stpDefaultPilotOd
// Synopsis: Default Star Pilot Outer Diameter Percentage
// Description:
//   Returns $unf_stpPilotOd if it is set, otherwise 50, half way up the threads.
// Usage:
//   unf_stpDefaultPilotOd()
function unf_stpDefaultPilotOd() = is_undef($unf_stpPilotOd) ? 50 : $unf_stpPilotOd;

// Function: unf_stpPilotId
// Synopsis: Self Tapping Screw Star Pilot Inner Diameter
// Description:
//   Retrieve the inner diameter in mm, the dips between the points, of a star shaped pilot hole.
// Usage:
//   unf_stpPilotId(size_or_vector, [id_percent])
// Arguments:
//   in = size as a string or the unf_stpV() vector itself
//   id_percent = percentage of the thread depth above the minor diameter ($unf_stpPilotId)
function unf_stpPilotId(in, id_percent=unf_stpDefaultPilotId()) = let (minor = unf_stpMinorDiameter(in)) (
	unf_round(place=-3, num=minor + ((unf_fnrShaftDiameter(in) - minor) * id_percent / 100))
);

// Function: unf_stpPilotOd
// Synopsis: Self Tapping Screw Star Pilot Outer Diameter
// Description:
//   Retrieve the outer diameter in mm, the points, of a star shaped pilot hole.
// Usage:
//   unf_stpPilotOd(size_or_vector, [od_percent])
// Arguments:
//   in = size as a string or the unf_stpV() vector itself
//   od_percent = percentage of the thread depth above the minor diameter ($unf_stpPilotOd)
function unf_stpPilotOd(in, od_percent=unf_stpDefaultPilotOd()) = unf_stpPilotId(in, od_percent);

// Function: unf_stpPilotDiameter
// Synopsis: Self Tapping Screw Round Pilot Diameter
// Description:
//   Retrieve the diameter in mm of a round pilot hole, the average of the star inner and outer diameters.
// Usage:
//   unf_stpPilotDiameter(size_or_vector, [id_percent], [od_percent])
// Arguments:
//   in = size as a string or the unf_stpV() vector itself
//   id_percent = star inner diameter as a percentage of the thread depth above the minor diameter ($unf_stpPilotId)
//   od_percent = star outer diameter as a percentage of the thread depth above the minor diameter ($unf_stpPilotOd)
function unf_stpPilotDiameter(in, id_percent=unf_stpDefaultPilotId(), od_percent=unf_stpDefaultPilotOd()) = unf_stpPilotId(in, (id_percent + od_percent) / 2);

// Function: unf_stpStarPoints
// Synopsis: Self Tapping Screw Star Pilot Point Count
// Description:
//   Retrieve the number of points for a star shaped pilot hole. Points are spaced at least 2.5 nozzle widths apart around the outer diameter so they don't just print smooth. Never less than 3.
// Usage:
//   unf_stpStarPoints(size_or_vector, [od_percent])
// Arguments:
//   in = size as a string or the unf_stpV() vector itself
//   od_percent = star outer diameter as a percentage of the thread depth above the minor diameter ($unf_stpPilotOd)
//   ---
//   $unf_nozzle = printer nozzle diameter in mm
function unf_stpStarPoints(in, od_percent=unf_stpDefaultPilotOd()) = max(3, floor(PI * unf_stpPilotOd(in, od_percent) / (2.5 * unf_defaultNozzle())));

// Module: unf_stpPilot
// Synopsis: Self Tapping Screw Pilot Hole
// Description:
//   Render a negative for the pilot hole a self tapping screw threads into. The hole starts at the origin and goes up along the z axis.
// Figure(Spin;VPD=30; VPT=[0, 0, 3];  NoAxes): note - the ext area is semi-transparent.
//   $fn = 36;
//   $unf_over = 0.1;
//   $unf_wall=2;
//   $unf_nozzle = 0.4;
//   $unf_stpPilotId = 0;
//   $unf_stpPilotOd = 50;
//   use <unfy_fasteners.scad>;
//   unf_stpPilot(size="m3", ext=1);
// Usage:
//   unf_stpPilot(size, length, star, chamfer, tip, ext, id_percent, od_percent, body_color)
// Arguments:
//   size = string representing the size or the unf_stpV() vector.
//   length = depth in mm of thread engagement, defaults to unf_stpEngagement()
//   star = true/false, star shaped or round pilot hole
//   chamfer = true/false, chamfer the mouth of the hole out to the thread diameter so the plastic doesn't bulge up around the screw
//   tip = true/false, deepen the hole by two thread pitches to leave room for the tip of the screw
//   ext = length in mm to extend the hole above the origin
//   id_percent = star inner diameter as a percentage of the thread depth above the minor diameter ($unf_stpPilotId)
//   od_percent = star outer diameter as a percentage of the thread depth above the minor diameter ($unf_stpPilotOd)
//   body_color = color of the cut surfaces
//   ---
//   $unf_nozzle = printer nozzle diameter in mm, sets the spacing of the star points
//   $unf_stpPilotId = default for id_percent
//   $unf_stpPilotOd = default for od_percent
module unf_stpPilot(size="m3", length=-1, star=true, chamfer=true, tip=true, ext=-1, id_percent=unf_stpDefaultPilotId(), od_percent=unf_stpDefaultPilotOd(), body_color="Yellow"){
	assert(id_percent <= od_percent, "id_percent must not exceed od_percent");
	let (size = is_list(size) ? size : unf_stpV(size),
		  length = 0 < length ? length : unf_stpEngagement(size),
		  ext = (0 <= ext) ? ext : $unf_over,
		  depth = length + (tip ? 2 * unf_stpPitch(size) : 0),
		  thread_d = unf_fnrShaftDiameter(size),
		  id = unf_stpPilotId(size, id_percent),
		  od = unf_stpPilotOd(size, od_percent),
		  round_d = unf_stpPilotDiameter(size, id_percent, od_percent),
		  mouth_d = chamfer ? thread_d : (star ? od : round_d)){
		color(body_color){
			if (star && id < od){
				linear_extrude(depth){
					unf_star(od=od, id=id, p=unf_stpStarPoints(size, od_percent));
				}
			} else {
				cylinder(h=depth, d=round_d);
			}
			if (chamfer){
				cylinder(h=(thread_d - id) / 2, d1=thread_d, d2=id);
			}
			if (0 < ext){
				translate([0, 0, -ext]){
					color("grey", 0.25){
						cylinder(h=ext, d=mouth_d);
					}
				}
			}
		}
	}
}

// Module: unf_stp
// Synopsis: Self Tapping Screw
// Description:
//   Render a negative for a head recess, clearance hole and optionally a pilot hole for a self tapping screw. Like the bolts, the head sits at the origin and the shaft goes up along the z axis for length beyond the head. The first clearance_length of that is a clearance hole for the part being clamped, the rest is a pilot hole for the part being screwed into. Leave clearance_length at -1 for a clearance hole all the way through.
// Figure(Spin;VPD=50; VPT=[0, 0, 5];  NoAxes): Pan head, star pilot. note - the head_ext area is semi-transparent.
//   $fn = 36;
//   $unf_over = 0.1;
//   $unf_wall=2;
//   $unf_hdistX = 80;
//   $unf_hdistY = 10;
//   $unf_nozzle = 0.4;
//   $unf_stpPilotId = 0;
//   $unf_stpPilotOd = 50;
//   use <unfy_fasteners.scad>;
//   unf_stp(size="m3", head="pan", length=12, clearance_length=4, head_ext=2);
// Figure(Spin;VPD=50; VPT=[0, 0, 5];  NoAxes): Countersunk head, round pilot. note - the head_ext area is semi-transparent.
//   $fn = 36;
//   $unf_over = 0.1;
//   $unf_wall=2;
//   $unf_hdistX = 80;
//   $unf_hdistY = 10;
//   $unf_nozzle = 0.4;
//   $unf_stpPilotId = 0;
//   $unf_stpPilotOd = 50;
//   use <unfy_fasteners.scad>;
//   unf_stp(size="m3", head="csk", length=12, clearance_length=4, head_ext=2, star=false);
// Usage:
//   unf_stp(size, head, length, clearance_length, head_ext, star, chamfer, tip, distorted, id_percent, od_percent, body_color)
// Arguments:
//   size = string representing the size or the unf_stpV() vector.
//   head = head style, ignored if size is a vector ("pan")
//   length = length in mm beyond the head
//   clearance_length = length in mm of clearance hole before the pilot hole begins, -1 for no pilot hole
//   head_ext = length in mm to recess the head beyond just it's thickness
//   star = true/false, star shaped or round pilot hole
//   chamfer = true/false, chamfer the mouth of the pilot hole
//   tip = true/false, deepen the pilot hole by two thread pitches to leave room for the tip of the screw
//   distorted = true/false, should the clearance hole be distorted, the pilot hole never is
//   id_percent = star inner diameter as a percentage of the thread depth above the minor diameter ($unf_stpPilotId)
//   od_percent = star outer diameter as a percentage of the thread depth above the minor diameter ($unf_stpPilotOd)
//   body_color = color in which to render the screw if rendered as a positive, color of the cut surfaces if rendering as a negative.
//   ---
//   $unf_hdistX = width of distortion as a percentage of the diameter (0-100)
//   $unf_hdistY = height of distortion as a percentage of the diameter (0-100)
//   $unf_nozzle = printer nozzle diameter in mm, sets the spacing of the star points
//   $unf_stpPilotId = default for id_percent
//   $unf_stpPilotOd = default for od_percent
module unf_stp(size="m3", head="pan", length=-1, clearance_length=-1, head_ext=-1, star=true, chamfer=true, tip=true, distorted=false, id_percent=unf_stpDefaultPilotId(), od_percent=unf_stpDefaultPilotOd(), body_color="Yellow"){
	color(body_color){
		let (head_ext = (0 <= head_ext) ? head_ext : $unf_over,
			  size = is_list(size) ? size : unf_stpV(size, head),
			  length = 0 < length ? length : unf_stpDefaultLength(size),
			  clearance_length = (0 <= clearance_length && clearance_length < length) ? clearance_length : length){
			head_d = unf_stpHeadDiameter(size);
			head_height = unf_stpHeadHeight(size);
			thread_d = unf_fnrShaftDiameter(size);
			if (0 < head_ext){
				translate([0, 0, -head_ext]){
					color("grey", 0.25){
						cylinder(h = head_ext, d = head_d);
					}
				}
			}
			if ("cone" == unf_stpHeadShape(size)){
				cylinder(h = head_height, d1 = head_d, d2 = thread_d);
			} else {
				cylinder(h = head_height, d = head_d);
			}
			unf_shaft(length = head_height + clearance_length, diameter = unf_stpClearanceDiameter(size), distorted = distorted);
			if (clearance_length < length){
				translate([0, 0, head_height + clearance_length]){
					unf_stpPilot(size=size, length=length-clearance_length, star=star, chamfer=chamfer, tip=tip, ext=0, id_percent=id_percent, od_percent=od_percent);
				}
			}
		}
	}
}

// Section: Heatset Inserts - unf_hst*
//   The vector representing a heatset insert will contain, in order:
//   * name
//   * shaft_diameter
//   * insert_diameter
//   * length
//   .
//   note - these are pilot hole dimensions, not dimensions of the actual insert

// Function: unf_hstV
// Synopsis: Heatset Insert Vector
// Description:
//   Retrieve a vector representing the dimensions of a heatset insert given the size. Will return the passed parameter if passed a vector. Thus sizes and dimension vectors may be treated interchangably.
// Usage:
//   unf_hstV(size_or_vector)
// Arguments:
//   size = size as a string or the vector itself
function unf_hstV(size="m3", length="medium", opening_taper_percent=10) = is_list(size) ? size : (
	let (length=unf_stToLower(length)) (
		["HST", //0
		 unf_fnrSize(size), //1
		 unf_hstDiameter(size)+(unf_hstDiameter(size)*opening_taper_percent/100), //2
		 unf_fnrShaftDiameter(size), //3
		 opening_taper_percent, //4
		 unf_hstDiameter(size), //5
		 unf_hstLength(size, length)] //6
	)
);
  
// Function: unf_hstDiameter
// Synopsis: Heatset Insert Diameter
// Description:
//   Retrieve the diameter in mm of the hole for a heatset insert given the size.
// Usage:
//   unf_hstDiameter(size_or_vector)
// Arguments:
//   size = size as a string or the unf_hstV() vector itself
function unf_hstDiameter(in="m3") = is_list(in) ? in[5] : (
	unf_fnrIsSt(in) ? unf_hstDiameter(unf_fnrStToM(in)) :
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
			unf_hstDiameter(str("M", 25.4*unf_stToNum(unf_sub(in, 0, len(in)-1))))
		) : (
			"#0000" == in ? unf_hstDiameter(str("M", unf_fnrShaftDiameter(in))) : ( // No Data
				"#000" == in ? unf_hstDiameter(str("M", unf_fnrShaftDiameter(in))) : ( // No Data
					"#00" == in ? unf_hstDiameter(str("M", unf_fnrShaftDiameter(in))) : ( // No Data
						"#" != in[0] ? unf_hstDiameter("M3") : (
							unf_round(place=-3,
										 num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
															 [[0, unf_hstDiameter(str("M", unf_fnrShaftDiameter("#0")))], // No Data
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

// Function: unf_hstLength
// Synopsis: Heatset Insert Length
// Description:
//   Retrieve the length in mm of the hole for a heatset insert given the size.
// Usage:
//   unf_hstLength(size_or_vector, [length])
// Arguments:
//   size = size as a string or the unf_hstV() vector itself
//   length = "small", "medium" or "large", or a number to just return that number ("medium")
function unf_hstLength(size="m3", length="medium") = is_num(length) ? length : (
	let (length = unf_stToLower(length)) (
		is_list(size) ? size[6] : (
			unf_fnrIsSt(size) ? unf_hstLength(unf_fnrStToM(size), length) :
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
					unf_hstLength(str("M", 25.4*unf_stToNum(unf_sub(size, 0, len(size)-1))), length) // No Data
				) : (
					"#0000" == size ? unf_hstLength(str("M", unf_fnrShaftDiameter(size)), length) : ( // No Data
						"#000" == size ? unf_hstLength(str("M", unf_fnrShaftDiameter(size)), length) : ( // No Data
							"#00" == size ? unf_hstLength(str("M", unf_fnrShaftDiameter(size)), length) : ( // No Data
								"#" != size[0] ? unf_hstLength("M3", length) : (
									// Only medium lengths are known, small and large are scaled by the metric ratio to medium at the same diameter
									let (metric = str("M", unf_fnrShaftDiameter(size)),
										  scale = "medium" == length ? 1 : unf_hstLength(metric, length) / unf_hstLength(metric, "medium"))
									unf_round(place=-3,
												 num=scale * unf_lookup(unf_stToNum(unf_sub(size, 1)),
																	 [[0, unf_hstLength(str("M", unf_fnrShaftDiameter("#0")), length="medium")], // No Data
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
// Synopsis: Heatset Insert
// Description:
//   Render a negative for a heatset-insert hole.
// Figure(Spin;VPD=30; VPT=[0, 0, -2];  NoAxes): note - the head_ext, extra_room and bolt shaft areas are semi-transparent.
//   $fn = 36;
//   $unf_over = 0.1;
//   $unf_wall=2;
//   $unf_hdistX = 80;
//   $unf_hdistY = 10;
//   use <unfy_fasteners.scad>;
//   rotate([0, 180, 0]){
//      unf_hst(size="m3", opening_taper_percent=10, length="medium", head_ext=2, extra_room=2, bolt_hole_depth=5);
//   }
// Usage:
//   unf_hst(size, opening_taper_percent, length, head_ext, extra_room, bolt_hole_depth, body_color)
// Arguments:
//   size = string representing the size or the unf_hstV() vector.
//   opening_taper_percent = enlarge the opening with a taper for ease of insertion.
//   length = Heatset inserts for the same bolt size do come in a variety of lenghts. Fortunately, because when using them one is melting into the plastic it is not necessary to be 100% accurate. For this field use one of small, medium or large to get holes for smaller to larger heatset inserts respectively.
//   head_ext = length in mm to recess the head beyond just it's thickness
//   extra_room = Continue the hole, at the inserts outer dimension a bit farther into the part. This creates a space for molten plastic to flow to when inserting the insert.
//   bolt_hole_depth = Extend the hole at the width of the bolt, not the width of the insert beyond the insert to make room for the bolt to pass through the insert and deeper into the hole.
//   body_color = color in which to render the insert if rendered as a positive, color of the cut surfaces if rendering as a negative.
module unf_hst(size="m3", opening_taper_percent=10, length="medium", head_ext=-1, extra_room=true, bolt_hole_depth=0, body_color="Yellow"){
	let (
		length = unf_stToLower(length),
		size = is_list(size) ? size : unf_hstV(size=size, length=length)){
		let (
			bolt_diameter = unf_fnrShaftDiameter(size),
			opening_diameter = unf_fnrDiameter(size),
			diameter = unf_hstDiameter(size),
			length = unf_hstLength(size=size, length=length),
			head_ext = (0 <= head_ext) ? head_ext : $unf_over
		) {
			//main body
			color(body_color){
				cylinder(h=length, d1=opening_diameter, d2=diameter);
			}
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
					color("gray", 0.25){
						cylinder(d1=diameter, d2=(1-er)*diameter, h=er*diameter);
					}
				} 
			}
			//bolt hole
			if (0 < bolt_hole_depth){
				translate([0, 0, length]){
					color("gray", 0.25){
						cylinder(d=bolt_diameter, h=bolt_hole_depth);
					}
				}
			}
		}
	}
}

// Section: Hex Nut - unf_nut*
//   The vector representing a hex nut will contain, in order:
//   * name
//   * nut_diameter
//   * height

// Function: unf_nutV
// Synopsis: hex-nut vector
// Description:
//   Retrieve a vector representing the dimensions of a hex-nut bolt given the size. Will return the passed parameter if passed a vector. Thus sizes and dimension vectors may be treated interchangably.
// Usage:
//   unf_nutV(size_or_vector)
// Arguments:
//   size = size as a string or the vector itself
function unf_nutV(size) = is_list(size) ? size : [
	"NUT", //0
	unf_fnrSize(size), //1
	unf_nutDiameter(size), //2
	unf_fnrShaftDiameter(size), //3
	unf_nutHeight(size), //4
	unf_nutSmallD(size) //5
];

// Function: unf_nutDiameter
// Synopsis: Hex Nut Clearance Diameter
// Description:
//   Takes a fastener size or a hex nut vector and returns the clearance diameter
// Usage:
//   unf_nutDiameter(size)
// Arguments
//   size = fastener size string or vector representing an unfy_nut (hex nut)
function unf_nutDiameter(in) = is_list(in) ? in[2] : (
	unf_fnrIsSt(in) ? unf_nutDiameter(unf_fnrStToM(in)) :
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
			"#0000" == in ? unf_nutDiameter(str("M", unf_fnrShaftDiameter(in))) : ( // No Data
				"#000" == in ? unf_nutDiameter(str("M", unf_fnrShaftDiameter(in))) : ( // No Data
					"#00" == in ? unf_nutDiameter(str("M", unf_fnrShaftDiameter(in))) : ( // No Data
						"#" != in[0] ? unf_nutDiameter("M3") : (
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

// Function: unf_nutSmallD
// Synopsis: Hex Nut distance across flats
// Description:
//   Retrieve the distance across flats of a typical hex nut given the bolt size.
// Usage:
//   unf_nutSmallD(size_or_vector)
// Arguments:
//   size = size as a string or the unf_nutV() vector itself
function unf_nutSmallD(in) = is_list(in) ? in[5] : (unf_nutDiameter(in) * cos(30));

// Function: unf_nutHeight
// Synopsis: Hex Nut Height
// Description:
//   Retrieve the height (thickness) of a typical hex nut given the bolt size.
// Usage:
//   unf_nutHeight(size_or_vector)
// Arguments:
//   size = size as a string or the unf_nutV() vector itself
function unf_nutHeight(in) = is_list(in) ? in[4] : (
	unf_fnrIsSt(in) ? unf_nutHeight(unf_fnrStToM(in)) :
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
			"#0000" == in ? unf_nutHeight(str("M", unf_fnrShaftDiameter(in))) : ( // No Data
				"#000" == in ? unf_nutHeight(str("M", unf_fnrShaftDiameter(in))) : ( // No Data
					"#00" == in ? unf_nutHeight(str("M", unf_fnrShaftDiameter(in))) : ( // No Data
						"#" != in[0] ? unf_nutHeight("M3") : (
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

// Module: unf_nut
// Synopsis: Hex Nut
// Description:
//   Render a negative for a hex nut hole.
// Figure(Spin;VPD=30; VPT=[0, 0, -2];  NoAxes): note - the ext area is semi-transparent.
//   $fn = 36;
//   $unf_over = 0.1;
//   $unf_wall=2;
//   use <unfy_fasteners.scad>;
//   rotate([0, 180, 0]){
//      unf_nut(size="m5", ext=1);
//   }
// Usage:
//   unf_nut(size, ext, body_color)
// Arguments:
//   size = string representing the size or the unf_nutV() vector.
//   ext = length in mm to recess the nut beyond just it's thickness
//   body_color = color in which to render the nut if rendered as a positive, color of the cut surfaces if rendering as a negative.
module unf_nut(size = "m3", ext = -1, body_color="Yellow"){
	let (ext = (0 <= ext) ? ext : $unf_over,
		  size = is_list(size) ? size : unf_nutV(size),
		  diameter = unf_nutDiameter(size),
		  height = unf_nutHeight(size)){
		if (0 < ext){
			translate([0, 0, -ext]){
				color("grey", 0.25){
					cylinder(h=ext, d=diameter, $fn=6);
				}
			}
		}
		color(body_color){
			cylinder(h=height, d=diameter, $fn=6);
		}
	}
}

// Section: Square Nut - unf_sqr*
//   The vector representing a square nut shall contain, in order:
//   * name
//   * size
//   * diagonal (widest part)
//   * shaft_diameter
//   * height
//   * side_length

// Function: unf_sqrV
// Synopsis: Square Nut Vector
// Description:
//   Retrieve a vector representing the dimensions of a square nut given the size. Will return the passed parameter if passed a vector. Thus sizes and dimension vectors may be treated interchangably.
// Usage:
//   unf_sqrV(size_or_vector)
// Arguments:
//   size = size as a string or the vector itself
function unf_sqrV(size) = is_list(size) ? size : [
	"SQR", //0
	unf_fnrSize(size), //1
	unf_sqrLength(size) * sqrt(2), //2
	unf_fnrShaftDiameter(size), //3
	unf_sqrHeight(size), //4
	unf_sqrLength(size) //5
];

// Function: unf_sqrLength
// Synopsis: Square Nut Side Length
// Description:
//   Retrieve the length of a side of a square nut.
// Usage:
//   unf_sqrLength(size_or_vector)
// Arguments:
//   size = size as a string or the unf_sqrV() vector itself
function unf_sqrLength(in) = is_list(in) ? in[5] : (
	unf_fnrIsSt(in) ? unf_sqrLength(unf_fnrStToM(in)) :
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
			"#0000" == in ? unf_sqrLength(str("M", unf_fnrShaftDiameter(in))) : ( // No Data
				"#000" == in ? unf_sqrLength(str("M", unf_fnrShaftDiameter(in))) : ( // No Data
					"#00" == in ? unf_sqrLength(str("M", unf_fnrShaftDiameter(in))) : ( // No Data
						"#" != in[0] ? unf_sqrLength("M3") : (
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

// Function: unf_sqrHeight
// Synopsis: Square Nut Height / Thickness
// Description:
//   Retrieve the thickness of a square nut, it's height when lying flat.
// Usage:
//   unf_sqrHeight(size_or_vector)
// Arguments:
//   size = size as a string or the unf_sqrV() vector itself
function unf_sqrHeight(in) = is_list(in) ? in[4] : (
	unf_fnrIsSt(in) ? unf_sqrHeight(unf_fnrStToM(in)) :
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
			"#0000" == in ? unf_sqrHeight(str("M", unf_fnrShaftDiameter(in))) : ( // No Data
				"#000" == in ? unf_sqrHeight(str("M", unf_fnrShaftDiameter(in))) : ( // No Data
					"#00" == in ? unf_sqrHeight(str("M", unf_fnrShaftDiameter(in))) : ( // No Data
						"#" != in[0] ? unf_sqrHeight("M3") : (
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

// Module: unf_sqr
// Synopsis: Square Nut
// Description:
//   Render a negative for a square shaped nut
// Figure(Spin;VPD=40; VPT=[0, 0, 2]; NoAxes): note - the ext area is semi-transparent.
//   $fn = 36;
//   $unf_over = 0.1;
//   $unf_wall=2;
//   use <unfy_fasteners.scad>;
//   unf_sqr(size="m6", ext=0.5);
// Usage:
//   unf_sqr(size, ext, body_color)
// Arguments:
//   size = string representing the size or the unf_sqrV() vector.
//   ext = Extra height added to the negative for recessing the nut.
//   body_color = color in which to render the nut if rendered as a positive, color of the cut surfaces if rendering as a negative.
module unf_sqr(size = "m3", ext = -1, body_color="Yellow"){
	let (ext = (0 <= ext) ? ext : $unf_over,
		  size = is_list(size) ? size : unf_sqrV(size)){
		length = unf_sqrLength(size);
		height = unf_sqrHeight(size);
		translate([-length/2, -length/2, 0]){
			if (0 < ext){
				translate([0, 0, -ext]){
					color("grey", 0.25){
						cube([length, length, ext]);
					}
				}
			}
			color(body_color){
				cube([length, length, height]);
			}
		}
	}
}

// Section: Washer unf_wsh*
//   The vector representing a washer will consist of, in order:
//   * name
//   * washer_diameter
//   * height


// Function: unf_wshV
// Synopsis: Washer Vector
// Description:
//   Retrieve a vector representing the dimensions of a washer given the size. Will return the passed parameter if passed a vector. Thus sizes and dimension vectors may be treated interchangably.
// Usage:
//   unf_wshV(size_or_vector)
// Arguments:
//   size = size as a string or the vector itself
function unf_wshV(size) = is_list(size) ? size : [
	"WSH",
	unf_fnrSize(size),
	unf_wshDiameter(size),
	unf_fnrShaftDiameter(size),
	unf_wshDiameter(size),
	unf_wshHeight(size)
];

// Function: unf_wshDiameter
// Synopsis: Washer Clearance Diameter
// Description:
//   Retrieve the outer diameter in mm of a washer given the bolt size.
// Usage:
//   unf_wshDiameter(size_or_vector)
// Arguments:
//   size = size as a string or the unf_wshV() vector itself
function unf_wshDiameter(in) = is_list(in) ? in[4] : (
	unf_fnrIsSt(in) ? unf_wshDiameter(unf_fnrStToM(in)) :
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
			"#0000" == in ? unf_wshDiameter(str("M", unf_fnrShaftDiameter(in))) : ( // No Data
				"#000" == in ? unf_wshDiameter(str("M", unf_fnrShaftDiameter(in))) : ( // No Data
					"#00" == in ? unf_wshDiameter(str("M", unf_fnrShaftDiameter(in))) : ( // No Data
						"#" != in[0] ? unf_wshDiameter("M3") : (
							unf_round(place=-3,
										 num=unf_lookup(unf_stToNum(unf_sub(in, 1)),
															 [[0, unf_wshDiameter(str("M", unf_fnrShaftDiameter("#0")))],
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


// Function: unf_wshHeight
// Synopsis: Washer Thickness (height lying flat)
// Description:
//   Retrieve the height or thickness in mm of a washer given the bolt size.
// Usage:
//   unf_wshHeight(size_or_vector)
// Arguments:
//   size = size as a string or the unf_wshV() vector itself
function unf_wshHeight(in) = is_list(in) ? in[5] : (
	unf_fnrIsSt(in) ? unf_wshHeight(unf_fnrStToM(in)) :
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
						"#" != in[0] ? unf_wshHeight("M3") : (
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

// Module: unf_wsh
// Synopsis: Washer
// Description:
//   Render a negative for a washer. Does not include a bolt hole since it is only meant to be a negative for recessing a vitamin, not an actual printed washer.
// Figure(Spin;VPD=50; VPT=[0, 0, 5];  NoAxes): note - the head_ext area is semi-transparent.
//   $fn = 36;
//   $unf_over = 0.1;
//   use <unfy_fasteners.scad>;
//   unf_wsh(size="m3", ext=0.2);
// Usage:
//   unf_wsh(size, ext, body_color)
// Arguments:
//   size = string representing the size or the unf_wshV() vector.
//   ext = length in mm to recess the washer beyond just it's thickness
//   body_color = color in which to render the washer if rendered as a positive, color of the cut surfaces if rendering as a negative.
module unf_wsh(size = "m3", ext = -1, body_color="Yellow"){
	let (ext = (0 <= ext) ? ext : $unf_over,
		  size = is_list(size) ? size : unf_wshV(size)){
		diameter = unf_wshDiameter(size);
		height = unf_wshHeight(size);
		if (0 < ext){
			translate([0, 0, -ext]){
				color("grey", 0.25){
					cylinder(h=ext, d=diameter);
				}
			}
		}
		color(body_color){
			cylinder(h=height, d=diameter);
		}
	}
}


// Section: Pillar

// Module: unf_pillarPos
// Synopsis: Render the positive part of a fastener pillar
// Description:
//   *Still under Construction* Calculates the diameter needed for a support pillar that will contain a heatset insert or a nut. Then render the positive part of the pillar.
// Figure(Spin; VPD=50; VPT=[0, 0, 5]; NoAxes):
//   $fn = 36;
//   $unf_over = 0.1;
//   $unf_wall = 2;
//   use <unfy_fasteners.scad>;
//   unf_pillarPos(fastener="Heatset", bolt="M3", heatset_length="Medium", length=5, slope=45, wall=1.5);
// Usage:
//   unf_pillarPos(fastener, bolt, heatset_length, length, slope, wall, body_color)
// Arguments:
//   fastener = A string representing the type of fastener that will be contained within the pillar. One of "heatset" or "hexnut". Future support will be added for "squarenut".
//   bolt = A string representing the bolt size.
//   heatset_length = One of "small", "medium" or "large" used only with a heatset insert.
//   length = length in mm of the pillar
//   slope = slope in degrees leading from bottom to top of the pillar. *note - future version will use a bezier curve, likely replacing this argument.*
//   wall = Minimum material thickness between heatset or nut insert and the outside of the pillar.
//   body_color = color in which to render the pillar.
module unf_pillarPos(fastener="Heatset", bolt="M3", heatset_length="Medium", length=5, slope=45, wall=1, body_color="Yellow"){
	let(fastener = unf_stToLower(fastener)){
		if ("hexnut" == fastener){
			let (nut_v = unf_nutV(bolt),
				  nut_diameter = unf_nutDiameter(nut_v),
				  nut_height = unf_nutHeight(nut_v),
				  top_d=(2*wall)+nut_diameter,
				  bottom_d = top_d+(2*length*tan(slope))
			){
				color(body_color){
					cylinder(d1=bottom_d, d2=top_d, h=length);
				}
			}
		}	
		else if ("heatset" == fastener){
			let(fastener = unf_hstV(size=bolt, length=heatset_length),
				 hst_diameter = unf_hstDiameter(fastener),
				 hst_length = unf_hstLength(fastener, length=heatset_length),
				 length = (wall+hst_length)>length ? (wall+hst_length) : length,
				 top_d=(2*wall)+hst_diameter,
				 bottom_d = top_d+(2*length*tan(slope))
			){
				color(body_color){
					cylinder(d1=bottom_d, d2=top_d, h=length);
				}
			}
		}			
	}
}


// Module: unf_pillarNeg
// Synopsis: Render the negative part of a fastener pillar
// Description:
//   *Still under Construction* Render that which should be subtracted from a pillar so that fasteners may be added.
// Figure(Spin; VPD=50; VPT=[0, 0, 5]; NoAxes): Heatset Insert
//   $fn = 36;
//   $unf_over = 0.1;
//   $unf_wall = 2;
//   use <unfy_fasteners.scad>;
//   unf_pillarNeg(fastener="Heatset", bolt="M3", heatset_length="Medium", length=5, wall=1.5, ext=0.33);
// Figure(Spin; VPD=50; VPT=[0, 0, 5]; NoAxes): Hexnut
//   $fn = 36;
//   $unf_over = 0.1;
//   $unf_wall = 2;
//   use <unfy_fasteners.scad>;
//   unf_pillarNeg(fastener="Hexnut", bolt="M3", heatset_length="Medium", length=5, wall=1.5, ext=0.33);
// Usage:
//   unf_pillarNeg(fastener, bolt, length, heatset_length, wall, ext, body_color)
// Arguments:
//   fastener = A string representing the type of fastener that will be contained within the pillar. One of "heatset" or "hexnut". Future support will be added for "squarenut".
//   bolt = A string representing the bolt size.
//   length = length in mm of the pillar
//   heatset_length = One of "small", "medium" or "large" used only with a heatset insert.
//   wall = Minimum material thickness between heatset or nut insert and the outside of the pillar.
//   ext = length in mm to recess the fastener beyond just it's length
//   body_color = color in which to render if rendered as a positive, color of the cut surfaces if rendering as a negative.
module unf_pillarNeg(fastener="Heatset", bolt="M3", length=5, heatset_length="Medium", wall=1, ext=2, body_color="Yellow"){
	let(fastener = unf_stToLower(fastener)){

		if ("hexnut" == fastener){
			let (nut_v = unf_nutV(bolt),
				  nut_diameter = unf_nutDiameter(nut_v),
				  nut_height = unf_nutHeight(nut_v)
			){
				translate([0, 0, length+$unf_over]){
					rotate([0, 180, 0]){
						unf_nut(size=nut_v, ext=$unf_over, body_color=body_color);
					}
				}
				translate([0, 0, -ext]){
					color(body_color){
						cylinder(d=unf_fnrShaftDiameter(bolt), h=$unf_over+ext+length);
					}
				}
			}
		}

		else if ("heatset" == fastener){
			let(fastener = unf_hstV(size=bolt, length=heatset_length),
				 hst_diameter = unf_hstDiameter(fastener),
				 hst_length = unf_hstLength(fastener, length=heatset_length),
				 length = (wall+hst_length)>length ? (wall+hst_length) : length
			){
				translate([0, 0, length]){
					rotate([0, 180, 0]){
						unf_hst(size=fastener, length=heatset_length, bolt_hole_depth=length-hst_length+$unf_over, body_color=body_color);
					}
				}
			}      
		}
    
	}
}

// Module: unf_pillar
// Synopsis: Render a fastener pillar
// Description:
//   *Still under Construction* Render a pillar which will contain a heatset insert or nut and a bolt hole.
// Figure(Spin; VPD=50; VPT=[0, 0, 5]; NoAxes): Heatset Insert
//   $fn = 36;
//   $unf_over = 0.1;
//   $unf_wall = 2;
//   use <unfy_fasteners.scad>;
//   unf_pillar(fastener="Heatset", bolt="M3", heatset_length="Medium", length=5, slope=45, wall=1.5);
// Figure(Spin; VPD=50; VPT=[0, 0, 5]; NoAxes): Hexnut
//   $fn = 36;
//   $unf_over = 0.1;
//   $unf_wall = 2;
//   use <unfy_fasteners.scad>;
//   unf_pillar(fastener="Hexnut", bolt="M3", heatset_length="Medium", length=5, slope=45, wall=1.5);
// Usage:
//   unf_pillarNeg(fastener, heatset_length, bolt, length, slope, wall, body_color, subtraction_color)
// Arguments:
//   fastener = A string representing the type of fastener that will be contained within the pillar. One of "heatset" or "hexnut". Future support will be added for "squarenut".
//   heatset_length = One of "small", "medium" or "large" used only with a heatset insert.
//   bolt = A string representing the bolt size.
//   length = length in mm of the pillar
//   slope = slope in degrees leading from bottom to top of the pillar. *note - future version will use a bezier curve, likely replacing this argument.*
//   wall = Minimum material thickness between heatset or nut insert and the outside of the pillar.
//   body_color = color in which to render the pillar
//   subtraction_color = color in which to render the cut surfaces of the pillar.
module unf_pillar(fastener="Heatset", heatset_length="Medium", bolt="M3", length=5, slope=45, wall=1, body_color="Blue", subtraction_color="Yellow"){
	difference(){
		unf_pillarPos(fastener=fastener, bolt=bolt, heatset_length=heatset_length, length=length, slope=slope, wall=wall, body_color=body_color);
		unf_pillarNeg(fastener=fastener, bolt=bolt, heatset_length=heatset_length, length=length, wall=wall, body_color=subtraction_color);
	}
}

/************************ Preview *************************/

module unf_fnrCollection(size="m3", spacing=2){
	let (csk = unf_cskV(size),
		  cap = unf_capV(size),
		  hex = unf_hexV(size),
		  hst=unf_hstV(size),
		  nut = unf_nutV(size),
		  wsh = unf_wshV(size),
		  sqr = unf_sqrV(size),
		  stp = unf_stpV(size, parm_stp_head)
	){
		echo(str("csk: ", csk));
		echo(str("cap: ", cap));
		echo(str("hex: ", hex));
		echo(str("hst: ", hst));
		echo(str("nut: ", nut));
		echo(str("wsh: ", wsh));
		echo(str("sqr: ", sqr));
		echo(str("stp: ", stp));
		unf_csk(size = csk, body_color = body_color);
		translate([(unf_cskHeadDiameter(csk) + unf_capHeadDiameter(cap))/2 + spacing, 0, 0]){
			unf_cap(size = cap, body_color = body_color);
			translate([(unf_capHeadDiameter(cap) + unf_hexHeadDiameter(hex))/2 + spacing, 0, 0]){
				unf_hex(hex);
				translate([(unf_hexHeadDiameter(hex) + unf_fnrDiameter(hst))/2 + spacing, 0, 0]){
					unf_hst(hst);
					translate([(unf_fnrDiameter(hst) + unf_nutDiameter(nut))/2 + spacing, 0, 0]){
						unf_nut(nut);
						translate([(unf_nutDiameter(nut) + unf_wshDiameter(wsh))/2 + spacing, 0, 0]){
							unf_wsh(wsh);
							translate([(unf_wshDiameter(wsh) + unf_sqrLength(sqr))/2 + spacing, 0, 0]){
								unf_sqr(sqr);
								translate([(unf_sqrLength(sqr) + unf_fnrDiameter(stp))/2 + spacing, 0, 0]){
									unf_stp(stp, clearance_length=unf_stpDefaultLength(stp)/2);
								}
							}
						}
					}
				}
			}
		}
	}
}

module unf_hstTestBlock(size="M3"){
	height = unf_hstLength(size, "large") + 0.2*unf_fnrShaftDiameter(size)+2;
	spacing = unf_fnrDiameter(size) + 4;
	length = 4 + (3*spacing) + unf_fnrDiameter(size);
	width = unf_fnrDiameter(size) + 5;

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

module unf_stpTestBlock(size="M3", head="pan"){
	let (size=unf_stpV(size, head)){
		text_size = 3;
		height = unf_stpHeadHeight(size) + 5;
		spacing = unf_stpHeadDiameter(size) + $unf_wall;
		label_w = text_size + (2*$unf_wall);
		length = label_w + (2*spacing);
		width = max(unf_stpHeadDiameter(size) + (2*$unf_wall), 2*text_size + $unf_wall);

		difference(){
			color(body_color){
				cube([length, width, height]);
			}
			translate([$unf_wall, width/2, height-0.6]){
				color(subtraction_color){
					linear_extrude(1){
						rotate([0, 0, 90]){
							text(unf_fnrSize(size), size=text_size, halign="center");
						}
					}
				}
			}
			for (i = [0:1]){
				translate([label_w + (spacing/2) + (i*spacing), width/2, height]){
					rotate([180, 0, 0]){
						unf_stp(size, length=height, body_color=subtraction_color);
					}
				}
			}
		}
	}
}

module unf_stpPilotTestBlock(size="M3", steps=4, min_od=25, max_od=100){
	let (size=unf_stpV(size)){
		text_size = 3;
		depth = unf_stpEngagement(size);
		height = depth + (2*unf_stpPitch(size)) + $unf_wall;
		spacing = max(unf_stpClearanceDiameter(size) + (2*$unf_wall), 4*text_size);
		label_w = text_size + (2*$unf_wall);
		label_h = text_size + (2*$unf_wall);
		length = label_w + (steps*spacing);
		width = (2*label_h) + (2*spacing);
		ods = [for (i = [0:steps-1]) max(unf_stpDefaultPilotId(), round(1 < steps ? min_od + (i*(max_od-min_od)/(steps-1)) : min_od))];

		for (i = [0:steps-1]){
			echo(str(unf_fnrSize(size), " pilot ", ods[i], "%: star id=", unf_stpPilotId(size), " od=", unf_stpPilotOd(size, ods[i]), " points=", unf_stpStarPoints(size, ods[i]), ", round d=", unf_stpPilotDiameter(size, unf_stpDefaultPilotId(), ods[i])));
		}

		difference(){
			color(body_color){
				cube([length, width, height]);
			}
			color(subtraction_color){
				translate([0, 0, height-0.6]){
					linear_extrude(1){
						translate([$unf_wall, width-label_h+$unf_wall]){
							text(unf_fnrSize(size), size=text_size);
						}
						translate([label_w/2, label_h+(spacing/2)]){
							text("S", size=text_size, halign="center", valign="center");
						}
						translate([label_w/2, label_h+(3*spacing/2)]){
							text("R", size=text_size, halign="center", valign="center");
						}
						for (i = [0:steps-1]){
							translate([label_w + (spacing/2) + (i*spacing), $unf_wall]){
								text(str(ods[i]), size=text_size, halign="center");
							}
						}
					}
				}
			}
			for (i = [0:steps-1], star = [true, false]){
				translate([label_w + (spacing/2) + (i*spacing), label_h + (spacing/2) + (star ? 0 : spacing), height]){
					rotate([180, 0, 0]){
						unf_stpPilot(size, length=depth, star=star, od_percent=ods[i], body_color=subtraction_color);
					}
				}
			}
		}
	}
}

module unf_nutTestBlock(size="M3"){
	let (size=unf_nutV(size)){
		height = 2 * max(unf_nutHeight(size), $unf_wall);
		spacing = unf_nutDiameter(size) + $unf_wall;
		length = 4 + (2*spacing) + unf_nutDiameter(size);
		width = unf_nutDiameter(size) + (2*$unf_wall);

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
									text(unf_fnrSize(size), size=5);
								}
							}
						}
						translate([spacing, 0, 0]){
							unf_nut(size);
							unf_shaft(unf_fnrShaftDiameter(size), height + (2*$unf_over));
							translate([spacing, 0, 0]){
								unf_nut(size);
								unf_shaft(unf_fnrShaftDiameter(size), height + (2*$unf_over));
							}
						}
					}
				}
			}
		}
	}
}

module unf_wshTestBlock(size="M3"){
	let (size=unf_wshV(size)){
		height = 2 * max(unf_wshHeight(size), $unf_wall);
		spacing = unf_wshDiameter(size) + $unf_wall;
		length = 4 + (2*spacing) + unf_wshDiameter(size);
		width = unf_wshDiameter(size) + (2*$unf_wall);

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
									text(unf_fnrSize(size), size=6);
								}
							}
						}
						translate([spacing, 0, 0]){
							unf_wsh(size);
							unf_shaft(unf_fnrShaftDiameter(size), height + (2*$unf_over));
							translate([spacing, 0, 0]){
								unf_wsh(size);
								unf_shaft(unf_fnrShaftDiameter(size), height + (2*$unf_over));
							}
						}
					}
				}
			}
		}
	}
}

module unf_sqrTestBlock(size="M3"){
	let (size=unf_sqrV(size)){
		height = 2 * max(unf_sqrHeight(size), $unf_wall);
		spacing = unf_sqrLength(size) + (2*$unf_wall);
		length = 4 + (2*spacing) + unf_sqrLength(size);
		width = unf_sqrLength(size) + (2*$unf_wall);

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
									text(unf_fnrSize(size), size=3);
								}
							}
						}
						translate([spacing, 0, 0]){
							unf_sqr(size);
							unf_shaft(unf_fnrShaftDiameter(size), height + (2*$unf_over));
							translate([spacing, 0, 0]){
								unf_sqr(size);
								unf_shaft(unf_fnrShaftDiameter(size), height + (2*$unf_over));
							}
						}
					}
				}
			}
		}
	}
}

module unf_capTestBlock(size="M3"){
	let (size=unf_capV(size)){
		height = unf_capHeadHeight(size) + 5;
		spacing = unf_capHeadDiameter(size) + $unf_wall;
		length = 4 + (2*spacing) + unf_capHeadDiameter(size);
		width = unf_capHeadDiameter(size) + (2*$unf_wall);

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
									text(unf_fnrSize(size), size=3);
								}
							}
						}
						translate([spacing, 0, 0]){
							unf_cap(size);
							unf_shaft(unf_fnrShaftDiameter(size), height + (2*$unf_over));
							translate([spacing, 0, 0]){
								unf_cap(size);
								unf_shaft(unf_fnrShaftDiameter(size), height + (2*$unf_over));
							}
						}
					}
				}
			}
		}
	}
}

module unf_cskTestBlock(size="M3"){
	let (size=unf_cskV(size)){
		height = unf_cskHeadHeight(size) + 5;
		spacing = unf_cskHeadDiameter(size) + $unf_wall;
		length = 4 + (2*spacing) + unf_cskHeadDiameter(size);
		width = unf_cskHeadDiameter(size) + (2*$unf_wall);

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
									text(unf_fnrSize(size), size=5);
								}
							}
						}
						translate([spacing, 0, 0]){
							unf_csk(size);
							unf_shaft(unf_fnrShaftDiameter(size), height + (2*$unf_over));
							translate([spacing, 0, 0]){
								unf_csk(size);
								unf_shaft(unf_fnrShaftDiameter(size), height + (2*$unf_over));
							}
						}
					}
				}
			}
		}
	}
}

module unf_hexTestBlock(size="M3"){
	let (size=unf_hexV(size)){
		height = unf_hexHeadHeight(size) + 5;
		spacing = unf_hexHeadDiameter(size) + $unf_wall;
		length = 2*spacing;
		width = unf_hexHeadDiameter(size) + (2*$unf_wall);

		difference(){
			linear_extrude(height){
	
				hull(){
	  
					translate([-length, 0]){
						square([length, width]);
					}

					unf_enbox(margin=$unf_wall){
						resize([0, width-(2*$unf_wall)], auto=true){
							text(text=unf_fnrSize(size));
						}
					}
				}
			}
			translate([$unf_wall, $unf_wall, height-$unf_wall]){
				linear_extrude($unf_wall + $unf_over){
					resize([0, width-(2*$unf_wall)], auto=true){
						text(text=unf_fnrSize(size));
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

// Render the test block for any fastener type: "cap", "csk", "hex", "stp" (self tapping screw, head picks the head style), "stpPilot" (self tapping screw pilot holes), "hst" (heatset insert), "nut", "sqr" (square nut) or "wsh" (washer).
module unf_fastenerTestBlock(type="hex", size="M3", head="pan"){
	let (type = unf_stToLower(type)){
		if ("cap" == type){
			unf_capTestBlock(size);
		} else if ("csk" == type){
			unf_cskTestBlock(size);
		} else if ("hex" == type){
			unf_hexTestBlock(size);
		} else if ("stp" == type){
			unf_stpTestBlock(size, head);
		} else if ("stppilot" == type){
			unf_stpPilotTestBlock(size);
		} else if ("hst" == type){
			unf_hstTestBlock(size);
		} else if ("nut" == type){
			unf_nutTestBlock(size);
		} else if ("sqr" == type){
			unf_sqrTestBlock(size);
		} else if ("wsh" == type){
			unf_wshTestBlock(size);
		} else {
			assert(false, str("unknown fastener type: ", type, ", must be one of cap, csk, hex, stp, stpPilot, hst, nut, sqr or wsh"));
		}
	}
}

if (parm_part == "Collection") {
	unf_fnrCollection(size=parm_size);
 }

if (parm_part == "HexHeadBolt_Test_Block"){
	unf_hexTestBlock(size=parm_size);
 }

if (parm_part == "CapHeadBolt_Test_Block") {
	unf_capTestBlock(size=parm_size);
 }

if (parm_part == "CountersunkBolt_Test_Block") {
	unf_cskTestBlock(size=parm_size);
 }

if (parm_part == "Heatset_Test_Block") {
	unf_hstTestBlock(size=parm_size);
 }

if (parm_part == "SelfTap_Test_Block") {
	unf_stpTestBlock(size=parm_size, head=parm_stp_head);
 }

if (parm_part == "SelfTap_Pilot_Test_Block") {
	unf_stpPilotTestBlock(size=parm_size, steps=parm_stp_pilot_steps, min_od=parm_stp_pilot_min_od, max_od=parm_stp_pilot_max_od);
 }

if (parm_part == "HexNut_Test_Block") {
	unf_nutTestBlock(size=parm_size);
 }

if (parm_part == "SquareNut_Test_Block") {
	unf_sqrTestBlock(size=parm_size);
 }

if (parm_part == "Washer_Test_Block") {
	unf_wshTestBlock(size=parm_size);
 }

if (parm_part == "Bolt_Distortion_Test"){
	unf_distortionTestBlock(
		diameter = unf_fnrShaftDiameter(parm_size),
		depth = parm_dist_depth,
		steps = parm_dist_steps,
		min_spacing = parm_dist_min_spacing,
		min_dist_x = parm_dist_min_dist_x,
		max_dist_x = parm_dist_max_dist_x,
		min_dist_y = parm_dist_min_dist_y,
		max_dist_y = parm_dist_max_dist_y,
		include_control = parm_dist_include_control,
		body_color = body_color,
		subtraction_color = subtraction_color
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
