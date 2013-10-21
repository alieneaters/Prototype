#define spaceCreate
/*
    spaceCreate(vPosition)
    
    returns a new space id. 
    vPosition is the vector to refrence for the position of the space. 
    don't delete vPosition until this space is deleted.
*/

with slayersUpgrade
{
    if totalDeletedSpaces>0
    {
        totalDeletedSpaces-=1
        
        spacePosition[deletedSpace[totalDeletedSpaces]]=argument0
        
        spaceAx[deletedSpace[totalDeletedSpaces]]=1
        spaceAy[deletedSpace[totalDeletedSpaces]]=0
        spaceAz[deletedSpace[totalDeletedSpaces]]=0
        
        spaceBx[deletedSpace[totalDeletedSpaces]]=0
        spaceBy[deletedSpace[totalDeletedSpaces]]=1
        spaceBz[deletedSpace[totalDeletedSpaces]]=0
        
        spaceCx[deletedSpace[totalDeletedSpaces]]=0
        spaceCy[deletedSpace[totalDeletedSpaces]]=0
        spaceCz[deletedSpace[totalDeletedSpaces]]=1
        
        return deletedSpace[totalDeletedSpaces]
    }
    else
    {
        spacePosition[totalSpaces]=argument0
        
        spaceAx[totalSpaces]=1
        spaceAy[totalSpaces]=0
        spaceAz[totalSpaces]=0
        
        spaceBx[totalSpaces]=0
        spaceBy[totalSpaces]=1
        spaceBz[totalSpaces]=0
        
        spaceCx[totalSpaces]=0
        spaceCy[totalSpaces]=0
        spaceCz[totalSpaces]=1
        
        totalSpaces+=1
        
        return totalSpaces-1
    }
}

#define spaceDestroy
/*
    spaceDestroy(space)
    
    destroys the space
*/

with slayersUpgrade
{
    deletedSpace[totalDeletedSpaces]=argument0
    
    totalDeletedSpaces+=1
}

#define spacePrepNone
/*
    spacePrepNone(space)
    
    sets the orientation of the space to no orientation at all. this is the same as setting it to world coordinates.
    
*/

with slayersUpgrade
{
    spaceAx[argument0]=1
    spaceAy[argument0]=0
    spaceAz[argument0]=0
    
    spaceBx[argument0]=0
    spaceBy[argument0]=1
    spaceBz[argument0]=0
    
    spaceCx[argument0]=0
    spaceCy[argument0]=0
    spaceCz[argument0]=1
}

#define spacePrepQuat
/*
    spacePrepQuat(space,quat)
    
    sets the orientation of the space using the quaternion. 
    you only have to prep when the orientation of the space changes. 
*/

with slayersUpgrade
{
    spaceAx[argument0]=sqr(quaternionw[argument1])+sqr(quaternionx[argument1])-sqr(quaterniony[argument1])-sqr(quaternionz[argument1])
    spaceAy[argument0]=(quaternionx[argument1]*quaterniony[argument1]+quaternionw[argument1]*quaternionz[argument1])*2
    spaceAz[argument0]=(quaternionx[argument1]*quaternionz[argument1]-quaternionw[argument1]*quaterniony[argument1])*2
    
    spaceBx[argument0]=(quaterniony[argument1]*quaternionx[argument1]-quaternionw[argument1]*quaternionz[argument1])*2
    spaceBy[argument0]=sqr(quaternionw[argument1])-sqr(quaternionx[argument1])+sqr(quaterniony[argument1])-sqr(quaternionz[argument1])
    spaceBz[argument0]=(quaterniony[argument1]*quaternionz[argument1]+quaternionw[argument1]*quaternionx[argument1])*2
    
    spaceCx[argument0]=(quaternionz[argument1]*quaternionx[argument1]+quaternionw[argument1]*quaterniony[argument1])*2
    spaceCy[argument0]=(quaternionz[argument1]*quaterniony[argument1]-quaternionw[argument1]*quaternionx[argument1])*2
    spaceCz[argument0]=sqr(quaternionw[argument1])-sqr(quaternionx[argument1])-sqr(quaterniony[argument1])+sqr(quaternionz[argument1])
}

#define spacePrepVectors
/*
    spacePrepVectors(space,vForward,vSide,vUp)
    
    sets the orientation of the space using three vectors. 
    each vector must be a length of one and perpendicular to the others. 
    vForward is positive x. 
    vSide is positive y. 
    vUp is positive z. 
    you only have to prep when the orientation of the space changes. 
*/

with slayersUpgrade
{
    spaceAx[argument0]=vectorx[argument1]
    spaceAy[argument0]=vectory[argument1]
    spaceAz[argument0]=vectorz[argument1]
    
    spaceBx[argument0]=vectorx[argument2]
    spaceBy[argument0]=vectory[argument2]
    spaceBz[argument0]=vectorz[argument2]
    
    spaceCx[argument0]=vectorx[argument3]
    spaceCy[argument0]=vectory[argument3]
    spaceCz[argument0]=vectorz[argument3]
}

#define spaceConvertIn
/*
    spaceConvertIn(space,vResult,vector)
    
    0 space
    1 vResult
    2 vector
    
    vResult equals the vector converted into the space. make sure to prep the spaces orientation.
*/

var ax,ay,az;

with slayersUpgrade
{
    ax=spaceAx[argument0]*vectorx[argument2]+spaceAy[argument0]*vectory[argument2]+spaceAz[argument0]*vectorz[argument2]
    ay=spaceBx[argument0]*vectorx[argument2]+spaceBy[argument0]*vectory[argument2]+spaceBz[argument0]*vectorz[argument2]
    az=spaceCx[argument0]*vectorx[argument2]+spaceCy[argument0]*vectory[argument2]+spaceCz[argument0]*vectorz[argument2]
    
    vectorx[argument1]=ax
    vectory[argument1]=ay
    vectorz[argument1]=az
}

#define spaceConvertOut
/*
    spaceConvertOut(space,vResult,vector)
    
    vResult equals the vector converted out of the space. this is the reverse of spaceConvertIn() make sure to prep the spaces orientation.
*/

var ax,ay,az;

with slayersUpgrade
{
    ax=spaceAx[argument0]*vectorx[argument2]+spaceBx[argument0]*vectory[argument2]+spaceCx[argument0]*vectorz[argument2]
    ay=spaceAy[argument0]*vectorx[argument2]+spaceBy[argument0]*vectory[argument2]+spaceCy[argument0]*vectorz[argument2]
    az=spaceAz[argument0]*vectorx[argument2]+spaceBz[argument0]*vectory[argument2]+spaceCz[argument0]*vectorz[argument2]
    
    vectorx[argument1]=ax
    vectory[argument1]=ay
    vectorz[argument1]=az
}

#define spaceConvertPosIn
/*
    spaceConvertPosIn(space,vResult,vPosition)
    
    0 space
    1 vResult
    2 vPosition
    
    vResult equals vPosition converted into the space. the resulting position is relative of the spaces position.  make sure to prep the spaces orientation.
*/

var cx,cy,cz;

with slayersUpgrade
{
    cx=vectorx[argument2]-vectorx[spacePosition[argument0]]
    cy=vectory[argument2]-vectory[spacePosition[argument0]]
    cz=vectorz[argument2]-vectorz[spacePosition[argument0]]
    
    vectorx[argument1]=spaceAx[argument0]*cx+spaceAy[argument0]*cy+spaceAz[argument0]*cz
    vectory[argument1]=spaceBx[argument0]*cx+spaceBy[argument0]*cy+spaceBz[argument0]*cz
    vectorz[argument1]=spaceCx[argument0]*cx+spaceCy[argument0]*cy+spaceCz[argument0]*cz
}

#define spaceConvertPosOut
/*
    spaceConvertPosOut(space,vResult,vPosition)
    
    vResult equals vPosition converted out of the space. this is the reverse of spaceConvertPosIn().  make sure to prep the spaces orientation.
*/

var cx,cy,cz;

with slayersUpgrade
{
    cx=spaceAx[argument0]*vectorx[argument2]+spaceBx[argument0]*vectory[argument2]+spaceCx[argument0]*vectorz[argument2]
    cy=spaceAy[argument0]*vectorx[argument2]+spaceBy[argument0]*vectory[argument2]+spaceCy[argument0]*vectorz[argument2]
    cz=spaceAz[argument0]*vectorx[argument2]+spaceBz[argument0]*vectory[argument2]+spaceCz[argument0]*vectorz[argument2]
    
    vectorx[argument1]=vectorx[spacePosition[argument0]]+cx
    vectory[argument1]=vectory[spacePosition[argument0]]+cy
    vectorz[argument1]=vectorz[spacePosition[argument0]]+cz
}

