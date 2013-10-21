#define extraTracePlane
/*
    extraTracePlane(vPointOnPlane,vPlaneNormal,vRayPosition,vRayDirection,extraDistace,vNormalResult)
    
    0 vPointOnPlane
    1 vPlaneNormal
    2 vRayPosition
    3 vRayDirection
    4 extraDistace
    5 vNormalResult
    
    this ray traces a block onto a plane by using extraDistace. 
    returns the distance of the ray trace or -1 when there is no trace. 
    a negative distance is possible, so check that the distance returned is greater than or equal to 0. 
    this does not care which side of the plane you're on. 
    sets vNormalResult to the surface normal of the ray trace. use -1 to not set it. 
*/

var ax,ay,az,m;

with slayersUpgrade
{
    m=  vectorx[argument1]*vectorx[argument3]+
        vectory[argument1]*vectory[argument3]+
        vectorz[argument1]*vectorz[argument3]
        
    if m>0
    {
        ax=vectorx[argument0]-vectorx[argument1]*argument4
        ay=vectory[argument0]-vectory[argument1]*argument4
        az=vectorz[argument0]-vectorz[argument1]*argument4
        
        if argument5>=0
        {
            vectorx[argument5]=-vectorx[argument1]
            vectory[argument5]=-vectory[argument1]
            vectorz[argument5]=-vectorz[argument1]
        }
    }
    else if m<0
    {
        ax=vectorx[argument0]+vectorx[argument1]*argument4
        ay=vectory[argument0]+vectory[argument1]*argument4
        az=vectorz[argument0]+vectorz[argument1]*argument4
        
        if argument5>=0
        {
            vectorx[argument5]=vectorx[argument1]
            vectory[argument5]=vectory[argument1]
            vectorz[argument5]=vectorz[argument1]
        }
    }
    else return -1
    
    return (
        (ax-vectorx[argument2])*vectorx[argument1]+
        (ay-vectory[argument2])*vectory[argument1]+
        (az-vectorz[argument2])*vectorz[argument1])/m
}

#define extraTraceBlock
/*
    extraTraceBlock(vBoxPosition,vBoxSize,vRayPosition,vRayDirection,halfSize,vNormalResult)
    
    0 vBoxPosition
    1 vBoxSize
    2 vRayPosition
    3 vRayDirection
    4 halfSize
    5 vNormalResult
      
    ray traces a block onto another block. 
    the block being ray traced onto uses it's corner as it's origin. 
    the block doing the ray trace has a halfSize and centered origin. 
    returns the distance of the ray trace or -1 when there is no trace. 
    sets vNormalResult to the surface normal of the ray trace. use -1 to not set it. 
*/

var xx,yy,zz,ax,ay,az,bx,by,bz,d;

with slayersUpgrade
{
    ax=vectorx[argument0]-argument4
    ay=vectory[argument0]-argument4
    az=vectorz[argument0]-argument4
    
    bx=vectorx[argument0]+vectorx[argument1]+argument4
    by=vectory[argument0]+vectory[argument1]+argument4
    bz=vectorz[argument0]+vectorz[argument1]+argument4
    
    if vectorx[argument3]>0
    {
        if vectorx[argument2]<=ax
        {
            m=(ax-vectorx[argument2])/vectorx[argument3]
            yy=vectory[argument2]+vectory[argument3]*m
    
            if yy>ay
            if yy<by
            {
                zz=vectorz[argument2]+vectorz[argument3]*m
                
                if zz>az
                if zz<bz
                {
                    if argument5>=0 vecSetxyz(argument5,-1,0,0)
                    
                    return m
                }
            }
        }
    }
    else if vectorx[argument3]<0
    {
        if vectorx[argument2]>=bx
        {
            m=(bx-vectorx[argument2])/vectorx[argument3]
            yy=vectory[argument2]+vectory[argument3]*m
    
            if yy>ay
            if yy<by
            {
                zz=vectorz[argument2]+vectorz[argument3]*m
                
                if zz>az
                if zz<bz
                {
                    if argument5>=0 vecSetxyz(argument5,1,0,0)
                    
                    return m
                }
            }
        }
    }
    
    if vectory[argument3]>0 
    {
        if vectory[argument2]<=ay
        {
            m=(ay-vectory[argument2])/vectory[argument3]
            xx=vectorx[argument2]+vectorx[argument3]*m
    
            if xx>ax
            if xx<bx
            {
                zz=vectorz[argument2]+vectorz[argument3]*m
                
                if zz>az
                if zz<bz 
                {
                    if argument5>=0 vecSetxyz(argument5,0,-1,0)
                    
                    return m
                }
            }
        }
    }
    else if vectory[argument3]<0 
    {
        if vectory[argument2]>=by 
        {
            m=(by-vectory[argument2])/vectory[argument3]
            xx=vectorx[argument2]+vectorx[argument3]*m
    
            if xx>ax
            if xx<bx
            {
                zz=vectorz[argument2]+vectorz[argument3]*m
                
                if zz>az
                if zz<bz 
                {
                    if argument5>=0 vecSetxyz(argument5,0,1,0)
                    
                    return m
                }
            }
        }
    }
    
    if vectorz[argument3]>0 
    {
        if vectorz[argument2]<=az
        {
            m=(az-vectorz[argument2])/vectorz[argument3]
            xx=vectorx[argument2]+vectorx[argument3]*m
    
            if xx>ax
            if xx<bx
            {
                yy=vectory[argument2]+vectory[argument3]*m
                
                if yy>ay
                if yy<by 
                {
                    if argument5>=0 vecSetxyz(argument5,0,0,-1)
                    
                    return m
                }
            }
        }
    }
    else if vectorz[argument3]<0 
    {
        if vectorz[argument2]>=bz 
        {
            m=(bz-vectorz[argument2])/vectorz[argument3]
            xx=vectorx[argument2]+vectorx[argument3]*m
    
            if xx>ax
            if xx<bx
            {
                yy=vectory[argument2]+vectory[argument3]*m
                
                if yy>ay
                if yy<by 
                {
                    if argument5>=0 vecSetxyz(argument5,0,0,1)
                    
                    return m
                }
            }
        }
    }
    
    return -1
}

#define extraTraceCylinder
/*
    extraTraceCylinder(vCylinderPosition,cylinderHeight,cylinderRadius,vRayPosition,vRayDirection,extraDistance,vNormalResult)
    
    0 vCylinderPosition
    1 cylinderHeight
    2 cylinderRadius
    3 vRayPosition
    4 vRayDirection
    5 extraDistance
    6 vNormalResult
    
    ray traces onto a cylinder with extraDistance added onto the cylinderHeight and cylinderRadius. 
    returns the distance of the ray trace or -1 when there is no trace. 
    sets vNormalResult to the surface normal of the ray trace. use -1 to not set it. 
*/

return rayTraceCylinder(argument0,argument1+argument5,argument2+argument5,argument3,argument4,argument6)

#define extraTraceSphere
/*
    extraTraceSphere(vSpherePosition,radius,vRayPosition,vRayDirection,extraTrace,vNormalResult)
    
    0 vSpherePosition
    1 radius
    2 vRayPosition
    3 vRayDirection
    4 extraTrace
    5 vNormalResult
    
    this ray traces a sphere onto another sphere. 
    the first two arguments are the sphere you'll be sphere tracing onto. 
    returns the distance of the ray trace or -1 when there is no trace. 
    sets vNormalResult to the surface normal of the ray trace. use -1 to not set it. 
*/

return rayTraceSphere(argument0,argument1+argument4,argument2,argument3,argument5)

#define extraTraceCone
/*
    extraTraceCone(vConePosition,coneHeight,coneRadius,vRayPosition,vRayDirection,extraDistance,vNormalResult)
    
    0 vCylinderPosition
    1 cylinderHeight
    2 cylinderRadius
    3 vRayPosition
    4 vRayDirection
    5 extraDistance
    6 vNormalResult
    
    ray traces onto a cone with extraDistance added onto the coneHeight and coneRadius. 
    returns the distance of the ray trace or -1 when there is no trace. 
    sets vNormalResult to the surface normal of the ray trace. use -1 to not set it. 
*/

var vPosition,vSize,m;

vPosition=vecCreateCopy(argument0)
vecAddxyz(vPosition,0,0,-argument5)

//rayTraceCone(vConePosition,height,radius,vRayPosition,vRayDirection,vNormalResult)

m=rayTraceCone(vPosition,argument1+argument5*2.5,argument2+argument5,argument3,argument4,argument6)

vecDestroy(vPosition)

return m

#define extraTraceShape
/*
    extraTraceShape(shape,vRayPosition,vRayDirection,extraDistance,vNormalResult)
    
    0 shape
    1 vRayPosition
    2 vRayDirection
    3 extraDistance
    4 vNormalResult
    
    returns the distance of the ray trace or -1 when there is no trace. 
    this ray trace can only happen in unrotated axis aligned space. 
    if the shape is rotated you must use the space scripts to convert the ray from world space into the shapes space. 
    will not ray trace triangles
*/

with slayersUpgrade
{
    switch shapeType[argument0]
    {
        case PLANE:      return extraTracePlane(shapePosition[argument0],shapeNormal[argument0],argument1,argument2,argument3,argument4)
        //case TRIANGLE:   return extraTraceTriangle(shapePointa[argument0],shapePointb[argument0],shapePointc[argument0],shapeNormal[argument0],argument1,argument2,argument3,argument4)
        case BLOCK:      return extraTraceBlock(shapePosition[argument0],shapeSize[argument0],argument1,argument2,argument3,argument4)
        case SPHERE:     return extraTraceSphere(shapePosition[argument0],shapeRadius[argument0],argument1,argument2,argument3,argument4)
        case CYLINDER:   return extraTraceCylinder(shapePosition[argument0],shapeHeight[argument0],shapeRadius[argument0],argument1,argument2,argument3,argument4)
        case CONE:       return extraTraceCone(shapePosition[argument0],shapeHeight[argument0],shapeRadius[argument0],argument1,argument2,argument3,argument4)
    }
}

return -1

