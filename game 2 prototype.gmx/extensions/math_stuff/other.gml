#define d3dSetProjectionQuat
/*
    d3dSetProjectionQuat(vPosition,qRotation,fov,aspect,znear,zfar)
    
    sets the projection using a position and rotation
*/

with slayersUpgrade
{
    d3d_set_projection_ext(
        vectorx[argument0],
        vectory[argument0],
        vectorz[argument0],
        
        vectorx[argument0]+sqr(quaternionw[argument1])+sqr(quaternionx[argument1])-sqr(quaterniony[argument1])-sqr(quaternionz[argument1]),
        vectory[argument0]+(quaternionx[argument1]*quaterniony[argument1]+quaternionw[argument1]*quaternionz[argument1])*2,
        vectorz[argument0]+(quaternionx[argument1]*quaternionz[argument1]-quaternionw[argument1]*quaterniony[argument1])*2,
        
        (quaternionz[argument1]*quaternionx[argument1]+quaternionw[argument1]*quaterniony[argument1])*2,
        (quaternionz[argument1]*quaterniony[argument1]-quaternionw[argument1]*quaternionx[argument1])*2,
        sqr(quaternionw[argument1])-sqr(quaternionx[argument1])-sqr(quaterniony[argument1])+sqr(quaternionz[argument1]),
        
        argument2,argument3,argument4,argument5)
}

#define d3dSetProjection
/*
    d3dSetProjection(vPosition,vForward,vUp,fov,aspect,znear,zfar)
    
    sets the projection using vectors
*/

with slayersUpgrade
{
    d3d_set_projection_ext(
        vectorx[argument0],
        vectory[argument0],
        vectorz[argument0],
        vectorx[argument0]+vectorx[argument1],
        vectory[argument0]+vectory[argument1],
        vectorz[argument0]+vectorz[argument1],
        vectorx[argument2],
        vectory[argument2],
        vectorz[argument2],argument3,argument4,argument5,argument6)
}

#define d3dTransform
/*
    d3dTransform(vPosition,qRotation)
    
    does a rotate and translate transformation using a position and rotation
*/

with slayersUpgrade
{
    d3d_transform_set_rotation_axis(
    quaternionx[argument1],
    quaterniony[argument1],
    quaternionz[argument1],
    -radtodeg(arctan2(sqrt(sqr(quaternionx[argument1])+sqr(quaterniony[argument1])+sqr(quaternionz[argument1])),quaternionw[argument1]))*2)
    
    d3d_transform_add_translation(vectorx[argument0],vectory[argument0],vectorz[argument0])
}

#define d3dSetOrtho
/*
    d3dSetOrtho(w,h)
    
    sets a basic orthographic projection. hidden 0, lighting 0, sets drawing color to black.
*/

d3d_set_hidden(0)
d3d_set_lighting(0)
d3d_set_projection_ortho(0,0,argument0,argument1,0)
draw_set_color(c_black)

#define d3dLightDefineDirection
/*
    d3dLightDefineDirection(vDirection,ind,color)
    
    defines a directional light using a vector
*/

with slayersUpgrade d3d_light_define_direction(argument1,
    vectorx[argument0],
    vectory[argument0],
    vectorz[argument0],argument2)

#define d3dModelBlock
/*
    d3dModelBlock(model,vPosition,vSize,hrepeat,vrepeat)
    
    models a block using a position and size
*/

with slayersUpgrade
{
    d3d_model_block(argument0,
        vectorx[argument1],
        vectory[argument1],
        vectorz[argument1],
        vectorx[argument1]+vectorx[argument2],
        vectory[argument1]+vectory[argument2],
        vectorz[argument1]+vectorz[argument2],argument3,argument4)
}

#define d3dDrawBlock
/*
    d3dDrawBlock(vPosition,radius)
    
    draws a block using a position and radius. useful for debugging
*/

with slayersUpgrade
{
    d3d_draw_block(
        vectorx[argument0]-argument1,
        vectory[argument0]-argument1,
        vectorz[argument0]-argument1,
        vectorx[argument0]+argument1,
        vectory[argument0]+argument1,
        vectorz[argument0]+argument1,-1,1,1)
}

