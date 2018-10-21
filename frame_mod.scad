extrusion_size = 20;
extrusion_half_size = extrusion_size / 2;
extrusion_nut = 6;

frame_x = 450;
frame_y = 450;
frame_z = 450;

module extrusion_x(w=extrusion_size,h=extrusion_size,l=500, n=extrusion_nut, nd=4)
{
    // Maße Außenkante bis Nut
    wo = w/2 - n/2;
    ho = h/2 - n/2;
    
    // Maße Innenteil 
    wi = w - nd;
    hi = h - nd;
    union() {
        translate([0, -wi/2, -hi/2])
        cube([l, wi, hi]);
        
        for(y = [+1, -1])
        {
            for(z = [+1, -1])
            {
                translate([0, -wo/2 + (n/2 + wo/2) * y, -ho/2 + (n/2 + ho/2) * z])
                cube([l, wo, ho]);
            }
        }
    }
}


module extrusion_y(w=extrusion_size,h=extrusion_size,l=500, n=extrusion_nut, nd=4)
{
    rotate([0,0,90])
    extrusion_x(w,h,l,n,nd);
}

module extrusion_z(w=extrusion_size,h=extrusion_size,l=500, n=extrusion_nut, nd=4)
{
    rotate([0,-90,0])
    extrusion_x(w,h,l,n,nd);
}

translate([0,0,-10])
{
    translate([-frame_x/2,0,0]) extrusion_x(l=frame_x);
    translate([-frame_x/2,frame_y/2 - extrusion_half_size,0]) extrusion_x(l=frame_x);
    translate([-frame_x/2,-frame_y/2 + extrusion_half_size,0]) extrusion_x(l=frame_x);

    translate([frame_x/2 + extrusion_half_size,-frame_y/2,0]) extrusion_y(l=frame_y);
    translate([-frame_x/2 - extrusion_half_size,-frame_y/2,0]) extrusion_y(l=frame_y);

    translate([frame_x/2 + extrusion_half_size,+5,extrusion_half_size]) extrusion_z(l=frame_z);
    translate([-frame_x/2 - extrusion_half_size,+5,extrusion_half_size]) extrusion_z(l=frame_z);
}

include <box_frame/doc/complete-printer-plus.scad>