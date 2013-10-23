#define shapeCreate
/*
    shapeCreate()

    returns a new shape
*/

with slayersUpgrade
{
    if totalDeletedShapes>0
    {
        totalDeletedShapes-=1
        
        shapeType[totalDeletedShapes]=-1
        
        return deletedShape[totalDeletedShapes]
    }
    else
    {
        shapeType[totalShapes]=-1
        
        totalShapes+=1
        
        return totalShapes-1
    }
}

#define shapeDestroy
/*
    shapeDestroy(shape)
    
    destroys the shape
*/

with slayersUpgrade
{
    shapeType[argument0]=-1
    
    deletedShape[totalDeletedShapes]=argument0
    
    totalDeletedShapes+=1
}

#define shapeSetPlane
/*
    shapeSetPlane(shape,vPosition,vNormal)
    
    sets the shapes type to a plane. the plane is defined using a position and normal
*/

with slayersUpgrade
{
    shapeType[argument0]=PLANE
    shapePosition[argument0]=argument1
    shapeNormal[argument0]=argument2
}

#define shapeSetTriangle
/*
    shapeSetTriangle(shape,vPointa,vPointb,vPointc,vNormal)
    
    sets the shapes type to a triangle. the triangle is defined using three points and a normal. you must calculate the normal.
*/

with slayersUpgrade
{
    shapeType[argument0]=TRIANGLE
    shapePointa[argument0]=argument1
    shapePointb[argument0]=argument2
    shapePointc[argument0]=argument3
    shapeNormal[argument0]=argument4
}

#define shapeSetBlock
/*
    shapeSetBlock(shape,vPosition,vSize)
    
    sets the shapes type to a block. the block is defined using a position and size
*/

with slayersUpgrade
{
    shapeType[argument0]=BLOCK
    shapePosition[argument0]=argument1
    shapeSize[argument0]=argument2
}

#define shapeSetBlockInside
/*
    shapeSetBlockInside(shape,vPosition,vSize)
    
    sets the shapes type to an inside out block. the block is defined using a position and size
*/

with slayersUpgrade
{
    shapeType[argument0]=BLOCKINSIDE
    shapePosition[argument0]=argument1
    shapeSize[argument0]=argument2
}

#define shapeSetSphere
/*
    shapeSetSphere(shape,vPosition,radius)
    
    sets the shapes type to a sphere. the sphere is defined by a position and radius
*/

with slayersUpgrade
{
    shapeType[argument0]=SPHERE
    shapePosition[argument0]=argument1
    shapeRadius[argument0]=argument2
}

#define shapeSetCylinder
/*
    shapeSetCylinder(shape,vPosition,height,radius)
    
    sets the shapes type to a cylinder. the cylinder is defined by a position, height, and radius.
*/

with slayersUpgrade
{
    shapeType[argument0]=CYLINDER
    shapePosition[argument0]=argument1
    shapeHeight[argument0]=argument2
    shapeRadius[argument0]=argument3
}

#define shapeSetCone
/*
    shapeSetCone(shape,vPosition,height,radius)
    
    sets the shapes type to a cone. the cone is defined by a position, height, and radius.
*/

with slayersUpgrade
{
    shapeType[argument0]=CONE
    shapePosition[argument0]=argument1
    shapeHeight[argument0]=argument2
    shapeRadius[argument0]=argument3
}

#define shapeGetType
/*
    shapeGetType(shape)
    
    returns the type of the shape. PLANE=0 TRIANGLE=1 BLOCK=2 SPHERE=3 CYLINDER=4 CONE=5
*/

with slayersUpgrade return shapeType[argument0]

