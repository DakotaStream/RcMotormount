
legWidth = 12;
legLength = 54;
mountHeight = 23;  //Change this for the Height;

mountHoleDiameter = 4;
mountHoleSpacing = 43.8;
centerHoleDiameter = 13;
fnn = 60;  //Lower number rougher look but fast.  Higher, smooth and slow.

motorMount();


module motorMount(){
    difference()
        {
            motorMountWithOutMountHoles();
            fourMountHoles();
        }
}



module motorMountWithOutMountHoles(){
    difference()
        {
        cutCenterHole();
        topAndBottomCuts();
        }
}

module topAndBottomCuts(){
        translate([0,0,mountHeight+20/2])
            cube([60,60,mountHeight + 20], center=true);
        translate([0,0,-mountHeight-20/2])
            cube([60,60,mountHeight+20], center=true);
}


module cutCenterHole(){
    difference()
    {
        cross();
        translate([0,0,-20])
            cylinder(mountHeight + 20,d=centerHoleDiameter, $fn=fnn);
    }
}

module fourMountHoles(){
    translate([mountHoleSpacing/2,0,-20])
        cylinder(mountHeight + 40, d=mountHoleDiameter, $fn=fnn);

    translate([-mountHoleSpacing/2,0,-20])
        cylinder(mountHeight + 40, d=mountHoleDiameter, $fn=fnn);

    translate([0,mountHoleSpacing/2,-20])
        cylinder(mountHeight + 40, d=mountHoleDiameter, $fn=fnn);

    translate([0,-mountHoleSpacing/2,-20])
        cylinder(mountHeight + 40, d=mountHoleDiameter, $fn=fnn);
}


module fourCubes(){
    o=26;
    translate([o,o,0])
   RoundedCube(size = [40,40 , mountHeight + 20], center = true,radius = 7,fn=fnn);

    translate([-o,o,0])
   RoundedCube(size = [40,40 , mountHeight + 20], center = true,radius = 7,fn=fnn);

    translate([o,-o,0])
   RoundedCube(size = [40,40 ,mountHeight + 20], center = true,radius = 7,fn=fnn);

    translate([-o,-o,0])
   RoundedCube(size = [40,40 , mountHeight + 20], center = true,radius = 7,fn=fnn);
}

module cross(){
    rotate([0,0,90])
        RoundedCube(size = [legWidth, legLength, mountHeight + 20], center = true,radius = 5,fn=fnn);
    RoundedCube(size = [legWidth, legLength, mountHeight + 20], center = true,radius = 5,fn=fnn);
    difference(){
        cube([40,40,mountHeight], center=true);
        fourCubes();
    }
}




module RoundedCube(size = [1, 1, 1], center = false,radius = 0.5,fn=10)
{
    obj_translate = (center == true) ?  [0, 0, 0] : [ (size[0] / 2), (size[1] / 2), (size[2] / 2) ];
    translate(v = obj_translate) {
            hull(){
                cube([size[0]-radius-radius,size[1]-radius-radius,size[2]],center=true);
                cube([size[0]-radius-radius,size[1],size[2]-radius-radius],center=true);
                cube([size[0],size[1]-radius-radius,size[2]-radius-radius],center=true);
            
                translate ([size[0]/2-radius,size[1]/2-radius,size[2]/2-radius])
                sphere(r = radius,$fn = fnn);
                translate ([-size[0]/2+radius,size[1]/2-radius,size[2]/2-radius])
                sphere(r = radius,$fn = fnn);
                translate ([-size[0]/2+radius,-size[1]/2+radius,size[2]/2-radius])
                sphere(r = radius,$fn = fnn);
                translate ([size[0]/2-radius,-size[1]/2+radius,size[2]/2-radius])
                sphere(r = radius,$fn = fnn);
            
                translate ([size[0]/2-radius,size[1]/2-radius,-size[2]/2+radius])
                sphere(r = radius,$fn = fnn);
                translate ([-size[0]/2+radius,size[1]/2-radius,-size[2]/2+radius])
                sphere(r = radius,$fn = fnn);
                translate ([-size[0]/2+radius,-size[1]/2+radius,-size[2]/2+radius])
                sphere(r = radius,$fn = fnn);
                translate ([size[0]/2-radius,-size[1]/2+radius,-size[2]/2+radius])
                sphere(r = radius,$fn = fnn);
            }
        }
}