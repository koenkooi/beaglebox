// Fancy box for beaglebone white, (c) 2010-2018 - Koen Kooi, licensed under CC-BY-SA

// Conventions: width = x, length = y, height = z

// width of PCB
inside_width = 87.8;

// lenght of PCB
inside_length = 55.3;

// outside wall thickness
edge_thickness = 1.6;
bottom_thickness = 3;
border_size = edge_thickness + 6;

// mini usb height
sh=5;

base_height = 21;

// Number of facets in curves, 32 is a good tradeoff between looks and processing speed
$fn=128;


translate(v=[0,0,0]) box(inside_width, inside_length, bottom_thickness, base_height, border_size, edge_thickness);

module box(iw, il, bt, base_height, bs, et ) {

	pcbt= 2;
	extra_height = 0;

	box_length = il + 2*et;
	box_width = iw + 2*et;
	box_height = base_height + extra_height;

	radius=25.4/4;
	radius2=25.4/2;

	difference() {
		// outside part, the actual box
        hull() {
            translate(v=[inside_width - radius2 + et *2,radius2,0]) cylinder(r=radius2,h=box_height);    
            translate(v=[inside_width - radius2 + et*2, inside_length - radius2 + et*2,0]) cylinder(r=radius2,h=box_height);
            translate(v=[radius,radius,0]) cylinder(r=radius,h=box_height);    
            translate(v=[radius,inside_length - radius +et*2]) cylinder(r=radius,h=box_height); 
        }   
		

        translate(v = [et +15.5, et+ il -3.5,-0.01]) {cylinder(r=1.5,h=2*sh); m3nut();}
        translate(v = [et +15.5, et +3.5,-0.01]) {cylinder(r=1.5,h=2*sh); m3nut();}
        translate(v = [et +iw -6, et +il -6.5,-0.01]) {cylinder(r=1.5,h=2*sh); m3nut();}
        translate(v = [et +iw -6, et +6.5,-0.01]) {cylinder(r=1.5,h=2*sh); m3nut();}
        
		// inside part, the BBW
		translate(v=[et, et, bt]) { hull() {
                translate(v=[inside_width - radius2,radius2,0]) cylinder(r=radius2,h=box_height * 1.5);    
                translate(v=[inside_width - radius2 , inside_length - radius2,0]) cylinder(r=radius2,h=box_height * 1.5);
                translate(v=[radius,radius,0]) cylinder(r=radius,h=box_height * 1.5);    
                translate(v=[radius,inside_length - radius,0]) cylinder(r=radius,h=box_height * 1.5); 
            }   
		}

		// bottom cutout
        bottomcutoutlength = inside_length*0.6;
        bottomcutoutwidth = inside_width*0.6;
        bottomthickness = 0.8;
		translate(v=[et + (inside_width -bottomcutoutwidth)/2 , et + (inside_length -bottomcutoutlength)/2,bottomthickness]) { hull() {
                translate(v=[bottomcutoutwidth - radius2,radius2,0]) cylinder(r=radius2,h=box_height * 1.5);    
                translate(v=[bottomcutoutwidth - radius2 , bottomcutoutlength - radius2,0]) cylinder(r=radius2,h=box_height * 1.5);
                translate(v=[radius,radius,0]) cylinder(r=radius,h=box_height * 1.5);    
                translate(v=[radius,bottomcutoutlength - radius,0]) cylinder(r=radius,h=box_height * 1.5); 
            }
		}
  		
        translate(v=[70,9,0]) rotate(a=[0,0,90]) screwslides();

		translate(v=[et,et,et]) {
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
		
		      //microsd: 15mm long, 25.5mm corner offset
		     translate(v = [iw  -0.01, 25.5, sh - 1.5 *pcbt]) {
		        cube([et *2, 15, pcbt * 1.5], center=false);
		     }
		     translate(v = [iw  +2,  25.5, 1+sh - 1.5 *pcbt]) rotate(a=[0,-50,0]) {
		        cube([et *2, 15, pcbt * 1.5], center=false);
		     }	
		     translate(v = [iw -1.9 ,  25.5, +sh-1.5]) rotate(a=[0,50,0]) {
		        cube([et *3, 15, 4], center=false);
		     }	
		      //USB
             usbheight=8;
             usbwidth=14.5;
		     translate(v = [iw +0.01 - et, 9.5 , sh + pcbt]) {
		        cube([et *3, usbwidth, usbheight], center=false);
		     }
		}

	}
	translate(v=[et,et,bt]) {
		difference() {
			translate(v = [ +15.5, il -3.5,-0.01]) cylinder(r=4.2,h=sh);
			translate(v = [ +15.5, il -3.5,-2]) {cylinder(r=1.45,h=2*sh);}
		}
		difference() {
			translate(v = [ +15.5,  +3.5,-0.01]) cylinder(r=4.2,h=sh);
			translate(v = [ +15.5,  +3.5,-2]) {cylinder(r=1.45,h=2*sh);}
		}
		difference() {
			translate(v = [iw -6, il -6.5,-0.01]) cylinder(r=4.2,h=sh);
			translate(v = [iw -6, il -6.5,-2]) {cylinder(r=1.45,h=2*sh); }
		}
		difference() {
			translate(v = [iw -6,  +6.5,-0.01]) cylinder(r=4.2,h=sh);
			translate(v = [iw -6,  +6.5,-2]) {cylinder(r=1.45,h=2*sh); }
		}
	}

}

module m3nut() {
    m3nutheight=2.7;
    difference() {
        cylinder(h=m3nutheight,r=3.35, $fn=6);
        //translate(v=[-3.5,-0.5,m3nutheight - 0.15]) cube([7,1,0.15]);
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
    translate(v=[radius,radius,0]) hull()
    {
        translate(v=[0,0,0]) cylinder(r=radius,h=z);
        translate(v=[x - radius*2,0,0]) cylinder(r=radius,h=z);
        translate(v=[x - radius*2,y - radius*2,0]) cylinder(r=radius,h=z);
        translate(v=[0,y - radius*2,0]) cylinder(r=radius,h=z);
    }
}