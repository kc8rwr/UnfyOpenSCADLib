body_x = 31.8;
body_y = 24;
ear_x = 9.1;
screw_d = 3.5;
screw_x = 4.1;
cutout_x = 27.2;
cutout_y = 19.2;
hood_thickness = 3;
cutaway_thickness = 7;
cutaway_bottom_x = 27.2;
cutaway_bottom_y = 13.33;
cutaway_top_x = 15;
cutaway_y = 20;


$fn = $preview ? 15 : 360;

translate([0, 0, -hood_thickness]){
    linear_extrude(hood_thickness){
        hull(){
            //body
            square([body_x, body_y]);
    
            //ears
            for (x = [-screw_x, body_x + screw_x]){
                translate([x, body_y/2]){
                    circle(r = ear_x - screw_x);
                }
            }
        }
    }
}

translate([0, 0, -cutaway_thickness]){
    linear_extrude(cutaway_thickness){
        //body
        bottom_y = (body_y - cutaway_y)/2

        //screw holes
        for (x = [-screw_x, body_x + screw_x]){
            translate([x, body_y/2]){
                circle(d = screw_d);
            }
      }
    }
 }
