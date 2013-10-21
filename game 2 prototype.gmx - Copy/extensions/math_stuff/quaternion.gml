#define quatCreate
/*
    quatCreate()
    
    returns a new quaternion
*/

with slayersUpgrade
{
    if totalDeletedQuaternions>0
    {
        totalDeletedQuaternions-=1
        
        quaternionx[deletedQuaternion[totalDeletedQuaternions]]=0
        quaterniony[deletedQuaternion[totalDeletedQuaternions]]=0
        quaternionz[deletedQuaternion[totalDeletedQuaternions]]=0
        quaternionw[deletedQuaternion[totalDeletedQuaternions]]=1
        
        return deletedQuaternion[totalDeletedQuaternions]
    }
    else
    {
        quaternionx[totalQuaternions]=0
        quaterniony[totalQuaternions]=0
        quaternionz[totalQuaternions]=0
        quaternionw[totalQuaternions]=1
        
        totalQuaternions+=1
        
        return totalQuaternions-1
    }
}

#define quatDestroy
/*
    quatDestroy(quat)
    
    destroys the quaternion
*/

with slayersUpgrade
{
    deletedQuaternion[totalDeletedQuaternions]=argument0
    
    totalDeletedQuaternions+=1
}

#define quatCopy
/*
    quatCopy(id,source)
    
    makes one quaternion the same as the other.
*/

with slayersUpgrade
{
    quaternionw[argument0]=quaternionw[argument1]
    quaternionx[argument0]=quaternionx[argument1]
    quaterniony[argument0]=quaterniony[argument1]
    quaternionz[argument0]=quaternionz[argument1]
}

#define quatGetVectors
/*
    quatGetVectors(quaternion,vForward,vSide,vUp)
    
    sets the vectors using the orientation of the quaternion. it's like calling all three quatGetVec functions at once.
*/

with slayersUpgrade
{
    vectorx[argument1]=sqr(quaternionw[argument0])+sqr(quaternionx[argument0])-sqr(quaterniony[argument0])-sqr(quaternionz[argument0])
    vectory[argument1]=(quaternionx[argument0]*quaterniony[argument0]+quaternionw[argument0]*quaternionz[argument0])*2
    vectorz[argument1]=(quaternionx[argument0]*quaternionz[argument0]-quaternionw[argument0]*quaterniony[argument0])*2
    
    vectorx[argument2]=(quaterniony[argument0]*quaternionx[argument0]-quaternionw[argument0]*quaternionz[argument0])*2
    vectory[argument2]=sqr(quaternionw[argument0])-sqr(quaternionx[argument0])+sqr(quaterniony[argument0])-sqr(quaternionz[argument0])
    vectorz[argument2]=(quaterniony[argument0]*quaternionz[argument0]+quaternionw[argument0]*quaternionx[argument0])*2
    
    vectorx[argument3]=(quaternionz[argument0]*quaternionx[argument0]+quaternionw[argument0]*quaterniony[argument0])*2
    vectory[argument3]=(quaternionz[argument0]*quaterniony[argument0]-quaternionw[argument0]*quaternionx[argument0])*2
    vectorz[argument3]=sqr(quaternionw[argument0])-sqr(quaternionx[argument0])-sqr(quaterniony[argument0])+sqr(quaternionz[argument0])
}

#define quatGetVecx
/*
    quatGetVecx(quat,vRector)
      
    sets vRector to point along the quaternions x axis
*/

with slayersUpgrade
{
    vectorx[argument1]=sqr(quaternionw[argument0])+sqr(quaternionx[argument0])-sqr(quaterniony[argument0])-sqr(quaternionz[argument0])
    vectory[argument1]=(quaternionx[argument0]*quaterniony[argument0]+quaternionw[argument0]*quaternionz[argument0])*2
    vectorz[argument1]=(quaternionx[argument0]*quaternionz[argument0]-quaternionw[argument0]*quaterniony[argument0])*2
}

#define quatGetVecy
/*
    quatGetVecy(quat,vRector)
     
    sets vRector to point along the quaternions y axis
*/

with slayersUpgrade
{
    vectorx[argument1]=(quaterniony[argument0]*quaternionx[argument0]-quaternionw[argument0]*quaternionz[argument0])*2
    vectory[argument1]=sqr(quaternionw[argument0])-sqr(quaternionx[argument0])+sqr(quaterniony[argument0])-sqr(quaternionz[argument0])
    vectorz[argument1]=(quaterniony[argument0]*quaternionz[argument0]+quaternionw[argument0]*quaternionx[argument0])*2
}

#define quatGetVecz
/*
    quatGetVecz(quat,vRector)
      
    sets vRector to point along the quaternions z axis
*/

with slayersUpgrade
{
    vectorx[argument1]=(quaternionz[argument0]*quaternionx[argument0]+quaternionw[argument0]*quaterniony[argument0])*2
    vectory[argument1]=(quaternionz[argument0]*quaterniony[argument0]-quaternionw[argument0]*quaternionx[argument0])*2
    vectorz[argument1]=sqr(quaternionw[argument0])-sqr(quaternionx[argument0])-sqr(quaterniony[argument0])+sqr(quaternionz[argument0])
}

#define quatGetEuler
/*
    quatGetEuler(quat,vResult)
        
    sets each component of vResult to the rotation of the quaternion in degrees. x=roll y=pitch z=yaw
*/

var a,ax,ay,az;

with slayersUpgrade
{
    ax=-radtodeg(arctan2(2*(quaternionw[argument0]*quaternionx[argument0]+quaterniony[argument0]*quaternionz[argument0]),1-2*(quaternionx[argument0]*quaternionx[argument0]+quaterniony[argument0]*quaterniony[argument0])))
    
    az=-radtodeg(arctan2(2*(quaternionw[argument0]*quaternionz[argument0]+quaternionx[argument0]*quaterniony[argument0]),1-2*(quaterniony[argument0]*quaterniony[argument0]+quaternionz[argument0]*quaternionz[argument0])))
    
    a=2*(quaternionw[argument0]*quaterniony[argument0]-quaternionz[argument0]*quaternionx[argument0])
    
    if a>=1
    {
        ax=-radtodeg(2*arctan2(quaternionx[argument0],quaternionw[argument0]))
        ay=-90
        az=0
        exit
    }
    
    if a<=-1
    {
        ax=-radtodeg(2*arctan2(quaternionx[argument0],quaternionw[argument0]))
        ay=90
        az=0
        exit
    }
    
    ay=-radtodeg(arcsin(2*(quaternionw[argument0]*quaterniony[argument0]-quaternionz[argument0]*quaternionx[argument0])))
    
    vecSetxyz(argument1,ax,ay,az)
}

#define quatMultiply
/*
    quatMultiply(qResult,quaterniona,quaternionb)
    
    qResult equals quaterniona multiplied by quaternionb. the order the quaternions are multiplied effects the resulting rotation
*/

var aw,ax,ay,az;

with slayersUpgrade
{
    aw=quaternionw[argument1]*quaternionw[argument2]-quaternionx[argument1]*quaternionx[argument2]-quaterniony[argument1]*quaterniony[argument2]-quaternionz[argument1]*quaternionz[argument2]
    ax=quaternionw[argument1]*quaternionx[argument2]+quaternionx[argument1]*quaternionw[argument2]+quaterniony[argument1]*quaternionz[argument2]-quaternionz[argument1]*quaterniony[argument2]
    ay=quaternionw[argument1]*quaterniony[argument2]+quaterniony[argument1]*quaternionw[argument2]+quaternionz[argument1]*quaternionx[argument2]-quaternionx[argument1]*quaternionz[argument2]
    az=quaternionw[argument1]*quaternionz[argument2]+quaternionz[argument1]*quaternionw[argument2]+quaternionx[argument1]*quaterniony[argument2]-quaterniony[argument1]*quaternionx[argument2]
    
    quaternionw[argument0]=aw
    quaternionx[argument0]=ax
    quaterniony[argument0]=ay
    quaternionz[argument0]=az
}

#define quatSetAxisAngle
/*
    quatSetAxisAngle(quat,vector,degrees)
       
    quaternion is set using axis angle format
*/

with slayersUpgrade
{
    argument2=degtorad(argument2)/2
    
    quaternionw[argument0]=cos(argument2)
    
    argument2=sin(argument2)
    
    quaternionx[argument0]=vecx(argument1)*argument2
    quaterniony[argument0]=vecy(argument1)*argument2
    quaternionz[argument0]=vecz(argument1)*argument2
}

#define quatSetEuler
/*
    quatSetEuler(quat,roll,pitch,yaw)
    
    quaternion is set using euler angles. roll being rotation around the x, pitch being rotation around the y, and yaw being rotation around the z axis.
*/

var cx,cy,cz,sx,sy,sz;

with slayersUpgrade
{
    argument1=-degtorad(argument1)/2
    argument2=-degtorad(argument2)/2
    argument3=-degtorad(argument3)/2
    
    cx=cos(argument1)
    cy=cos(argument2)
    cz=cos(argument3)
    
    sx=sin(argument1)
    sy=sin(argument2)
    sz=sin(argument3)
    
    /*
    rw=cx*cy*cz-sx*sy*sz
    rx=sx*sy*cz+cx*cy*sz
    ry=sx*cy*cz+cx*sy*sz
    rz=cx*sy*cz-sx*cy*sz
    */
    
    quaternionw[argument0]=cx*cy*cz+sx*sy*sz
    quaternionx[argument0]=sx*cy*cz-cx*sy*sz
    quaterniony[argument0]=cx*sy*cz+sx*cy*sz
    quaternionz[argument0]=cx*cy*sz-sx*sy*cz
}

#define quatClear
/*
    quatClear(quat)
    
    quaternion will be set to a unit quaternion.
*/

with slayersUpgrade
{
    quaternionx[argument0]=0
    quaterniony[argument0]=0
    quaternionz[argument0]=0
    quaternionw[argument0]=1
}

