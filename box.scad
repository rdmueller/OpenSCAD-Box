//pi zero
inner_width=28;
inner_length=15;
inner_height=70;

thickness = 2;
cover_thickness = 1;
skin = 0.4;
cover_overlap=2;

length = inner_length+thickness*2;
width = inner_width+thickness*2;
height = inner_height+cover_overlap;
overall_length = length*2+width*2+skin/2*3;

module wedge(_length) {
    rotate([90,0,0])
    linear_extrude(_length)
        polygon([ 
                    [0, 0], 
                    [thickness, 0], 
                    [thickness, thickness] ]);
}

module side(_width) {
    difference() {
        cube([_width,height,thickness]);
        translate([thickness,0,0]) {
            rotate([0,0,180]) {
                wedge(height);
            }
        }
        translate([_width-thickness,height,0]) {
            wedge(height);
        }
    }
}
module sides() {
    translate([0,0,0]) {
        side(width);
    }
    translate([width+skin/2,0,0]) {
        side(length);
    }
    translate([   width  + skin/2
                + length + skin/2,0,0]) {
        side(width);
    }
    translate([   width  + skin/2
                + length + skin/2
                + width  + skin/2,0,0]) {
        side(length);
    }
}
module sides_with_skin() {
    sides();
        translate([0,0,thickness])
            cube([overall_length,height,skin]);
}
module box() {
    difference() {
        sides_with_skin();
        
        translate([0,0,thickness/2])
            cube([overall_length,cover_overlap,thickness/2+skin]);
        translate([0,height-cover_overlap,thickness/2])
            cube([overall_length,cover_overlap,thickness/2+skin]);
    }
}
module lid() {
    translate([width/2,length/2,0]) {
        union() {
            translate([0,0,cover_overlap/2]) {
            difference() {
                cube([width+skin*2,length+skin*2,cover_overlap], center = true);
                cube([width-thickness+0.4,length-thickness+0.4,cover_overlap], center = true);
            }
            cube([width-thickness*2-1,length-thickness*2-1,cover_overlap], center = true);
        }
            translate([0,0,cover_overlap+cover_thickness/2]) {
            cube([width+skin*2,length+skin*2,cover_thickness], center = true);
            }
        }
    }
}
//translate([0,-height-2,0]) {
//    box();
//}
//translate([width+2,0,0]) {
//    lid();
//}
lid();
