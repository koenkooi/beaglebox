// Fancy box for beagleboard, (c) 2010,2011 - Koen Kooi, licensed under CC-BY-SA

// Conventions: width = x, length = y, height = z

// width of PCB
inside_width = 87.8;

// lenght of PCB
inside_length = 55.3;

// outside wall thickness
edge_thickness = 1.6;
bottom_thickness = 3;
border_size = edge_thickness + 6;

base_height = 15;

// Number of facets in curves, 32 is a good tradeoff between looks and processing speed
$fn=32;

// helper sizes, disable for final rendering
//color([0,0,1]) helper(inside_width,inside_length,edge_thickness);

translate(v=[0,0,0]) box(inside_width, inside_length, bottom_thickness, base_height, border_size, edge_thickness);


module helper(inside_width,inside_length,edge_thickness) {
	translate(v=[edge_thickness,edge_thickness,-edge_thickness*2]) cube([inside_width,inside_length,edge_thickness], center=false);
	translate(v=[edge_thickness,edge_thickness,20]) cube([edge_thickness,inside_length,edge_thickness], center=false);
}


module box(iw, il, bt, base_height, bs, et ) {
	// mini usb height
	sh=5;
	pcbt= 2;
	extra_height = 0;

	box_length = il + 2*et;
	box_width = iw + 2*et;
	box_height = base_height + extra_height;

	radius=25.4/4;
	radius2=25.4/2;

	difference() {
		// outside part
		union() {
			// the corner radii are different, so we build it in 2 parts using intersection()
			intersection() {
				minkowski(){
					translate(v=[radius, radius, 0]) cube([iw - 2 * radius + 2*et ,il - 2 * radius + 2*et, box_height], center=false);
					cylinder(r=radius,h=1);
				}
				translate(v=[-et/2,-et/2, -box_height* 0.3]) cube([box_width/2 + 2*et, box_length * 1.1, box_height * 1.5]);	
			}
		
			// the corner radii are different, so we build it in 2 parts using intersection()
			intersection() {
				minkowski(){
					translate(v=[radius2, radius2, 0]) cube([iw - 2 * radius2 + 2*et ,il - 2 * radius2 + 2*et, box_height], center=false);
					cylinder(r=radius2,h=1);
				}
				translate(v=[iw/2 ,-et/2, -box_height* 0.3]) cube([box_width/2 + 2*et, box_length * 1.1, box_height * 1.5]);	
			}
     	}
        translate(v = [et +15.5, et+ il -3.5,-0.01]) {cylinder(r=1.5,h=2*sh); m3nut();}
        translate(v = [et +15.5, et +3.5,-0.01]) {cylinder(r=1.5,h=2*sh); m3nut();}
        translate(v = [et +iw -6, et +il -6.5,-0.01]) {cylinder(r=1.5,h=2*sh); m3nut();}
        translate(v = [et +iw -6, et +6.5,-0.01]) {cylinder(r=1.5,h=2*sh); m3nut();}
        
		// inside part
		translate(v=[et, et, bt]) union() {
			// the corner radii are different, so we build it in 2 parts using intersection()
			intersection() {
				minkowski(){
					translate(v=[radius, radius, 0]) cube([iw - 2 * radius,il - 2 * radius, box_height], center=false);
					cylinder(r=radius,h=1);
				}
				translate(v=[-et/2,-et/2, -box_height* 0.3]) cube([box_width/2 + 2*et, box_length * 1.1, box_height * 1.5]);	
			}
		
			// the corner radii are different, so we build it in 2 parts using intersection()
			intersection() {
				minkowski(){
					translate(v=[radius2, radius2, 0]) cube([iw - 2 * radius2,il - 2 * radius2, box_height], center=false);
					cylinder(r=radius2,h=1);
				}
				translate(v=[iw/2 ,-et/2, -box_height* 0.3]) cube([box_width/2 + 2*et, box_length * 1.1, box_height * 1.5]);	
			}
		}

		// bottom cutout
		translate(v=[et + bs, et + bs,0.5]) union() {
			// the corner radii are different, so we build it in 2 parts using intersection()
			intersection() {
				minkowski(){
					translate(v=[radius, radius, 0]) cube([iw - 2 * radius - 2*bs,il - 2 * radius - 2*bs, box_height], center=false);
					cylinder(r=radius,h=1);
				}
				translate(v=[-et/2,-et/2, -box_height* 0.3]) cube([box_width/2 + 2*et, box_length * 1.1, box_height * 1.5]);	
			}
		
			// the corner radii are different, so we build it in 2 parts using intersection()
			intersection() {
				minkowski(){
					translate(v=[radius2, radius2, 0]) cube([iw - 2 * radius2 - 2*bs ,il - 2 * radius2 - 2*bs, box_height], center=false);
					cylinder(r=radius2,h=1);
				}
				translate(v=[iw/2 ,-et/2, -box_height* 0.3]) cube([box_width/2 + 2*et, box_length * 1.1, box_height * 1.5]);	
			}
		}


translate(v=[70,9,0]) rotate(a=[0,0,90]) screwslides();

			
      	
	
		translate(v=[et,et,bt]) {
			//ethernet
		     translate(v = [-et -0.01, 22.5, sh + pcbt - 0.5]) {
		       cube([et*3, 16, 14], center=false);
		     }
		     //power
		     translate(v = [-et -0.01, 5, sh + pcbt]) {
		       cube([et *2, 9.5, 11], center=false);
		     }
		
		     //mini-USB
		     translate(v = [-et + -0.01, 40.6, 0.5 ]) {
		       cube([et *2, 8, sh], center=false);
		     }
             //hdmi 
             hdmiwidth=7;
             hdmioffset=22;
             hdmithickness=3;
		     translate(v = [iw  -0.01, hdmioffset, sh - hdmithickness]) {
		        cube([et *2, hdmiwidth, hdmithickness], center=false);
		     }            
		     //microsd
             usdwidth=13;
             usdoffset=30.75;
		     translate(v = [iw  -0.01, usdoffset, sh - 1 *pcbt]) {
		        cube([et *2, usdwidth, pcbt * 1], center=false);
		     }
		     translate(v = [iw  +2,  usdoffset, 0.5+sh - 1.5 *pcbt]) rotate(a=[0,-50,0]) {
		        cube([et *2, usdwidth, pcbt * 1.5], center=false);
		     }	
		     translate(v = [iw -2.2 , usdoffset, +sh+1]) rotate(a=[0,50,0]) {
		        cube([et *4, usdwidth, 1], center=false);
		     }	
		      //USB
             usbheight=8;
             usbwidth=14.5;
		     translate(v = [iw +0.01 - et, 9.5 , sh + pcbt]) {
		        cube([et *3, usbwidth, usbheight], center=false);
		     }
             cutout=37;
             translate(v = [iw -1.01 , (il-cutout)/2 , bt - 3.6 ]) roundedcube(8,35,base_height,2);
		}

	}
	translate(v=[et,et,bt]) {
		difference() {
			translate(v = [ +15.5, il -3.5,-0.01]) cylinder(r=4.2,h=sh);
			translate(v = [ +15.5, il -3.5,-2]) {cylinder(r=1.45,h=2*sh); m3nut();}
		}
		difference() {
			translate(v = [ +15.5,  +3.5,-0.01]) cylinder(r=4.2,h=sh);
			translate(v = [ +15.5,  +3.5,-2]) {cylinder(r=1.45,h=2*sh); m3nut();}
		}
		difference() {
			translate(v = [iw -6, il -6.5,-0.01]) cylinder(r=4.2,h=sh);
			translate(v = [iw -6, il -6.5,-2]) {cylinder(r=1.45,h=2*sh); m3nut();}
		}
		difference() {
			translate(v = [iw -6,  +6.5,-0.01]) cylinder(r=4.2,h=sh);
			translate(v = [iw -6,  +6.5,-2]) {cylinder(r=1.45,h=2*sh); m3nut();}
		}
	}

}

module m3nut() {
    m3nutheight=2.7;
    difference() {
        cylinder(h=m3nutheight,r=3.35, $fn=6);
        translate(v=[-3.5,-0.5,m3nutheight - 0.15]) cube([7,1,0.15]);
    }
}

module screwslides() {
// entry hole
translate(v=[(40-16)/2,12,-1]) {
    cylinder(h=5,r=4);
    translate(v=[16,0,0]) cylinder(h=5,r=4);
}


//small slide
hull() {
        translate(v=[(40-16)/2,25,-1]) {
            cylinder(h=3,r=2);
        }
        
        translate(v=[(40-16)/2,10,-1]) {
            cylinder(h=3,r=2);
        }
    }
    hull() {
        translate(v=[(40-16)/2+16,25,-1]) {
            cylinder(h=3,r=2);
        }
        
        translate(v=[(40-16)/2+16,10,-1]) {
            cylinder(h=3,r=2);
        }
    }

//big slide
hull() {
        translate(v=[(40-16)/2,25,1]) {
            cylinder(h=5,r=4);
        }
        
        translate(v=[(40-16)/2,10,1]) {
            cylinder(h=5,r=4);
        }
    }
    hull() {
        translate(v=[(40-16)/2+16,25,1]) {
            cylinder(h=5,r=4);
        }
        
        translate(v=[(40-16)/2+16,10,1]) {
            cylinder(h=5,r=4);
        }
    }
}

module roundedcube(x,y,z, radius=5){
    translate(v=[radius,radius,0]) minkowski()
    {
        cube([x-2*radius,y-2*radius,z-1]);
        cylinder(r=radius,h=1);
    }
}