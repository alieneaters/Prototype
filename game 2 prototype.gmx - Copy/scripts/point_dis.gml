var vx,vy,vz,dis,zp,zdir;
zdir = argument1
vx = cos(degtorad(argument0))*cos(degtorad(zdir))
vy = -sin(degtorad(argument0))*cos(degtorad(zdir))
vz = sin(degtorad(zdir))
dis = p3dc_ray_still(argument2,x,y,z,vx,vy,vz)
zp = z+vz*dis 

return dis
