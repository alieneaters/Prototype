#define screenConvertPrep
/*
    screenConvertPrep(vCameraPosition,vForward,vUp,fov,screenw,screenh)
    
    prepares variables for converting 2d coordinates into vectors or 3d positions into 2d ones. 
    vForward and vUp vectors must be a length of one. 
    the fov must be between 1 and 179. 
    screenw and screenh must be larger than 0. 
*/

var aspect,tFov,m;

with slayersUpgrade
{
    screenConvertCamerax=vecx(argument0)
    screenConvertCameray=vecy(argument0)
    screenConvertCameraz=vecz(argument0)
    
    screenConvertDx=vecx(argument1)
    screenConvertDy=vecy(argument1)
    screenConvertDz=vecz(argument1)
    
    screenConvertUx=vecx(argument2)
    screenConvertUy=vecy(argument2)
    screenConvertUz=vecz(argument2)
    
    //if the up vector is 90 degrees from the direction vector, this isn't needed
    m=screenConvertUx*screenConvertDx+screenConvertUy*screenConvertDy+screenConvertUz*screenConvertDz
    
    screenConvertUx-=screenConvertDx*m
    screenConvertUy-=screenConvertDy*m
    screenConvertUz-=screenConvertDz*m
    
    m=point_distance_3d(0,0,0,screenConvertUx,screenConvertUy,screenConvertUz)
    
    if m>0
    {
        screenConvertUx/=m
        screenConvertUy/=m
        screenConvertUz/=m
        
        tFov=tan(argument3*pi/360)
        
        screenConvertUx*=tFov
        screenConvertUy*=tFov
        screenConvertUz*=tFov
        
        screenConvertVx=screenConvertUy*screenConvertDz-screenConvertDy*screenConvertUz
        screenConvertVy=screenConvertUz*screenConvertDx-screenConvertDz*screenConvertUx
        screenConvertVz=screenConvertUx*screenConvertDy-screenConvertDx*screenConvertUy
        
        screenConvertw=argument4
        screenConverth=argument5
        
        aspect=screenConvertw/screenConverth
        
        screenConvertSqrAspectTfov=sqr(aspect*tFov)
        screenConvertSqrTfov=sqr(tFov)
        
        screenConvertVx*=aspect
        screenConvertVy*=aspect
        screenConvertVz*=aspect
    }
}

#define screenConvertToVector
/*
    screenConvertToVector(vResult,x,y)
    
    vResult equals a vector pointing away from the camera in the direction of x y. 
    screenConvertPrep() must be called first and if there are changes to the camera. 
    if the camera doesn't move, just prep once. 
*/

var ax,ay,rx,ry,rz,m;

with slayersUpgrade
{
    ax=2*argument1/screenConvertw-1
    ay=1-2*argument2/screenConverth
    
    rx=screenConvertDx+ax*screenConvertVx+ay*screenConvertUx
    ry=screenConvertDy+ax*screenConvertVy+ay*screenConvertUy
    rz=screenConvertDz+ax*screenConvertVz+ay*screenConvertUz
    
    m=sqrt(rx*rx+ry*ry+rz*rz)
    
    if m>0
    {
        rx/=m
        ry/=m
        rz/=m
        
        vecSetxyz(argument0,rx,ry,rz)
    }
}

#define screenConvertToScreen
/*
    screenConvertToScreen(vResult,vPosition)
    
    vResult equals the 2d position on the screen the 3d vPosition lines up to. get the x y from vResult using vecGet() functions. 
    screenConvertPrep() must be called first and if there are changes to the camera. 
    if the camera doesn't move, just prep once. 
    if the 2d result is not on screen, vResult is not set. 
*/

var ax,ay,az,bx,by,m;

with slayersUpgrade
{
    ax=vecx(argument1)-screenConvertCamerax
    ay=vecy(argument1)-screenConvertCameray
    az=vecz(argument1)-screenConvertCameraz
    
    m=ax*screenConvertDx+ay*screenConvertDy+az*screenConvertDz
         
    if m>0
    {
        ax/=m
        ay/=m
        az/=m
        
        bx=((ax*screenConvertVx + ay*screenConvertVy + az*screenConvertVz)/screenConvertSqrAspectTfov+1)/2*screenConvertw
        by=(1-(ax*screenConvertUx + ay*screenConvertUy + az*screenConvertUz)/screenConvertSqrTfov)/2*screenConverth
        
        if bx>=0
        if by>=0
        if bx<=screenConvertw
        if by<=screenConverth
        {
            vecSetxyz(argument0,bx,by,0)
        }
    }
}

