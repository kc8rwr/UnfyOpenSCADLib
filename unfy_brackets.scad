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

use <unfy_fasteners.scad>
use <unfy_math.scad>
use <unfy_lists.scad>

$fn = $preview ? 360 : 360;

module multi_bracket(width=6, web_pct=66, thickness=2, fillet=2, legs=[[0, 10, [], "red"], [45, 10, [], "blue"]]){
  //[angle, length, hole_type, holes, leg_color]
  function leg_angle(v) = v[0];
  function leg_length(v) = v[1];
  function leg_holes(v) = v[2];
  function leg_webs(v) = v[3];
  function leg_color(v) = v[4];

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
	calcs = [for (leg = legs) let (
	    angle = leg_angle(leg),
	    slope = tan(angle),
	    off_x = h_offset(angle, thickness),
	    off_y = v_offset(angle, thickness, off_x),
	    b1 = off_y - slope*off_x,
	    b2 = (thickness / sin(90-angle)) - slope*off_x + off_y
	  )[
	    [off_x, off_y],//offset - 0
	    slope,//slope - 1
	    b1, //base line b
	    b2 //thickness line b
	  ]];
	echo(str("Calcs: ", calcs));
	
	//going to use each legs offset multiple times if including bead or webbing so let's calculate them just once per leg and store them in a vector
	offsets = [for (off = [for (leg = legs) [h_offset(leg_angle(leg), thickness), leg_angle(leg)]]) [off[0], v_offset(off[1], thickness, off[0])]];
	echo(str("Offsets: ", offsets));

	//Adjust leg length correct while accounting for overlap and offsets
	adj_leg_lengths = [for (index = [0:len(legs)-1]) unf_distance_to_bounding_circle(leg_length(legs[index]), offsets[index], leg_angle(legs[index]))];
	//Draw each leg
	for (leg_index=[0:len(legs)-1]){
	  leg = legs[leg_index];
	  leg_angle = leg_angle(leg);
	  leg_offset = offsets[leg_index];
	  leg_length = adj_leg_lengths[leg_index];
	  translate([leg_offset.x, 0, leg_offset.y]){
	    rotate([0, -leg_angle, 0]){
	      //	      translate([-(thickness/20), -(thickness/20), 0]) color("black") cube([leg_length+(thickness/10), width+(thickness/10), thickness/10]);
	      color(leg_color(leg)) cube([leg_length, width, thickness]);
	    }
	  }
	}
    
	// fillet
	if (1 < len(legs)){
	  for (leg_index = [1:len(legs)-1]){
	    if (0 < fillet){
	      leg = legs[leg_index];
	      prev_leg = legs[leg_index-1];
	      leg_angle = leg_angle(leg);
	      prev_angle = leg_angle(prev_leg);
	      opening_angle = leg_angle - prev_angle;
	      if (180 > opening_angle && atan(thickness/min(adj_leg_lengths[leg_index], adj_leg_lengths[leg_index-1])) < opening_angle){
		leg_offset = offsets[leg_index];
		prev_offset = offsets[leg_index-1];
	      
		m_prev = tan(prev_angle);
		b_prev = (thickness / sin(90-prev_angle)) - m_prev*prev_offset.x + prev_offset.y;
		inside = 90 == prev_angle ?
		  let(
		    inside_x = 0,
		    m = tan(leg_angle),
		    b = 0 - m*leg_offset.x + leg_offset.y
		  )
		  [inside_x, m*inside_x + b] : (
		    270 == prev_angle ?
		    let(
		      inside_x = thickness,
		      m = tan(leg_angle),
		      b = 0 - m*leg_offset.x + leg_offset.y
		    )
		    [inside_x, m*inside_x + b] : (
		      90 == leg_angle ?
		      let(
			inside_x = leg_offset.x
		      )
		      [inside_x, prev_offset.y+b_prev+m_prev*prev_offset.x] : (
			270 == leg_angle ?
			let(
			  inside_x = 0
			)
			[inside_x, b_prev]
			:
			let(
			  m = tan(leg_angle),
			  b = 0 - m*leg_offset.x + leg_offset.y,
			  inside_x = (b_prev - b) / (m - m_prev))
			[inside_x, (m_prev*inside_x)+b_prev]
		      )));
		fillet_bez = let(
		  top = [fillet*cos(leg_angle) + inside.x, fillet*sin(leg_angle) + inside.y],
		  bottom = [fillet*cos(prev_angle) + inside.x, fillet*sin(prev_angle) + inside.y]
		) concat([inside], unfy_bezier([top, inside, bottom]), [inside]);
		color("green"){
		  //fillet
		  translate([0, width, 0]){
		    rotate([90, 0, 0]){
		      linear_extrude(width){
			polygon(fillet_bez);
		      }
		    }
		  }
		  //webs
		  for(web = leg_webs(leg)){
		    web_bez = let(
		      top = [web[2]*cos(leg_angle) + inside.x, web[2]*sin(leg_angle) + inside.y],
		      bottom = [web[2]*cos(prev_angle) + inside.x, web[2]*sin(prev_angle) + inside.y]
		    ) concat([inside], unfy_bezier([top, inside, bottom]), [inside]);
		    translate([0, width-web[0], 0]){
		      rotate([90, 0, 0]){
			linear_extrude(web[1]){
			  polygon(web_bez);
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
  }
}


start = 90;
a1 = 0;
end = 180;
a2 = (a1 + start + $t*end) % end;

multi_bracket(width=50, web_pct=66, thickness=2, legs=[
		[a1, 40, [], [], "blue"],
		[a2, 40, [], [[0, 4, 30], [22.5, 5, 30], [45, 5, 30]], "yellow"],
		/*[0, 40, [], [], "gray"],
		[45, 40, [], [], "blue"],
		[90, 40, [], [], "gray"],
		[135, 40, [], [], "yellow"],
		[180, 40, [], [], "gray"],
		[225, 40, [], [], "blue"],
		[270, 40, [], [], "gray"],
		[315, 40, [], [], "yellow"]*/
	      ]);
//translate([0, 20, 0]) rotate([90, 0, 0]) circle(r=40);

