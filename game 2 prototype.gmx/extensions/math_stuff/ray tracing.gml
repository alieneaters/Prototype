#define rayTracePlane
/*
    rayTracePlane(vPointOnPlane,vPlaneNormal,vRayPosition,vRayDirection,vNormalResult)
    
    0 vPointOnPlane
    1 vPlaneNormal
    2 vRayPosition
    3 vRayDirection
    4 vNormalResult
    
    returns the distance of the ray trace or -1 when there is no trace. 
    a negative distance is possible, so check that the distance returned is greater than or equal to 0. 
    this does not care which side of the plane you're on.
    sets vNormalResult to the surface normal of the ray trace. use -1 to not set it. 
*/

var m;

with slayersUpgrade
{
    m=  vectorx[argument1]*vectorx[argument3]+
        vectory[argument1]*vectory[argument3]+
        vectorz[argument1]*vectorz[argument3]
        
    if m=0 return -1
    
    if argument4>=0
    {
        if m>0
        {
            vectorx[argument4]=-vectorx[argument1]
            vectory[argument4]=-vectory[argument1]
            vectorz[argument4]=-vectorz[argument1]
        }
        else
        {
            vectorx[argument4]=vectorx[argument1]
            vectory[argument4]=vectory[argument1]
            vectorz[argument4]=vectorz[argument1]
        }
    }
    
    return (
        (vectorx[argument0]-vectorx[argument2])*vectorx[argument1]+
        (vectory[argument0]-vectory[argument2])*vectory[argument1]+
        (vectorz[argument0]-vectorz[argument2])*vectorz[argument1])/m
}

#define rayTraceTriangle
/*
    rayTraceTriangle(vPointa,vPointb,vPointc,vNormal,vRayPosition,vRayDirection,vNormalResult)
    
    0 vPointa
    1 vPointb
    2 vPointc
    3 vNormal
    4 vRayPosition
    5 vRayDirection
    6 vNormalResult
    
    returns the distance of the ray trace or -1 when there is no trace. 
    a negative distance is possible, so check that the distance returned is greater than or equal to 0. 
    this does not care which side of the triangle you're on.
    sets vNormalResult to the surface normal of the ray trace. use -1 to not set it. 
    King Stephan wrote the original version of this
*/

var rx,ry,rz,ax,ay,az,bx,by,bz,d,m;

with slayersUpgrade
{ 
    d=  vectorx[argument3]*vectorx[argument5]+
        vectory[argument3]*vectory[argument5]+
        vectorz[argument3]*vectorz[argument5]
    
    if d=0 return -1

    m= ((vectorx[argument0]-vectorx[argument4])*vectorx[argument3]+
        (vectory[argument0]-vectory[argument4])*vectory[argument3]+
        (vectorz[argument0]-vectorz[argument4])*vectorz[argument3])/d
    
    if m=0 return -1
    
    rx=vectorx[argument4]+vectorx[argument5]*m
    ry=vectory[argument4]+vectory[argument5]*m
    rz=vectorz[argument4]+vectorz[argument5]*m
    
    ax=rx-vectorx[argument0]
    ay=ry-vectory[argument0]
    az=rz-vectorz[argument0]
    bx=vectorx[argument1]-vectorx[argument0]
    by=vectory[argument1]-vectory[argument0]
    bz=vectorz[argument1]-vectorz[argument0]
    
    if (ay*bz-az*by)*vectorx[argument3]+(az*bx-ax*bz)*vectory[argument3]+(ax*by-ay*bx)*vectorz[argument3]>1 return -1
    
    ax=rx-vectorx[argument1]
    ay=ry-vectory[argument1]
    az=rz-vectorz[argument1]
    bx=vectorx[argument2]-vectorx[argument1]
    by=vectory[argument2]-vectory[argument1]
    bz=vectorz[argument2]-vectorz[argument1]

    if (ay*bz-az*by)*vectorx[argument3]+(az*bx-ax*bz)*vectory[argument3]+(ax*by-ay*bx)*vectorz[argument3]>1 return -1

    ax=rx-vectorx[argument2]
    ay=ry-vectory[argument2]
    az=rz-vectorz[argument2]
    bx=vectorx[argument0]-vectorx[argument2]
    by=vectory[argument0]-vectory[argument2]
    bz=vectorz[argument0]-vectorz[argument2]
    
    if (ay*bz-az*by)*vectorx[argument3]+(az*bx-ax*bz)*vectory[argument3]+(ax*by-ay*bx)*vectorz[argument3]>1 return -1
    
    if argument4>=0
    {
        if d>0
        {
            vectorx[argument6]=-vectorx[argument3]
            vectory[argument6]=-vectory[argument3]
            vectorz[argument6]=-vectorz[argument3]
        }
        else
        {
            vectorx[argument6]=vectorx[argument3]
            vectory[argument6]=vectory[argument3]
            vectorz[argument6]=vectorz[argument3]
        }
    }
    
    return m
}

#define rayTraceBlock
/*
    rayTraceBlock(vBoxPosition,vBoxSize,vRayPosition,vRayDirection,vNormalResult)
    
    0 vBoxPosition
    1 vBoxSize
    2 vRayPosition
    3 vRayDirection
    4 vNormalResult
    
    returns the distance of the ray trace or -1 when there is no trace. 
    sets vNormalResult to the surface normal of the ray trace. use -1 to not set it. 
    the rayPosition must be outside of the block to successfully ray trace it. 
*/

var xx,yy,zz,bx,by,bz,d;

with slayersUpgrade
{
    bx=vectorx[argument0]+vectorx[argument1]
    by=vectory[argument0]+vectory[argument1]
    bz=vectorz[argument0]+vectorz[argument1]
    
    if vectorx[argument3]>0
    {
        if vectorx[argument2]<=vectorx[argument0]
        {
            m=(vectorx[argument0]-vectorx[argument2])/vectorx[argument3]
            yy=vectory[argument2]+vectory[argument3]*m
    
            if yy>=vectory[argument0]
            if yy<=by
            {
                zz=vectorz[argument2]+vectorz[argument3]*m
                
                if zz>=vectorz[argument0]
                if zz<=bz
                {
                    if argument4>=0 vecSetxyz(argument4,-1,0,0)
                    
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
    
            if yy>=vectory[argument0]
            if yy<=by
            {
                zz=vectorz[argument2]+vectorz[argument3]*m
                
                if zz>=vectorz[argument0]
                if zz<=bz
                {
                    if argument4>=0 vecSetxyz(argument4,1,0,0)
                    
                    return m
                }
            }
        }
    }
    
    if vectory[argument3]>0 
    {
        if vectory[argument2]<=vectory[argument0] 
        {
            m=(vectory[argument0]-vectory[argument2])/vectory[argument3]
            xx=vectorx[argument2]+vectorx[argument3]*m
    
            if xx>=vectorx[argument0] 
            if xx<=bx
            {
                zz=vectorz[argument2]+vectorz[argument3]*m
                
                if zz>=vectorz[argument0] 
                if zz<=bz 
                {
                    if argument4>=0 vecSetxyz(argument4,0,-1,0)
                    
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
    
            if xx>=vectorx[argument0] 
            if xx<=bx
            {
                zz=vectorz[argument2]+vectorz[argument3]*m
                
                if zz>=vectorz[argument0] 
                if zz<=bz 
                {
                    if argument4>=0 vecSetxyz(argument4,0,1,0)
                    
                    return m
                }
            }
        }
    }
    
    if vectorz[argument3]>0 
    {
        if vectorz[argument2]<=vectorz[argument0] 
        {
            m=(vectorz[argument0]-vectorz[argument2])/vectorz[argument3]
            xx=vectorx[argument2]+vectorx[argument3]*m
    
            if xx>=vectorx[argument0] 
            if xx<=bx
            {
                yy=vectory[argument2]+vectory[argument3]*m
                
                if yy>=vectory[argument0] 
                if yy<=by 
                {
                    if argument4>=0 vecSetxyz(argument4,0,0,-1)
                    
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
    
            if xx>=vectorx[argument0] 
            if xx<=bx
            {
                yy=vectory[argument2]+vectory[argument3]*m
                
                if yy>=vectory[argument0] 
                if yy<=by 
                {
                    if argument4>=0 vecSetxyz(argument4,0,0,1)
                    
                    return m
                }
            }
        }
    }
    
    return -1
}

#define rayTraceBlockInside
/*
    rayTraceBlockInside(vBoxPosition,vBoxSize,vRayPosition,vRayDirection,vNormalResult)
    
    0 vBoxPosition
    1 vBoxSize
    2 vRayPosition
    3 vRayDirection
    4 vNormalResult
    
    returns the distance of the ray trace or -1 when there is no trace. 
    sets vNormalResult to the surface normal of the ray trace. use -1 to not set it. 
    the rayPosition must can be inside or outside the block to ray trace it. 
    this ray traces the iside of the box walls only.
*/

var xx,yy,zz,bx,by,bz,d;

with slayersUpgrade
{
    bx=vectorx[argument0]+vectorx[argument1]
    by=vectory[argument0]+vectory[argument1]
    bz=vectorz[argument0]+vectorz[argument1]
    
    if vectorx[argument3]>0
    {
        if vectorx[argument2]<=bx
        {
            m=(bx-vectorx[argument2])/vectorx[argument3]
            yy=vectory[argument2]+vectory[argument3]*m
    
            if yy>=vectory[argument0]
            if yy<=by
            {
                zz=vectorz[argument2]+vectorz[argument3]*m
                
                if zz>=vectorz[argument0]
                if zz<=bz
                {
                    if argument4>=0 vecSetxyz(argument4,-1,0,0)
                    
                    return m
                }
            }
        }
    }
    else if vectorx[argument3]<0
    {
        if vectorx[argument2]>=vectorx[argument0]
        {
            m=(vectorx[argument0]-vectorx[argument2])/vectorx[argument3]
            yy=vectory[argument2]+vectory[argument3]*m
    
            if yy>=vectory[argument0]
            if yy<=by
            {
                zz=vectorz[argument2]+vectorz[argument3]*m
                
                if zz>=vectorz[argument0]
                if zz<=bz
                {
                    if argument4>=0 vecSetxyz(argument4,1,0,0)
                    
                    return m
                }
            }
        }
    }
    
    if vectory[argument3]>0 
    {
        if vectory[argument2]<=by 
        {
            m=(by-vectory[argument2])/vectory[argument3]
            xx=vectorx[argument2]+vectorx[argument3]*m
    
            if xx>=vectorx[argument0] 
            if xx<=bx
            {
                zz=vectorz[argument2]+vectorz[argument3]*m
                
                if zz>=vectorz[argument0] 
                if zz<=bz 
                {
                    if argument4>=0 vecSetxyz(argument4,0,-1,0)
                    
                    return m
                }
            }
        }
    }
    else if vectory[argument3]<0
    {
        if vectory[argument2]>=vectory[argument0] 
        {
            m=(vectory[argument0]-vectory[argument2])/vectory[argument3]
            xx=vectorx[argument2]+vectorx[argument3]*m
    
            if xx>=vectorx[argument0] 
            if xx<=bx
            {
                zz=vectorz[argument2]+vectorz[argument3]*m
                
                if zz>=vectorz[argument0] 
                if zz<=bz 
                {
                    if argument4>=0 vecSetxyz(argument4,0,1,0)
                    
                    return m
                }
            }
        }
    }
    
    if vectorz[argument3]>0 
    {
        if vectorz[argument2]<=bz 
        {
            m=(bz-vectorz[argument2])/vectorz[argument3]
            xx=vectorx[argument2]+vectorx[argument3]*m
    
            if xx>=vectorx[argument0] 
            if xx<=bx
            {
                yy=vectory[argument2]+vectory[argument3]*m
                
                if yy>=vectory[argument0] 
                if yy<=by 
                {
                    if argument4>=0 vecSetxyz(argument4,0,0,-1)
                    
                    return m
                }
            }
        }
    }
    else if vectorz[argument3]<0 
    {
        if vectorz[argument2]>=vectorz[argument0] 
        {
            m=(vectorz[argument0]-vectorz[argument2])/vectorz[argument3]
            xx=vectorx[argument2]+vectorx[argument3]*m
    
            if xx>=vectorx[argument0] 
            if xx<=bx
            {
                yy=vectory[argument2]+vectory[argument3]*m
                
                if yy>=vectory[argument0] 
                if yy<=by 
                {
                    if argument4>=0 vecSetxyz(argument4,0,0,1)
                    
                    return m
                }
            }
        }
    }
    
    return -1
}

#define rayTraceSphere
/*
    rayTraceSphere(spherePosition,radius,rayPosition,rayDirection,vNormalResult)
    
    0 spherePosition
    1 radius
    2 rayPosition
    3 rayDirection
    4 vNormalResult
    
    returns the distance of the ray trace or -1 when there is no trace. 
    sets vNormalResult to the normal of the ray trace. use -1 to not set it. 
    the rayPosition must be outside of the sphere to successfully ray trace it. 
    Tepi wrote the original version of this. 
*/

var ax,ay,az,A,B,C,m;

with slayersUpgrade
{
    m = sqr(argument1)
    
    ax = vectorx[argument2] - vectorx[argument0]
    ay = vectory[argument2] - vectory[argument0]
    az = vectorz[argument2] - vectorz[argument0]
    
    A = (vectorx[argument3] * vectorx[argument3] +  vectory[argument3] * vectory[argument3]  +  vectorz[argument3] * vectorz[argument3])/m
    B = (vectorx[argument3] * ax +  vectory[argument3] * ay  +  vectorz[argument3] * az)/m
    C = (ax * ax +  ay * ay  +  az * az)/m - 1

    C=B*B-A*C
    
    if C<0 return -1
    
    m=-(B+sqrt(C))/A
    
    if argument4>=0
    {
        ax=vectorx[argument2]+vectorx[argument3]*m
        ay=vectory[argument2]+vectory[argument3]*m
        az=vectorz[argument2]+vectorz[argument3]*m
        
        ax=ax-vectorx[argument0]
        ay=ay-vectory[argument0]
        az=az-vectorz[argument0]
        
        A=point_distance_3d(0,0,0,ax,ay,az)
    
        if A>0
        {
            vectorx[argument4]=ax/A
            vectory[argument4]=ay/A
            vectorz[argument4]=az/A
        }
    }
    
    return m
}

#define rayTraceCylinder
/*
    rayTraceCylinder(vPosition,height,radius,vRayPosition,vRayDirection,vNormalResult)
    
    0 vPosition
    1 height
    2 radius
    3 vRayPosition
    4 vRayDirection
    5 vNormalResult
    
    the cylinder stands up and down in the z axis. 
    sets vNormalResult to the surface normal of the ray trace. use -1 to not set it. 
    you must be outside of the cylinder to ray trce it. 
    returns the distance of the ray trace or -1 when there is no trace. 
    Tepi wrote the original version of this. 
*/

var ax,ay,az,bz,cx,cy,cz,A,B,C,d,m;

with slayersUpgrade
{
    m = sqr(argument2)

    ax = vectorx[argument3] - vectorx[argument0]
    ay = vectory[argument3] - vectory[argument0]
    az = vectorz[argument3] - vectorz[argument0]
    
    bz=vectorz[argument0]+argument1
    
    A = (vectorx[argument4] * vectorx[argument4]+  vectory[argument4] * vectory[argument4])/m
    B = (vectorx[argument4] * ax  +  vectory[argument4] * ay)/m
    C = (ax * ax  +  ay * ay)/m  -  1
    C = B*B - A*C

    if C<0 return -1
    
    d=-(B+sqrt(C))/A
    
    cz=vectorz[argument3]+vectorz[argument4]*d
    
    if cz>bz
    {
        if vectorz[argument4]>0     return -1
        if vectorz[argument3]<bz    return -1
        
        d=(bz-vectorz[argument3])/vectorz[argument4]
        
        if point_distance(
            vectorx[argument0],
            vectory[argument0],
            vectorx[argument3]+vectorx[argument4]*d,
            vectory[argument3]+vectory[argument4]*d)>argument2 return -1
        
        if argument5>=0 vecSetxyz(argument5,0,0,1)
            
        return d
    }

    if cz<vectorz[argument0]
    {
        if vectorz[argument4]<0                     return -1
        if vectorz[argument3]>vectorz[argument0]    return -1
        
        d=(vectorz[argument0]-vectorz[argument3])/vectorz[argument4]
        
        if point_distance(
            vectorx[argument0],
            vectory[argument0],
            vectorx[argument3]+vectorx[argument4]*d,
            vectory[argument3]+vectory[argument4]*d)>argument2 return -1
        
        if argument5>=0 vecSetxyz(argument5,0,0,-1)
            
        return d
    }
    
    if argument5>=0
    {
        cx=vectorx[argument3]+vectorx[argument4]*d
        cy=vectory[argument3]+vectory[argument4]*d
        
        cx=cx-vectorx[argument0]
        cy=cy-vectory[argument0]
        
        m=point_distance(0,0,cx,cy)
        
        if m>0 vecSetxyz(argument5,cx/m,cy/m,0)
    }
    
    return d
}

#define rayTraceCone
/*
    rayTraceCone(vConePosition,height,radius,vRayPosition,vRayDirection,vNormalResult)
    
    0 vConePosition
    1 height
    2 radius
    3 vRayPosition
    4 vRayDirection
    5 vNormalResult
    
    returns the distance of the ray trace or -1 when there is no trace. 
    you must be outside of the cone to ray trce it. 
    height and radius must be larger than 0. 
*/

with slayersUpgrade
{
    var a,b,c, A,B,C, x0,y0,z0, d;
    
    bz=vectorz[argument0]+argument1
    
    a = sqr(argument2*2)/4
    b = sqr(argument2*2)/4
    c = argument1
    
    x0 = vectorx[argument3] - vectorx[argument0]
    y0 = vectory[argument3] - vectory[argument0]
    z0 = vectorz[argument3] - bz
    
    A = vectorx[argument4] * vectorx[argument4] / a  +  vectory[argument4] * vectory[argument4] / b  -  vectorz[argument4] * vectorz[argument4] / c / c
    B = vectorx[argument4] * x0 / a  +  vectory[argument4] * y0 / b  -  vectorz[argument4] * z0 / c / c
    C = x0 * x0 / a  +  y0 * y0 / b  -  z0 * z0 / c / c
    C = B * B  -  A * C
    
    if C < 0 return 0
    
    d=-(B+sqrt(C))/A
    
    cz=vectorz[argument3]+vectorz[argument4]*d
    
    if cz>bz return -1

    if cz<vectorz[argument0]
    {
        if vectorz[argument4]<0                     return -1
        if vectorz[argument3]>vectorz[argument0]    return -1
        
        d=(vectorz[argument0]-vectorz[argument3])/vectorz[argument4]
        
        if point_distance(
            vectorx[argument0],
            vectory[argument0],
            vectorx[argument3]+vectorx[argument4]*d,
            vectory[argument3]+vectory[argument4]*d)>argument2 return -1
        
        if argument5>=0 vecSetxyz(argument5,0,0,-1)
            
        return d
    }
    
    if argument5>=0
    {
        cx=vectorx[argument3]+vectorx[argument4]*d
        cy=vectory[argument3]+vectory[argument4]*d
        
        cx = 2*(cx - vectorx[argument0])/a
        cy = 2*(cy - vectory[argument0])/b
        cz = -2 *(cz - bz)/c/c
        
        m=point_distance_3d(0,0,0,cx,cy,cz)
        
        if m>0 vecSetxyz(argument5,cx/m,cy/m,cz/m)
    }
    
    return d
}

#define rayTraceShape
/*
    rayTraceShape(shape,vRayPosition,vRayDirection,vNormalResult)
    
    0 shape
    1 vRayPosition
    2 vRayDirection
    3 vNormalResult
    
    returns the distance of the ray trace or -1 when there is no trace.
    this ray trace can only happen in unrotated axis aligned space. 
    if the shape is rotated you must use the space scripts to
    convert the ray from world space into the shapes space.
    WILL NOT RAY TRACE CONE SHAPES
*/

with slayersUpgrade
{
    switch shapeType[argument0]
    {
        case PLANE:         return rayTracePlane(shapePosition[argument0],shapeNormal[argument0],argument1,argument2,argument3)
        case TRIANGLE:      return rayTraceTriangle(shapePointa[argument0],shapePointb[argument0],shapePointc[argument0],shapeNormal[argument0],argument1,argument2,argument3)
        case BLOCK:         return rayTraceBlock(shapePosition[argument0],shapeSize[argument0],argument1,argument2,argument3)
        case SPHERE:        return rayTraceSphere(shapePosition[argument0],shapeRadius[argument0],argument1,argument2,argument3)
        case CYLINDER:      return rayTraceCylinder(shapePosition[argument0],shapeHeight[argument0],shapeRadius[argument0],argument1,argument2,argument3)
        case CONE:          return rayTraceCone(shapePosition[argument0],shapeHeight[argument0],shapeRadius[argument0],argument1,argument2,argument3)
        case BLOCKINSIDE:   return rayTraceBlockInside(shapePosition[argument0],shapeSize[argument0],argument1,argument2,argument3)
    }
}

return -1

