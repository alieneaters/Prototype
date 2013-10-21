var vx,vy,vz,dis,zp,zdir;
zdir = argument1
vx = cos(degtorad(argument0))*cos(degtorad(zdir))
vy = -sin(degtorad(argument0))*cos(degtorad(zdir))
vz = sin(degtorad(zdir))
dis = p3dc_ray(obj_control.col,x,y,z,obj_control.x,obj_control.y,obj_control.z,vx,vy,vz)
zp = z+vz*dis 

return dis
