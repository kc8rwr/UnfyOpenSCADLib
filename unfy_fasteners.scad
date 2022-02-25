parm_part = "Collection"; // ["Collection", "Bolt_Distortion_Test"]

parm_size = "m3"; // ["m2", "m2.5", "m3", "m4", "num6", "num8"]

//horizontal bolt shaft distortion height (as percentage of diameter)
$ufn_hdist_y = 10; //[0:100]

//horizontal bolt shaft distortion width (as percentage of diameter)
$ufn_hdist_x = 80; //[0:100]

//distance subtractions should "hang over"
$over = 0.1;

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


/************************ Distorted Shafts ***********************************/

function ufn_shaft_diameter(size="m3") =
  is_num(size) ? size : (
    "m2" == size ? 2 : (
      "m2.5" == size ? 2.5 : (
	"m3" == size ? 3 : (
	  "m4" == size ? 4 : (
	    "num6" == size ? (0.138*25.4) : ufn_shaft_diameter("m3")
	  )
	)
      )
    )
  );

module ufn_shaft(diameter=3, length=10, distorted=false){
  if (distorted || 0 == $ufn_hdist_y || 0 == $ufn_hdist_x){
    dist_d =(diameter * $ufn_hdist_x) / 100;
    linear_extrude(length) {
      hull(){
	circle(d=diameter);
	translate([0, ((diameter-dist_d)/2)+((diameter*$ufn_hdist_y)/200)]){
	  circle(d=dist_d);
	}
      }
    }
  } else { // !distorted
    cylinder(d=diameter, h=length);
  }
}


/************************ Countersunk Bolts ufn_csk_ *************************/

//[name, bolt_diameter, head_top_diameter, head_bottom_diameter, default_length]

ufn_csk_vectors = [
  ["num6", 0.138*25.4, 0.262*25.4, 0.083*25.4, 3.5*25.4],
  ["m2", 2, 4, 1.2, 10],
  ["m2.5", 2.5, 4.7, 1.5, 10],
  ["m3", 3, 6, 1.7, 10],
  ["m4", 4, 8, 2.3, 10],
];

function ufn_str_toLower(string) = string;

function ufn_csk_v(size) =
  is_list(size) ? size : (
    is_undef(search(size, ufn_csk_vectors, 1, 0).x)
    ?
    ufn_csk_v("m3")
    :
    ufn_csk_vectors[search(size, ufn_csk_vectors, 1, 0).x]
  );

//[top_diameter, bottom_diameter, default_length, bolt_diameter]
/*function ufn_csk_v(size = "num6") =
  size == "num6" ? [0.262*25.4, 0.083*25.4, 0.138*25.4] : (
    size == "m4" ? [8, 2.3, 4] : (
      size == "m3" ? [6, 1.7, 3] : (
	size == "m2.5" ? [4.7, 1.5, 2.5] : (
	  size == "m2" ? [4, 1.2, 2] : ufn_csk_v("m3")
	)
      )
    )
    );*/

function ufn_csk_head_diameter(size) = 
  ufn_csk_v(size)[0];

function ufn_csk_shaft_diameter(size) = 
  ufn_csk_v(size)[2];

module ufn_csk(screw = "num6", length = 25, head_ext = -1){
  let (head_ext = (0 <= head_ext) ? head_ext : $over){
    v = ufn_csk_v(screw);
    head_d = ufn_csk_head_diameter(v);
    head_height = v[1];
    shaft_d = ufn_csk_shaft_diameter(v);
    if (0 < head_ext){
      translate([0, 0, -head_ext]){
	color("grey", 0.25){
	  cylinder(h = head_ext, d = head_d);
	}
      }
    }
    cylinder(h = head_height, d1 = head_d, d2 = shaft_d);
    cylinder(h = length, d = shaft_d);
  }
}



/************************ Heatset Inserts ufn_hst_ ***************************/

//[top_diameter, bottom_diameter, body_length, bolt_diameter]
function ufn_hst_v(size="m3") =
  is_list(size) ? size : (
    is_num(size) ? [size, size, size, size] : (
      size == "num6" ? [5.16, 5.16, 3.81, 3.3] : (
	size == "m3" ? [5, 5, 4, 3] : ufn_hst_v("m3"))));

function ufn_hst_width(screw="m3", opening_taper_percent=10) =
  ufn_hst_v(screw)[0]+(ufn_hst_v(screw)[0]*opening_taper_percent/100);

module ufn_hst(screw="m3", opening_taper_percent=10, length=false, head_ext=-1, extra_room=true, bolt_hole_depth=0){
  v = ufn_hst_v(screw);
  d1=v[0];
  d2=v[1];
  body_length=is_num(length)?length:v[2];
  bolt_d=v[3];
  //main body
  translate([0, 0, -body_length]){
    cylinder(h=body_length, d1=d2, d2=(d1)+(d1*opening_taper_percent/100));
  }
  //head extension
  let (head_ext = (0 <= head_ext) ? head_ext : $over){
    if (0 < head_ext){
      color("grey", 0.25){
	cylinder(h=head_ext, r=(d1/2)+(d1*opening_taper_percent/200));
      }
    }
  }
  //extra room
  if (extra_room){
    er=0.2;
    translate([0, 0, -(1+er)*body_length]){
      color("blue"){
	cylinder(d1=(1-er)*d2, d2=d2);
      }
    } 
  }
  //bolt hole
  if (0 < bolt_hole_depth){
    translate([0, 0, -(body_length+bolt_hole_depth)]){
      color("orange"){
	cylinder(d=bolt_d, h=body_length+bolt_hole_depth);
      }
    }
  }
}



/************************ Preview *************************/

module collection(size="m3", spacing=2){
  ufn_csk(screw = size);
  translate([(ufn_csk_head_diameter(size) + ufn_hst_width(size))/2 + spacing, 0, 0]){
    ufn_hst(screw = size);
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
	  ufn_shaft(length = depth+2, diameter = diameter, $ufn_hdist_x=dist_x, $ufn_hdist_y=dist_y, distorted=true);
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


if (parm_part == "Collection"){
  collection(parm_size);
 }

if (parm_part == "Bolt_Distortion_Test"){
  distortion_test_block(
    diameter = ufn_shaft_diameter(parm_size),
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
