var vx,vy,vz,dis,zp;
vx=cos(degtorad(direction))*cos(degtorad(zdir));
vy=-sin(degtorad(direction))*cos(degtorad(zdir));
vz=sin(degtorad(zdir));
dis=p3dc_ray_still(global.level_colid,x,y,z,vx,vy,vz);
zp=z+vz*dis;

    if(dis!=0){
    xpo = x+dis*cos(degtorad(direction))*cos(degtorad(zdir))
    ypo = y-dis*sin(degtorad(direction))*cos(degtorad(zdir))
    zpo = zp
    }
