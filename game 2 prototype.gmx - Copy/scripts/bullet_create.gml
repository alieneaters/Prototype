//create_bullet(x,y,z,object,pitch,yaw,speed)
//Creates an object at the given position and sets its angles and speed.
var tmpinst;
tmpinst=instance_create(argument0,argument1,argument3)
tmpinst.z=argument2
tmpinst.pitch=-argument4
tmpinst.dir=argument5
tmpinst.spd=argument6
tmpinst.dam=global.bowl_dam
return tmpinst;
