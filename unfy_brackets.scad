// - Under construction - Not yet functional
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

/*[ Main ] */
width = 50;
thickness = 2;
fillet = 2;
rounded = true;
leg_count = 2; //[1:8]

/*[ Leg-1 ] */
leg1_angle = 0; //[0:359]
leg1_length = 30;
leg1_mounts_count = 2;
leg1_mount1_position = [15, 16.66];
leg1_mount1_type = "hole"; //["hole", "heatset", "post"]
leg1_mount1_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg1_mount1_backside = false;
leg1_mount1_height = 2;
//size - for heatset only
leg1_mounts1_size = "medium";//["small","medium","large"]
//(X, Y)
leg1_mount2_position = [15, 33.33];
leg1_mount2_type = "hole"; //["hole", "heatset", "post"]
leg1_mount2_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg1_mount2_backside = false;
leg1_mount2_height = 2;
//size - for heatset only
leg1_mount2_size = "medium";//["small","medium","large"]
//(X, Y)
leg1_mount3_position = [22.5, 16.66];
leg1_mount3_type = "hole"; //["hole", "heatset", "post"]
leg1_mount3_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg1_mount3_backside = false;
leg1_mount3_height = 2;
//size - for heatset only
leg1_mount3_size = "medium";//["small","medium","large"]
//(X, Y)
leg1_mount4_position = [22.5, 33.33];
leg1_mount4_type = "hole"; //["hole", "heatset", "post"]
leg1_mount4_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg1_mount4_backside = false;
leg1_mount4_height = 2;
//size - for heatset only
leg1_mount4_size = "medium";//["small","medium","large"]

/*[ Leg-2 ] */
leg2_angle = 90; //[0:359]
leg2_length = 30;
leg2_mount_group = 1;//[0:4]
leg2_mounts_count = 2;
leg2_mount1_position = [15, 16.66];
leg2_mount1_type = "hole"; //["hole", "heatset", "post"]
leg2_mount1_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg2_mount1_backside = false;
leg2_mount1_height = 2;
//size - for heatset only
leg2_mounts1_size = "medium";//["small","medium","large"]
//(X, Y)
leg2_mount2_position = [15, 33.33];
leg2_mount2_type = "hole"; //["hole", "heatset", "post"]
leg2_mount2_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg2_mount2_backside = false;
leg2_mount2_height = 2;
//size - for heatset only
leg2_mount2_size = "medium";//["small","medium","large"]
//(X, Y)
leg2_mount3_position = [22.5, 16.66];
leg2_mount3_type = "hole"; //["hole", "heatset", "post"]
leg2_mount3_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg2_mount3_backside = false;
leg2_mount3_height = 2;
//size - for heatset only
leg2_mount3_size = "medium";//["small","medium","large"]
//(X, Y)
leg2_mount4__position = [22.5, 33.33];
leg2_mount4_type = "hole"; //["hole", "heatset", "post"]
leg2_mount4_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg2_mount4_backside = false;
leg2_mount4_height = 2;
//size - for heatset only
leg2_mount4_size = "medium";//["small","medium","large"]

/*[ Leg-3 ] */
leg3_angle = 45; //[0:359]
leg3_length = 30;
leg3_mount_group = 1;//[0:4]
leg3_mounts_count = 2;
leg3_mount1_position = [15, 16.66];
leg3_mount1_type = "hole"; //["hole", "heatset", "post"]
leg3_mount1_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg3_mount1_backside = false;
leg3_mount1_height = 2;
//size - for heatset only
leg3_mounts1_size = "medium";//["small","medium","large"]
//(X, Y)
leg3_mount2_position = [15, 33.33];
leg3_mount2_type = "hole"; //["hole", "heatset", "post"]
leg3_mount2_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg3_mount2_backside = false;
leg3_mount2_height = 2;
//size - for heatset only
leg3_mount2_size = "medium";//["small","medium","large"]
//(X, Y)
leg3_mount3_position = [22.5, 16.66];
leg3_mount3_type = "hole"; //["hole", "heatset", "post"]
leg3_mount3_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg3_mount3_backside = false;
leg3_mount3_height = 2;
//size - for heatset only
leg3_mount3_size = "medium";//["small","medium","large"]
//(X, Y)
leg3_mount4_position = [22.5, 33.33];
leg3_mount4_type = "hole"; //["hole", "heatset", "post"]
leg3_mount4_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg3_mount4_backside = false;
leg3_mount4_height = 2;
//size - for heatset only
leg3_mount4_size = "medium";//["small","medium","large"]

/*[ Leg-4 ] */
leg4_angle = 135; //[0:359]
leg4_length = 30;
leg4_mount_group = 1;//[0:4]
leg4_mountz_count = 2;
leg4_mount1_position = [15, 16.66];
leg4_mount1_type = "hole"; //["hole", "heatset", "post"]
leg4_mount1_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg4_mount1_backside = false;
leg4_mount1_height = 2;
//size - for heatset only
leg4_mounts1_size = "medium";//["small","medium","large"]
//(X, Y)
leg4_mount2_position = [15, 33.33];
leg4_mount2_type = "hole"; //["hole", "heatset", "post"]
leg4_mount2_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg4_mount2_backside = false;
leg4_mount2_height = 2;
//size - for heatset only
leg4_mount2_size = "medium";//["small","medium","large"]
//(X, Y)
leg4_mount3_position = [22.5, 16.66];
leg4_mount3_type = "hole"; //["hole", "heatset", "post"]
leg4_mount3_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg4_mount3_backside = false;
leg4_mount3_height = 2;
//size - for heatset only
leg4_mount3_size = "medium";//["small","medium","large"]
//(X, Y)
leg4_mount4__position = [22.5, 33.33];
leg4_mount4_type = "hole"; //["hole", "heatset", "post"]
leg4_mount4_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg4_mount4_backside = false;
leg4_mount4_height = 2;
//size - for heatset only
leg4_mount4_size = "medium";//["small","medium","large"]

/*[ Leg-5 ] */
leg5_angle = 180; //[0:359]
leg5_length = 30;
leg5_mount_group = 1;//[0:4]
leg5_mounts_count = 2;
leg5_mount1_position = [15, 16.66];
leg5_mount1_type = "hole"; //["hole", "heatset", "post"]
leg5_mount1_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg5_mount1_backside = false;
leg5_mount1_height = 2;
//size - for heatset only
leg5_mounts1_size = "medium";//["small","medium","large"]
//(X, Y)
leg5_mount2_position = [15, 33.33];
leg5_mount2_type = "hole"; //["hole", "heatset", "post"]
leg5_mount2_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg5_mount2_backside = false;
leg5_mount2_height = 2;
//size - for heatset only
leg5_mount2_size = "medium";//["small","medium","large"]
//(X, Y)
leg5_mount3_position = [22.5, 16.66];
leg5_mount3_type = "hole"; //["hole", "heatset", "post"]
leg5_mount3_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg5_mount3_backside = false;
leg5_mount3_height = 2;
//size - for heatset only
leg5_mount3_size = "medium";//["small","medium","large"]
//(X, Y)
leg5_mount4__position = [22.5, 33.33];
leg5_mount4_type = "hole"; //["hole", "heatset", "post"]
leg5_mount4_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg5_mount4_backside = false;
leg5_mount4_height = 2;
//size - for heatset only
leg5_mount4_size = "medium";//["small","medium","large"]

/*[ Leg-6 ] */
leg6_angle = 225; //[0:359]
leg6_length = 30;
leg6_mount_group = 1;//[0:4]
leg6_mounts_count = 2;
leg6_mount1_position = [15, 16.66];
leg6_mount1_type = "hole"; //["hole", "heatset", "post"]
leg6_mount1_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg6_mount1_backside = false;
leg6_mount1_height = 2;
//size - for heatset only
leg6_mounts1_size = "medium";//["small","medium","large"]
//(X, Y)
leg6_mount2_position = [15, 33.33];
leg6_mount2_type = "hole"; //["hole", "heatset", "post"]
leg6_mount2_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg6_mount2_backside = false;
leg6_mount2_height = 2;
//size - for heatset only
leg6_mount2_size = "medium";//["small","medium","large"]
//(X, Y)
leg6_mount3_position = [22.5, 16.66];
leg6_mount3_type = "hole"; //["hole", "heatset", "post"]
leg6_mount3_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg6_mount3_backside = false;
leg6_mount3_height = 2;
//size - for heatset only
leg6_mount3_size = "medium";//["small","medium","large"]
//(X, Y)
leg6_mount4__position = [22.5, 33.33];
leg6_mount4_type = "hole"; //["hole", "heatset", "post"]
leg6_mount4_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg6_mount4_backside = false;
leg6_mount4_height = 2;
//size - for heatset only
leg6_mount4_size = "medium";//["small","medium","large"]

/*[ Leg-7 ] */
leg7_angle = 270; //[0:359]
leg7_length = 30;
leg7_mount_group = 1;//[0:4]
leg7_mounts_count = 2;
leg7_mount1_position = [15, 16.66];
leg7_mount1_type = "hole"; //["hole", "heatset", "post"]
leg7_mount1_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg7_mount1_backside = false;
leg7_mount1_height = 2;
//size - for heatset only
leg7_mounts1_size = "medium";//["small","medium","large"]
//(X, Y)
leg7_mount2_position = [15, 33.33];
leg7_mount2_type = "hole"; //["hole", "heatset", "post"]
leg7_mount2_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg7_mount2_backside = false;
leg7_mount2_height = 2;
//size - for heatset only
leg7_mount2_size = "medium";//["small","medium","large"]
//(X, Y)
leg7_mount3_position = [22.5, 16.66];
leg7_mount3_type = "hole"; //["hole", "heatset", "post"]
leg7_mount3_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg7_mount3_backside = false;
leg7_mount3_height = 2;
//size - for heatset only
leg7_mount3_size = "medium";//["small","medium","large"]
//(X, Y)
leg7_mount4__position = [22.5, 33.33];
leg7_mount4_type = "hole"; //["hole", "heatset", "post"]
leg7_mount4_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg7_mount4_backside = false;
leg7_mount4_height = 2;
//size - for heatset only
leg7_mount4_size = "medium";//["small","medium","large"]

/*[ Leg-8 ] */
leg8_angle = 315; //[0:359]
leg8_length = 30;
leg8_mount_group = 1;//[0:4]
leg8_mounts_count = 2;
leg8_mount1_position = [15, 16.66];
leg8_mount1_type = "hole"; //["hole", "heatset", "post"]
leg8_mount1_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg8_mount1_backside = false;
leg8_mount1_height = 2;
//size - for heatset only
leg8_mounts1_size = "medium";//["small","medium","large"]
//(X, Y)
leg8_mount2_position = [15, 33.33];
leg8_mount2_type = "hole"; //["hole", "heatset", "post"]
leg8_mount2_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg8_mount2_backside = false;
leg8_mount2_height = 2;
//size - for heatset only
leg8_mount2_size = "medium";//["small","medium","large"]
//(X, Y)
leg8_mount3_position = [22.5, 16.66];
leg8_mount3_type = "hole"; //["hole", "heatset", "post"]
leg8_mount3_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg8_mount3_backside = false;
leg8_mount3_height = 2;
//size - for heatset only
leg8_mount3_size = "medium";//["small","medium","large"]
//(X, Y)
leg8_mount4__position = [22.5, 33.33];
leg8_mount4_type = "hole"; //["hole", "heatset", "post"]
leg8_mount4_diameter = "m3"; //["M2", "M2.5", "M3", "M4", "#4", "#6", "#8"]
leg8_mount4_backside = false;
leg8_mount4_height = 2;
//size - for heatset only
leg8_mount4_size = "medium";//["small","medium","large"]

/*[ Webs ] */
web_height = 30; //[0:359]
web_thickness = 5;

use <unfy_fasteners.scad>
use <unfy_math.scad>
use <unfy_lists.scad>

$fn = $preview ? 36 : 360;

module multi_bracket(width=6, thickness=2, fillet=2, legs=[[0, 10, [], [], "yellow"], [45, 10, [], [], "blue"]], rounded = true){
  // functions which read from the leg vectors
  //[angle, length, hole_type, holes]
  function leg_angle(v) = v[0];
  function leg_length(v) = v[1];
  function leg_mounts(v) = v[2];
  function leg_webs(v) = v[3];

  //functions which read from the calcs1 vectors
  function leg_offset(v) = v[0];
  function leg_slope(v) = v[1];
  function leg_b1(v) = v[2];
  function leg_b2(v) = v[3];
  function leg_adj_len(v) = v[4];

  //functions which read from the calcs2 vector
  function opening(v) = v[0];
  function inside(v) = v[1];
  function inner_length1(v) = v[2];
  function inner_length2(v) = v[3];

  //functions which read from a mount vector
  // [type, backside, [x, y], shaft_diameter, size]
  function mount_type(v) = unf_stToLower(v[0]);
  function mount_backside(v) = v[1];
  function mount_position(v) = v[2];
  function mount_diameter(v) = unf_fnr_shaft_diameter(v[3]);
  function mount_size(v) =v[3];
  function mount_size2(v) = 4 < len(v) ? v[4] : 0;
  
  //as leg angle travels around the circle need to offset so that legs still come to a clean point
  function h_offset(leg_angle, thickness) = 180 < leg_angle ? 0 : thickness*cos(90 - leg_angle); //offset = adj hyp = thickness cos(theta)=adj/hyp  hyp*cos(theta) = adj
  function v_offset(leg_angle, thickness, h_offset) = 90 == leg_angle ? 0 : (
    90 < leg_angle && leg_angle < 270 ? sqrt(pow(thickness, 2)-pow(h_offset, 2)) : (
      thickness-sqrt(pow(thickness,2)-pow(h_offset, 2))));

  let(
    legs = [for(leg = legs)
	concat(
	  [unf_normalize_angle(leg[0])],
	  [for(index = [1:len(leg)-1]) leg[index]]
	)
    ]){
    let(legs = unf_matrix_sort(legs, 0)){
      let(
	legs = [for(index=[0:len(legs)-1])
	    concat(
	      [legs[index][0]-legs[0][0]],
	      [for(x = [1:len(legs[index])-1]) legs[index][x]]
	    )
	]){

	//pre-calculate values
	calcs1 = [for (leg = legs) let (
	    angle = leg_angle(leg),
	    slope = tan(angle),
	    off_x = h_offset(angle, thickness),
	    off_y = v_offset(angle, thickness, off_x),
	    b1 = off_y - slope*off_x,
	    b2 = (thickness / sin(90-angle)) - slope*off_x + off_y,
	    adj_leg_length = unf_distance_to_bounding_circle(leg_length(leg), [off_x, off_y], angle)
	  )[
	    [off_x, off_y],//offset - 0
	    slope,//slope - 1
	    b1, //base line b
	    b2, //thickness line b
	    adj_leg_length //adjusted leg length which takes into account the offset
	  ]];

	calcs2 = [for (index = [0:len(legs)-1]) let (
	    prev_index = index == 0 ? len(legs)-1 : index-1,
	    cur_leg = legs[index],
	    prev_leg = legs[prev_index],
	    cur_calcs1 = calcs1[index],
	    prev_calcs1 = calcs1[prev_index],
	    cur_len = leg_adj_len(cur_calcs1),
	    prev_len = leg_adj_len(prev_calcs1),
	    cur_offset = leg_offset(cur_calcs1),
	    prev_offset = leg_offset(prev_calcs1),
	    cur_slope = leg_slope(cur_calcs1),
	    prev_slope = leg_slope(prev_calcs1),
	    cur_angle = leg_angle(cur_leg),
	    prev_angle = leg_angle(prev_leg),
	    opening_angle = cur_angle - prev_angle,
	    cur_b = leg_b1(cur_calcs1),
	    prev_b = leg_b2(prev_calcs1),
	    
	    inside = 90 == prev_angle ? (
	      [0, cur_b]
	    ) : (
	      270 == prev_angle ? (
		[thickness, (cur_slope * thickness) + cur_b]
	      ) : (
		90 == cur_angle ? (
		  [cur_offset.x, prev_offset.y + prev_b + (prev_slope * prev_offset.x)]
		) : (
		  270 == cur_angle ? (
		    [0, prev_b]
		  ) : (
		    let(inside_x = (prev_b - cur_b) / (cur_slope - prev_slope))
		    [inside_x, (prev_slope * inside_x) + prev_b]
		  )
		)
	      )
	    ),
	    prev_inner_length = prev_len,
	    cur_inner_length = cur_len
	  )[
	    opening_angle,
	    inside,
	    prev_inner_length,
	    cur_inner_length
	  ]];
	
	//Draw each leg
	for (leg_index=[0:len(legs)-1]){
	  leg = legs[leg_index];
	  leg_angle = leg_angle(leg);
	  leg_offset = leg_offset(calcs1[leg_index]);
	  leg_length = leg_adj_len(calcs1[leg_index]);
	  mounts = leg_mounts(leg);
	  translate([leg_offset.x, 0, leg_offset.y]){
	    rotate([0, -leg_angle, 0]){
	      let(
		adj_leg_length = rounded && (0 == leg_index || len(legs)-1 == leg_index) ? leg_length - (thickness/2) : leg_length,
		adj_width = rounded && (0 == leg_index || len(legs)-1 == leg_index) ? width - (thickness) : width,
		shift = [0, rounded && (0 == leg_index || len(legs)-1 == leg_index) ? thickness/2 : 0, rounded && len(legs)-1 == leg_index ? thickness/2 : (rounded && 0 == leg_index ? -thickness/2 : 0)]
	      ){
		difference(){
		  union(){
		    //leg
		    intersection(){
		      if (0 == leg_index || len(legs)-1 == leg_index){
			cube([leg_length, width, thickness]);
		      }
		      translate(shift){
			minkowski(){
			  if (rounded){
			    hull(){
			      cube([0.001, adj_width, thickness]);
			      translate([adj_leg_length-thickness, adj_width-thickness, 0])
				cylinder(h=thickness, r=thickness);
			      translate([adj_leg_length-thickness, thickness, 0])
				cylinder(h=thickness, r=thickness);
			    }
			  } else {
			    if(rounded && (0 == leg_index || len(legs)-1 == leg_index)){
			      cube([adj_leg_length, adj_width, thickness]);
			    } else {
			      cube([leg_length, width, thickness]);
			    }
			  }
			  if(rounded && (0 == leg_index || len(legs)-1 == leg_index)){
			    sphere(d = thickness);
			  }
			}
		      }
		    }
		    //posts
		    for(mount = mounts){
		      type = mount_type(mount);
		      backside = mount_backside(mount);
		      position = mount_position(mount);
		      diameter = mount_diameter(mount);
		      size = mount_size(mount);
		      size2 = mount_size2(mount);
		      if ("post" == type){
			if (backside){
			  translate([position.x, position.y, -size2]){
			    cylinder(d=diameter, h=size2+thickness);
			  }
			} else {
			  translate([position.x, position.y, 0]){
			    cylinder(d=diameter, h=size2+thickness);
			  }
			}
		      } else if ("heatset" == type){
			height = unf_hst_length(size, size2);
			stud_diameter = unf_hst_diameter(size, size2);
			if (backside){//backward
			  translate([position.x, position.y, -height]){
			    cylinder(d=stud_diameter+(2*thickness), h=height+thickness);
			  }
			} else {
			  translate([position.x, position.y, 0]){
			    cylinder(d=stud_diameter+(2*thickness), h=height+thickness);
			  }
			}
		      }
		    }
		  }
		  //holes
		  for (mount = mounts){
		    type = mount_type(mount);
		    backside = mount_backside(mount);
		    position = mount_position(mount);
		    diameter = mount_diameter(mount);
		    size = mount_size(mount);
		    size2 = mount_size2(mount);
		    if ("hole" == type){
		      translate([position.x, position.y, -1]){
			cylinder(d = diameter, h=thickness+2);
		      }
		    } else if ("heatset" == type){
		      height = unf_hst_length(size, size2);
		      if (backside){
			translate([position.x, position.y, -height]){
			  unf_hst(size=size, length=size2, bolt_hole_depth=thickness+1, head_ext=1);
			}
		      } else {
			translate([position.x, position.y, height+thickness]){
			  rotate([180, 0, 0]){
			    unf_hst(size=size, length=size2, bolt_hole_depth=thickness+1, head_ext=1);
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
    
	// fillet & webs
	if (1 < len(legs)){
	  for (leg_index = [1:len(legs)-1]){
	    leg = legs[leg_index];
	    prev_leg = legs[leg_index-1];
	    cur_calcs1 = calcs1[leg_index];
	    prev_calcs1 = calcs1[leg_index-1];
	    calcs2 = calcs2[leg_index];
	    
	    cur_length = leg_length(leg);
	    prev_length = leg_length(prev_leg);
	    cur_angle = leg_angle(leg);
	    prev_angle = leg_angle(prev_leg);
	    leg_adj_len = leg_adj_len(cur_calcs1);
	    prev_adj_len = leg_adj_len(prev_calcs1);
	    cur_fillet = min(leg_adj_len, fillet);
	    prev_fillet = min(prev_adj_len, fillet);
	    opening_angle = opening(calcs2);
	    opening_inside = inside(calcs2);
	    prev_inner_length = inner_length1(calcs2);
	    cur_inner_length = inner_length2(calcs2);
	    cur_offset = leg_offset(cur_calcs1);
	    prev_offset = leg_offset(prev_calcs1);
	    cur_across = [thickness*cos(cur_angle+90), thickness*sin(cur_angle+90)];
	    mid = cur_offset + cur_across;
	      
	    if (0 < fillet || 0 < len(leg_webs(leg))){
	      if (180 > opening_angle && atan(thickness/min(leg_adj_len, prev_adj_len)) < opening_angle){

		for(web = 0 < fillet ? concat([[0, width, fillet]], leg_webs(leg)) : leg_webs(leg)){
		  web_bez = let(
		    adj_web1 = min(unf_distance_to_bounding_circle(cur_length, opening_inside, cur_angle)-(rounded ? thickness : 0), web[2]),
		    adj_web2 = min(unf_distance_to_bounding_circle(prev_length, opening_inside, prev_angle)-(rounded ? thickness : 0), web[2]),
		    top_front = [adj_web1*cos(cur_angle) + opening_inside.x, adj_web1*sin(cur_angle) + opening_inside.y],
		    cur_back = top_front + cur_across,
		    bottom = [adj_web2*cos(prev_angle) + opening_inside.x, adj_web2*sin(prev_angle) + opening_inside.y],
		    bottom_back = bottom + [thickness*cos(prev_angle-90), thickness*sin(prev_angle-90)]
		  ) concat([prev_offset, mid, cur_back], unfy_bezier([top_front, opening_inside, bottom], $fn = $fn), [bottom_back, prev_offset]);
		  translate([0, width-web[0], 0]){
		    rotate([90, 0, 0]){
		      linear_extrude(web[1]){
			polygon(web_bez);
		      }
		    }
		  }
		}
	      }
	    } else { //no fillet
	      // Joint
	      if (rounded && 90 > opening_angle){
		bottom = opening_inside + [thickness*cos(prev_angle-90), thickness*sin(prev_angle-90)];
		translate([0, width, 0]){
		  rotate([90, 0, 0]){
		    linear_extrude(width){
		      polygon([prev_offset, mid, opening_inside, bottom]);
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
}

leg1_mounts = unf_sub([
		    [leg1_mount1_type, leg1_mount1_backside, leg1_mount1_position, leg1_mount1_diameter, "heatset" == leg1_mount1_type ? leg1_mount1_size : leg1_mount1_height],
		    [leg1_mount2_type, leg1_mount2_backside, leg1_mount2_position, leg1_mount2_diameter, "heatset" == leg1_mount2_type ? leg1_mount2_size : leg1_mount2_height],
		    [leg1_mount3_type, leg1_mount3_backside, leg1_mount3_position, leg1_mount3_diameter, "heatset" == leg1_mount3_type ? leg1_mount3_size : leg1_mount3_height],
		    [leg1_mount4_type, leg1_mount4_backside, leg1_mount4_position, leg1_mount4_diameter, "heatset" == leg1_mount4_type ? leg1_mount4_size : leg1_mount4_height]
		  ], 0, leg1_mounts_count);

leg2_mounts = unf_sub([
		    [leg2_mount1_type, leg2_mount1_backside, leg2_mount1_position, leg2_mount1_diameter, "heatset" == leg2_mount1_type ? leg2_mount1_size : leg2_mount1_height],
		    [leg2_mount2_type, leg2_mount2_backside, leg2_mount2_position, leg2_mount2_diameter, "heatset" == leg2_mount2_type ? leg2_mount2_size : leg2_mount2_height],
		    [leg2_mount3_type, leg2_mount3_backside, leg2_mount3_position, leg2_mount3_diameter, "heatset" == leg2_mount3_type ? leg2_mount3_size : leg2_mount3_height],
		    [leg2_mount4_type, leg2_mount4_backside, leg2_mount4_position, leg2_mount4_diameter, "heatset" == leg2_mount4_type ? leg2_mount4_size : leg2_mount4_height]
		  ], 0, leg2_mounts_count);

leg3_mounts = unf_sub([
		    [leg3_mount1_type, leg3_mount1_backside, leg3_mount1_position, leg3_mount1_diameter, "heatset" == leg3_mount1_type ? leg3_mount1_size : leg3_mount1_height],
		    [leg3_mount2_type, leg3_mount2_backside, leg3_mount2_position, leg3_mount2_diameter, "heatset" == leg3_mount2_type ? leg3_mount2_size : leg3_mount2_height],
		    [leg3_mount3_type, leg3_mount3_backside, leg3_mount3_position, leg3_mount3_diameter, "heatset" == leg3_mount3_type ? leg3_mount3_size : leg3_mount3_height],
		    [leg3_mount4_type, leg3_mount4_backside, leg3_mount4_position, leg3_mount4_diameter, "heatset" == leg3_mount4_type ? leg3_mount4_size : leg3_mount4_height]
		  ], 0, leg3_mounts_count);

leg4_mounts = unf_sub([
		    [leg4_mount1_type, leg4_mount1_backside, leg4_mount1_position, leg4_mount1_diameter, "heatset" == leg4_mount1_type ? leg4_mount1_size : leg4_mount1_height],
		    [leg4_mount2_type, leg4_mount2_backside, leg4_mount2_position, leg4_mount2_diameter, "heatset" == leg4_mount2_type ? leg4_mount2_size : leg4_mount2_height],
		    [leg4_mount3_type, leg4_mount3_backside, leg4_mount3_position, leg4_mount3_diameter, "heatset" == leg4_mount3_type ? leg4_mount3_size : leg4_mount3_height],
		    [leg4_mount4_type, leg4_mount4_backside, leg4_mount4_position, leg4_mount4_diameter, "heatset" == leg4_mount4_type ? leg4_mount4_size : leg4_mount4_height]
		  ], 0, leg4_mounts_count);

leg5_mounts = unf_sub([
		    [leg5_mount1_type, leg5_mount1_backside, leg5_mount1_position, leg5_mount1_diameter, "heatset" == leg5_mount1_type ? leg5_mount1_size : leg5_mount1_height],
		    [leg5_mount2_type, leg5_mount2_backside, leg5_mount2_position, leg5_mount2_diameter, "heatset" == leg5_mount2_type ? leg5_mount2_size : leg5_mount2_height],
		    [leg5_mount3_type, leg5_mount3_backside, leg5_mount3_position, leg5_mount3_diameter, "heatset" == leg5_mount3_type ? leg5_mount3_size : leg5_mount3_height],
		    [leg5_mount4_type, leg5_mount4_backside, leg5_mount4_position, leg5_mount4_diameter, "heatset" == leg5_mount4_type ? leg5_mount4_size : leg5_mount4_height]
		  ], 0, leg5_mounts_count);

leg6_mounts = unf_sub([
		    [leg6_mount1_type, leg6_mount1_backside, leg6_mount1_position, leg6_mount1_diameter, "heatset" == leg6_mount1_type ? leg6_mount1_size : leg6_mount1_height],
		    [leg6_mount2_type, leg6_mount2_backside, leg6_mount2_position, leg6_mount2_diameter, "heatset" == leg6_mount2_type ? leg6_mount2_size : leg6_mount2_height],
		    [leg6_mount3_type, leg6_mount3_backside, leg6_mount3_position, leg6_mount3_diameter, "heatset" == leg6_mount3_type ? leg6_mount3_size : leg6_mount3_height],
		    [leg6_mount4_type, leg6_mount4_backside, leg6_mount4_position, leg6_mount4_diameter, "heatset" == leg6_mount4_type ? leg6_mount4_size : leg6_mount4_height]
		  ], 0, leg6_mounts_count);

leg7_mounts = unf_sub([
		    [leg7_mount1_type, leg7_mount1_backside, leg7_mount1_position, leg7_mount1_diameter, "heatset" == leg7_mount1_type ? leg7_mount1_size : leg7_mount1_height],
		    [leg7_mount2_type, leg7_mount2_backside, leg7_mount2_position, leg7_mount2_diameter, "heatset" == leg7_mount2_type ? leg7_mount2_size : leg7_mount2_height],
		    [leg7_mount3_type, leg7_mount3_backside, leg7_mount3_position, leg7_mount3_diameter, "heatset" == leg7_mount3_type ? leg7_mount3_size : leg7_mount3_height],
		    [leg7_mount4_type, leg7_mount4_backside, leg7_mount4_position, leg7_mount4_diameter, "heatset" == leg7_mount4_type ? leg7_mount4_size : leg7_mount4_height]
		  ], 0, leg7_mounts_count);

leg8_mounts = unf_sub([
		    [leg8_mount1_type, leg8_mount1_backside, leg8_mount1_position, leg8_mount1_diameter, "heatset" == leg8_mount1_type ? leg8_mount1_size : leg8_mount1_height],
		    [leg8_mount2_type, leg8_mount2_backside, leg8_mount2_position, leg8_mount2_diameter, "heatset" == leg8_mount2_type ? leg8_mount2_size : leg8_mount2_height],
		    [leg8_mount3_type, leg8_mount3_backside, leg8_mount3_position, leg8_mount3_diameter, "heatset" == leg8_mount3_type ? leg8_mount3_size : leg8_mount3_height],
		    [leg8_mount4_type, leg8_mount4_backside, leg8_mount4_position, leg8_mount4_diameter, "heatset" == leg8_mount4_type ? leg8_mount4_size : leg8_mount4_height]
		  ], 0, leg8_mounts_count);

test_webs = 0 < web_thickness && 0 < web_height ? [[0, web_thickness, web_height], [(width/2)-(web_thickness/2), web_thickness, web_height], [width-web_thickness, web_thickness, web_height]] : [];

legs = unf_sub([
		 [leg1_angle, leg1_length, leg1_mounts, test_webs],
		 [leg2_angle, leg2_length, leg2_mounts, test_webs],
		 [leg3_angle, leg3_length, leg3_mounts, test_webs],
		 [leg4_angle, leg4_length, leg4_mounts, test_webs],
		 [leg5_angle, leg5_length, leg5_mounts, test_webs],
		 [leg6_angle, leg6_length, leg6_mounts, test_webs],
		 [leg7_angle, leg7_length, leg7_mounts, test_webs],
		 [leg8_angle, leg8_length, leg8_mounts, test_webs],
	       ], 0, leg_count);

multi_bracket(width=width, thickness=thickness, rounded=rounded, legs=legs, fillet=fillet);

