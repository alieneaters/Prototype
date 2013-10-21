#define slayersUpgradeInit
/*
    slayersUpgradeInit() 
    
    initializes slayers upgrade. declares some globalvar's that you might want to know about. slayersUpgrade is an instance id, 
    vectors: vTempa,vTempb,vTempc,vZero and quaternion: qTempa.
    do not initalize twice! 
*/

globalvar slayersUpgrade;

var o;

o=object_add()

object_set_persistent(o,1)

with instance_create(0,0,o)
{
    slayersUpgrade=id
    
    //vectors
    totalDeletedVectors=0
    totalVectors=0
    
    //quaternions
    totalDeletedQuaternions=0
    totalQuaternions=0
    
    //spaces
    totalDeletedSpaces=0
    totalSpaces=0
    
    //shapes
    totalDeletedShapes=0
    totalShapes=0
    
    PLANE=0
    TRIANGLE=1
    BLOCK=2
    SPHERE=3
    CYLINDER=4
    CONE=5
    BLOCKINSIDE=6
    
    //temps
    globalvar vZero,vTempa,vTempb,vTempc;
    
    vZero=vecCreate(0,0,0)
    vTempa=vecCreate(0,0,0)
    vTempb=vecCreate(0,0,0)
    vTempc=vecCreate(0,0,0)
    
    globalvar qTempa;
    
    qTempa=quatCreate()
}

#define slayersUpgradeDone
/*
    slayersUpgradeDone() 
    
    destroys the slayersUpgrade instance
*/

var i;

with slayersUpgrade
{
    i=object_index
    
    instance_destroy()
}

object_delete(i)

