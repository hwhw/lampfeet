$fn=50;

/*
module fuehrung(size=1.2, length=8) {
    union() {
        sphere(r=size/2);
        cylinder(r=size/2, h=length);
        translate([0,0,length]) sphere(r=size/2);
    };
};
*/

module cutoffsphere(r=15,width=20) {
    intersection() {
        sphere(r = r);
        translate([-width/2,-r,-r])
            cube(size=[width,r*2,r*2]);
    };
};

module feet(r=15, width=20, slot=4) {
    translate([0,0,width/2]) rotate([0,90,0]) difference() {
        cutoffsphere(r=r, width=width);
        union() {
            rotate([0,90,0]) cylinder(h=width*1.01,r=slot/2,center=true);
            translate([-(width*1.01)/2,-slot/2,0]) cube(size=[width*1.01,slot,r]);
        };
    };
};

module feetdisplay(num = 4, r=15, width=20, slot=4, dist=5) {
    translate([r,r,0]) {
        size = ceil(sqrt(num));
        dxy = r*2 + dist;
        for(x = [0:size-1]) {
            for(y = [0:size-1]) {
                if(x*size+y < num) {
                    translate([dxy*x, dxy*y, 0])
                        feet(r=r,width=width,slot=slot);
                };
            };
        };
    };
};

feetdisplay(num=3);
