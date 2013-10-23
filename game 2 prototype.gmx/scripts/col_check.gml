//collision_spheres(x1,y1,z1,x2,y2,z2,radius1,radius2)
//Checks for a collision between two 3D spheres
var xx1,yy1,zz1,xx2,yy2,zz2,dx,dy,dz;
xx1=argument0
yy1=argument1
zz1=argument2
xx2=argument3
yy2=argument4
zz2=argument5
dx=xx2-xx1
dy=yy2-yy1
dz=zz2-zz1
return sqrt(dx*dx + dy*dy + dz*dz)<=argument6+argument7
