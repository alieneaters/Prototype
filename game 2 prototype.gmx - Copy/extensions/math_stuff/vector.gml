#define vecCreate
/*
    vecCreate(x,y,z) 
    
    returns a new vector id using the given components.
    vector lengths are not maintained all the time. call vecLength()
*/

with slayersUpgrade
{
    if totalDeletedVectors>0
    {
        totalDeletedVectors-=1
        
        vectorx[deletedVector[totalDeletedVectors]]=argument0
        vectory[deletedVector[totalDeletedVectors]]=argument1
        vectorz[deletedVector[totalDeletedVectors]]=argument2
        vectorm[deletedVector[totalDeletedVectors]]=0
        
        return deletedVector[totalDeletedVectors]
    }
    else
    {
        vectorx[totalVectors]=argument0
        vectory[totalVectors]=argument1
        vectorz[totalVectors]=argument2
        vectorm[totalVectors]=0
        
        totalVectors+=1
        
        return totalVectors-1
    }
}

#define vecCreateCopy
/*
    vecCreateCopy(copyVector)
    
    returns a new vector just like copyVector
*/

return vecCreate(
            vecx(argument0),
            vecy(argument0),
            vecz(argument0))

#define vecDestroy
/*
    vecDestroy(vector)
    
    destroys the vector
*/

with slayersUpgrade
{
    deletedVector[totalDeletedVectors]=argument0
    
    totalDeletedVectors+=1
}

#define vecCopy
/*
    vecCopy(id,source)
    
    makes the xyz components of one vector the same as the other
*/

with slayersUpgrade 
{
    vectorx[argument0]=vectorx[argument1]
    vectory[argument0]=vectory[argument1]
    vectorz[argument0]=vectorz[argument1]
    vectorm[argument0]=vectorm[argument1]
}

#define vecx
/*
    vecx(vector)
    
    returns the x component of the given vector
*/

with slayersUpgrade return vectorx[argument0] 

#define vecy
/*
    vecy(vector)
    
    returns the y component of the given vector
*/

with slayersUpgrade return vectory[argument0]

#define vecz
/*
    vecz(vector)
    
    returns the z component of the given vector
*/

with slayersUpgrade return vectorz[argument0]

#define vecAdd
/*
    vecAdd(result,vector,add)
    
    result equals vector plus add
*/

with slayersUpgrade 
{
    vectorx[argument0]=vectorx[argument1]+vectorx[argument2]
    vectory[argument0]=vectory[argument1]+vectory[argument2]
    vectorz[argument0]=vectorz[argument1]+vectorz[argument2]
}

#define vecAddScale
/*
    vecAddScale(vResult,vPosition,vDirection,scaler)
    
    0 vResult
    1 vPosition
    2 vDirection
    3 scaler
    
    vResult equals vPosition plus vDirection scaled by scaler. 
    this is useful for quickly finding the position of a ray trace. 
*/

with slayersUpgrade 
{
    vectorx[argument0]=vectorx[argument1]+vectorx[argument2]*argument3
    vectory[argument0]=vectory[argument1]+vectory[argument2]*argument3
    vectorz[argument0]=vectorz[argument1]+vectorz[argument2]*argument3
}

#define vecSubtract
/*
    vecSubtract(result,vector,sub)
    
    result equals vector minus sub
*/

with slayersUpgrade 
{
    vectorx[argument0]=vectorx[argument1]-vectorx[argument2]
    vectory[argument0]=vectory[argument1]-vectory[argument2]
    vectorz[argument0]=vectorz[argument1]-vectorz[argument2]
}

#define vecCross
/*
    vecCross(result,vectora,vectorb)
    
    result equals the cross product of vectora and vectorb. a cross product gives you a vector perpendicular to the other two.
*/

var ax,ay,az;

with slayersUpgrade 
{
    ax=vectory[argument1]*vectorz[argument2]-vectorz[argument1]*vectory[argument2]
    ay=vectorz[argument1]*vectorx[argument2]-vectorx[argument1]*vectorz[argument2]
    az=vectorx[argument1]*vectory[argument2]-vectory[argument1]*vectorx[argument2]
    
    vectorx[argument0]=ax
    vectory[argument0]=ay
    vectorz[argument0]=az
}

#define vecCrossNormalize
/*
    vecCrossNormalize(result,vectora,vectorb)
    
    result equals the cross product of vectora and vectorb. this function also normalizes the result
*/

var ax,ay,az;

with slayersUpgrade 
{
    ax=vectory[argument1]*vectorz[argument2]-vectorz[argument1]*vectory[argument2]
    ay=vectorz[argument1]*vectorx[argument2]-vectorx[argument1]*vectorz[argument2]
    az=vectorx[argument1]*vectory[argument2]-vectory[argument1]*vectorx[argument2]
    
    m=point_distance_3d(0,0,0,ax,ay,az)
    
    if m>0
    {
        ax/=m
        ay/=m
        az/=m
    }
    
    vectorx[argument0]=ax
    vectory[argument0]=ay
    vectorz[argument0]=az
}

#define vecLength
/*
    vecLength(vector)
    
    returns the length of the vector. also sets the length component in the vector.
*/

with slayersUpgrade 
{
    vectorm[argument0]=point_distance_3d(0,0,0,vectorx[argument0],vectory[argument0],vectorz[argument0])

    return vectorm[argument0]
}

#define vecNormalize
/*
    vecNormalize(vector)
    
    scales the vector to a length of one. the vectors length component must be set by calling veclength()
*/

with slayersUpgrade 
{
    vectorx[argument0]/=vectorm[argument0]
    vectory[argument0]/=vectorm[argument0]
    vectorz[argument0]/=vectorm[argument0]
}

#define vecScale
/*
    vecScale(vResult,vector,scaler)
    
    vResult equals vector with each component scaled by scaler
*/

with slayersUpgrade 
{
    vectorx[argument0]=vectorx[argument1]*argument2
    vectory[argument0]=vectory[argument1]*argument2
    vectorz[argument0]=vectorz[argument1]*argument2
}

#define vecMultiply
/*
    vecMultiply(result,vector,vectorMultiply)
    
    result equals vector with each component multiplied by vectorMultiply's components
*/

with slayersUpgrade 
{
    vectorx[argument0]=vectorx[argument1]*vectorx[argument2]
    vectory[argument0]=vectory[argument1]*vectory[argument2]
    vectorz[argument0]=vectorz[argument1]*vectorz[argument2]
}

#define vecAddxyz
/*
    vecAddxyz(vector,x,y,z)
    
    adds x y z onto each component of vector
*/

with slayersUpgrade 
{
    vectorx[argument0]+=argument1
    vectory[argument0]+=argument2
    vectorz[argument0]+=argument3
}

#define vecSetxyz
/*
    vecSetxyz(vector,x,y,z)
    
    sets the vectors x y z components
*/

with slayersUpgrade 
{
    vectorx[argument0]=argument1
    vectory[argument0]=argument2
    vectorz[argument0]=argument3
}

#define vecSetPitchYaw
/*
    vecSetPitchYaw(vector,pitch,yaw)
    
    sets the vectors components using yaw and pitch. the vector will be a length of one.
*/

var m;

with slayersUpgrade 
{
    m=lengthdir_x(1,argument1)
    vectorx[argument0]=lengthdir_x(m,argument2)
    vectory[argument0]=lengthdir_y(m,argument2)
    vectorz[argument0]=lengthdir_y(1,argument1)
}

#define vecFromTo
/*
    vecFromTo(result,fromThisPosition,toThisOne)
    
    result euqals the vector fromThisPosition toThisOne
*/

with slayersUpgrade
{
    vectorx[argument0]=vectorx[argument2]-vectorx[argument1]
    vectory[argument0]=vectory[argument2]-vectory[argument1]
    vectorz[argument0]=vectorz[argument2]-vectorz[argument1]
}

#define vecFromToNormalize
/*
    vecFromToNormalize(result,fromThisPosition,toThisOne)
    
    same function as vecFromTo() but this normalizes the result
*/

with slayersUpgrade 
{
    vectorx[argument0]=vectorx[argument2]-vectorx[argument1]
    vectory[argument0]=vectory[argument2]-vectory[argument1]
    vectorz[argument0]=vectorz[argument2]-vectorz[argument1]
    
    vectorm[argument0]=point_distance_3d(0,0,0,vectorx[argument0],vectory[argument0],vectorz[argument0])
    
    if vectorm[argument0]>0
    {
        vectorx[argument0]/=vectorm[argument0]
        vectory[argument0]/=vectorm[argument0]
        vectorz[argument0]/=vectorm[argument0]
    }
}

#define vecDot
/*
    vecDot(vectora,vectorb)
    
    returns the dot product of the two vectors
*/

with slayersUpgrade
{
    return 
        vectorx[argument0]*vectorx[argument1]+
        vectory[argument0]*vectory[argument1]+
        vectorz[argument0]*vectorz[argument1]
}

#define vecOrtho
/*
    vecOrtho(vResult,vOrtho,vector)
    
    0 vResult
    1 vOrtho
    2 vector
    
    vResult equals vOrtho orthogonal to vector. 
    makes vOrtho perpendicular to vector. 
    this alters the length of vOrtho. 
*/

var m;

with slayersUpgrade
{
    m=  vectorx[argument2]*vectorx[argument1]+
        vectory[argument2]*vectory[argument1]+
        vectorz[argument2]*vectorz[argument1]
    
    vectorx[argument0]=vectorx[argument1]-vectorx[argument2]*m
    vectory[argument0]=vectory[argument1]-vectory[argument2]*m
    vectorz[argument0]=vectorz[argument1]-vectorz[argument2]*m
}

#define vecAngle
/*
    vecAngle(vectora,vectorb)
    
    returns the degree angle of the two vectors
*/

var d;

with slayersUpgrade
{
    d=  vectorx[argument0]*vectorx[argument1]+
        vectory[argument0]*vectory[argument1]+
        vectorz[argument0]*vectorz[argument1]
        
    if d>=1     return 0
    if d<=-1    return 180
    
    return radtodeg(arccos(d))
}

#define vecDistance
/*
    vecDistance(positiona,positionb)
    
    returns the distance between the two positions
*/

with slayersUpgrade
{
    return point_distance_3d(
                vectorx[argument0],vectory[argument0],vectorz[argument0],
                vectorx[argument1],vectory[argument1],vectorz[argument1])
}

#define vecGetPitch
/*
    vecGetPitch(vector)
    
    returns the pitch of the vector. assumes an up vector of 0 0 1
*/

with slayersUpgrade return point_direction(0,vectorz[argument0],point_distance(0,0,vectorx[argument0],vectory[argument0]),0)

#define vecGetYaw
/*
    vecGetYaw(vector)
    
    returns the yaw of the vector. assumes an up vector of 0 0 1
*/

with slayersUpgrade return point_direction(0,0,vectorx[argument0],vectory[argument0])

#define vecRotatex
/*
    vecRotatex(vector,x,y)
    
    rotates the vector around the x axis. x y should be the components of the rotation. cos(angle) and sin(angle)
*/

var t;

with slayersUpgrade
{
    t=vectory[argument0]
    
    vectory[argument0]=argument1*vectory[argument0]-argument2*vectorz[argument0]
    vectorz[argument0]=argument2*t+argument1*vectorz[argument0]
}

#define vecRotatey
/*
    vecRotatey(vector,x,y)
    
    rotates the vector around the y axis. x y should be the components of the rotation. cos(angle) and sin(angle)
*/

var t;

with slayersUpgrade
{
    t=vectorx[argument0]
    
    vectorx[argument0]=argument1*vectorx[argument0]+argument2*vectorz[argument0]
    vectorz[argument0]=argument1*vectorz[argument0]-argument2*t
}

#define vecRotatez
/*
    vecRotatez(vector,x,y)
    
    rotates the vector around the z axis. x y should be the components of the rotation. cos(angle) and sin(angle)
*/

var t;

with slayersUpgrade
{
    t=vectorx[argument0]
    
    vectorx[argument0]=argument1*vectorx[argument0]-argument2*vectory[argument0]
    vectory[argument0]=argument2*t+argument1*vectory[argument0]
}

