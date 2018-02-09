// Fancy box for beagleboard, (c) 2010,2011 - Koen Kooi, licensed under CC-BY-SA

// Conventions: width = x, length = y, height = z

// width of PCB
inside_width = 87.8;

// lenght of PCB
inside_length = 55.3;

// outside wall thickness
edge_thickness = 2.2;
bottom_thickness = 1;
border_size = edge_thickness + 6;

base_height = 32;

// Number of facets in curves, 32 is a good tradeoff between looks and processing speed
$fn=64;

// helper sizes, disable for final rendering
//color([0,0,1]) helper(inside_width,inside_length,edge_thickness);

translate(v=[0,0,0]) box(inside_width, inside_length, bottom_thickness, base_height, border_size, edge_thickness);

//translate(v=[0,-inside_length,edge_thickness]) bottomlid(inside_width, inside_length, bottom_thickness, base_height, border_size, edge_thickness);

//translate(v=[0, inside_length+border_size,edge_thickness]) toplid(inside_width, inside_length, bottom_thickness, base_height, border_size, edge_thickness);


module helper(inside_width,inside_length,edge_thickness) {
	translate(v=[edge_thickness,edge_thickness,-edge_thickness*2]) cube([inside_width,inside_length,edge_thickness], center=false);
	translate(v=[edge_thickness,edge_thickness,20]) cube([edge_thickness,inside_length,edge_thickness], center=false);
}

module bottomlid(iw, il, bt, base_height, bs, et ) {
	// mini usb height
	sh=4.5;
	pcbt= 2;
	extra_height = 0;

	box_length = il + 2*et;
	box_width = iw + 2*et;
	box_height = et;

	radius=25.4/4;
	radius2=25.4/2;

		translate(v=[et + bs, et + bs, 0]) union() {
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
		translate(v=[ bs, bs, -et]) union() {
			// the corner radii are different, so we build it in 2 parts using intersection()
			intersection() {
				minkowski(){
					translate(v=[radius, radius, 0]) cube([iw - 2 * radius - 2*bs + 2*et,il - 2 * radius - 2*bs + 2*et, box_height], center=false);
					cylinder(r=radius,h=1);
				}
				translate(v=[-et/2,-4*et, -box_height* 0.3]) cube([box_width/2 + 2*et, box_length * 1.1, box_height * 1.5]);	
			}
		
			// the corner radii are different, so we build it in 2 parts using intersection()
			intersection() {
				minkowski(){
					translate(v=[radius2, radius2, 0]) cube([iw - 2 * radius2 - 2*bs  + 2*et,il - 2 * radius2 - 2*bs + 2*et, box_height], center=false);
					cylinder(r=radius2,h=1);
				}
				translate(v=[iw/2 ,-4*et, -box_height* 0.3]) cube([box_width/2 + 2*et, box_length * 1.1, box_height * 1.5]);	
			}
		}
}

module toplid(iw, il, bt, base_height, bs, et ) {
	// mini usb height
	sh=4.5;
	pcbt= 2;
	extra_height = 0;

	box_length = il + 2*et;
	box_width = iw + 2*et;
	box_height = et;

	radius=25.4/4;
	radius2=25.4/2;

		//outside part
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

		// inside part
		translate(v=[et, et, et]) union() {
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
}

module box(iw, il, bt, base_height, bs, et ) {
	// mini usb height
	sh=4.5;
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

		// inside part
		translate(v=[et, et, et]) union() {
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
		translate(v=[et + bs, et + bs, -et]) union() {
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

			
      	
	
		translate(v=[et,et,et]) {
			//ethernet
		     translate(v = [-et -0.01, 22.5, sh + pcbt - 0.5]) {
		       cube([et*3, 16, 14.5], center=false);
		     }
		     //power
		     translate(v = [-et -0.01, 5, sh + pcbt]) {
		       cube([et *2, 9.5, 11], center=false);
		     }
		
		     //mini-USB
		     translate(v = [-et + -0.01, 41, 0 ]) {
		       cube([et *2, 8, 4.5], center=false);
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
		     translate(v = [iw +0.01 - et, 10.5 , sh + pcbt]) {
		        cube([et *3, 14, 9], center=false);
		     }

		      //Wifi
		     translate(v = [-2 - et, 30 , sh + pcbt +20 ]) {
		        rotate(a=[0,90,0]) cylinder(r=3.26, h=10);
		     }
		}

	}
	translate(v=[et,et,et]) {
		difference() {
			translate(v = [ +15.5, il -3.5,-0.01]) cylinder(r=3,h=sh);
			translate(v = [ +15.5, il -3.5,+0.5]) cylinder(r=1.4,h=sh);
		}
		difference() {
			translate(v = [ +15.5,  +3.5,-0.01]) cylinder(r=3,h=sh);
			translate(v = [ +15.5,  +3.5,0.5]) cylinder(r=1.4,h=sh);
		}
		difference() {
			translate(v = [iw -6, il -6.5,-0.01]) cylinder(r=4,h=sh);
			translate(v = [iw -6, il -6.5,0.5]) cylinder(r=1.4,h=sh);
		}
		difference() {
			translate(v = [iw -6,  +6.5,-0.01]) cylinder(r=4,h=sh);
			translate(v = [iw -6,  +6.5,0.5]) cylinder(r=1.4,h=sh);
		}
	}

}