#define grid3dCreate
/*
    grid3dCreate(sizex,sizey,sizez)
        
    returns a new 3d grid id.
*/

var list,i;

list=ds_list_create()

for(i=0 i<argument2 i+=1)
{
    ds_list_add(list,ds_grid_create(argument0,argument1))
}

return list

#define grid3dDestroy
/*
    grid3dDestroy(grid)
        
    destroys the 3d grid
*/

var i;

for(i=0 i<ds_list_size(argument0) i+=1)
{
    ds_grid_destroy(ds_list_find_value(argument0,i))
}

ds_list_destroy(argument0)

#define grid3dSet
/*
    grid3dSet(grid,cellx,celly,cellz,value)
    
    0 3d grid
    1 x cell
    2 y
    3 z
    4 value
        
    sets the cell in the 3d grid to the value
*/

if argument3<0                          exit
if argument3>=ds_list_size(argument0)   exit

ds_grid_set(
    ds_list_find_value(argument0,argument3),
    argument1,
    argument2,
    argument4)

#define grid3dGet
/*
    grid3dGet(grid,cellx,celly,cellz)
    
    0 3d grid
    1 x cell
    2 y
    3 z
        
    returns the value in the cell of the 3d grid.
*/

if argument3<0                          return 0
if argument3>=ds_list_size(argument0)   return 0

return ds_grid_get(
            ds_list_find_value(argument0,argument3),
            argument1,
            argument2)

#define grid3dGetSizex
/*
    grid3dGetSizex(grid)
    
    returns the size of the grid in the x  
*/

return ds_grid_width(ds_list_find_value(argument0,0))

#define grid3dGetSizey
/*
    grid3dGetSizey(grid)
    
    returns the size of the grid in the y  
*/

return ds_grid_height(ds_list_find_value(argument0,0))

#define grid3dGetSizez
/*
    grid3dGetSizez(grid)
    
    returns the size of the grid in the z  
*/

return ds_list_size(argument0)

#define grid3dResize
/*
    grid3dResize(grid,sizex,sizey,sizez)
    
    0 3d grid
    1 x new dimensions
    2 y
    3 z
    
    resizes the grid to the new dimensions. use 0 to not change size for a component. 
*/

var top,ax,ay,i;

//if 0 is passed in don't change that size
if argument1<=0 ax=ds_grid_width(ds_list_find_value(argument0,0))  else ax=argument1
if argument2<=0 ay=ds_grid_height(ds_list_find_value(argument0,0)) else ay=argument1

if argument3>0
{
    if argument3<ds_list_size(argument0)
    {
        //remove grids because the new size is smaller
        repeat ds_list_size(argument0)-argument3
        {
            top=ds_list_size(argument0)-1
            ds_grid_destroy(ds_list_find_value(argument0,top))
            ds_list_delete(argument0,top)
        }
    }
    else
    {
        //add more grids because the new size is larger than the old
        repeat argument3-ds_list_size(argument0)
        {
            ds_list_add(argument0,ds_grid_create(argument1,argument2))
        }
    }
}

//resize all the grids
for(i=0 i<ds_list_size(argument0) i+=1) 
{
    ds_grid_resize(ds_list_find_value(argument0,i),ax,ay)
}

#define grid3dCopy
/*
    grid3dCopy(id,source)
    
    0 id
    1 source
    
    makes one grid the same as the other
*/ 

var grid,i;

if ds_list_size(argument1)<ds_list_size(argument0)
{
    //remove excess grids
    repeat ds_list_size(argument0)-ds_list_size(argument1)
    {
        i=ds_list_size(argument0)-1
        
        ds_grid_destroy(ds_list_find_value(argument0,i))
        ds_list_delete(argument0,i)
    }
    
    //copy everything
    for(i=0 i<ds_list_size(argument1) i+=1)
    {
        ds_grid_copy(ds_list_find_value(argument0,i),ds_list_find_value(argument1,i))
    }
}
else
{
    //copy as many as you can
    for(i=0 i<ds_list_size(argument0) i+=1)
    {
        ds_grid_copy(ds_list_find_value(argument0,i),ds_list_find_value(argument1,i))
    }
    
    //create new grids, ds list entries and copy the rest by adding on
    while i<ds_list_size(argument1)
    {
        grid=ds_grid_create(1,1)
        
        ds_grid_copy(grid,ds_list_find_value(argument1,i))
        
        ds_list_add(argument0,grid)
        
        i+=1
    }
}

#define grid3dClear
/*
    grid3dClear(grid,value)
    
    sets all the cells in the 3d grid to the value. value can be real or string.
*/

var i;

for(i=0 i<ds_list_size(argument0) i+=1) ds_grid_clear(ds_list_find_value(argument0,i),argument1)

#define grid3dCopyRegion
/*
    grid3dCopyRegion(id,source,ax,ay,az,bx,by,bz,posx,posy,posz)
    
    0 id
    1 source
    2 ax
    3 ay
    4 az
    5 bx
    6 by
    7 bz
    8 posx
    9 posy
    10 posz
    
    copys the region from source to id. 
    ax ay az is the top left bottom of the region. 
    bx by bz is the bottom right top of the region. 
    don't pass in a region that is not inside grid source. 
    posx posy posz indicate the position to place the region into grid id. it must be inside id.
    if the region doesn't fit into grid id then some data will not be copied
*/

var i,j,k;

i=0

//either copy the whole region or stop once we hit the height of id and don't copy more than the size of the source
topz=min(argument7,(ds_list_size(argument0)-1)-argument4,ds_list_size(argument1)-1)

//copy from source to id
for(j=argument4 j<=topz j+=1)
{
    ds_grid_set_grid_region(
        ds_list_find_value(argument0,argument10+i),
        ds_list_find_value(argument1,j),
        argument2,argument3,
        argument5,argument6,
        argument8,argument9)
        
    i+=1
}

//get position of the last element in source
topz=ds_list_size(argument1)-1

//remove extra data from source because it won't fit into id
repeat topz-j
{
    ds_grid_destroy(ds_list_find_value(argument1,topz))
    ds_list_delete(argument1,topz)
}

#define grid3dWrite
/*
    grid3dWrite(file,grid)
    
    0 file
    1 grid
    
    writes all the grids data to a file. 
    file must be an open writable text file. 
*/

var i;

file_text_write_real(argument0,ds_list_size(argument1))
file_text_writeln(argument0)

for(i=0 i<ds_list_size(argument1) i+=1)
{
    file_text_write_string(argument0,ds_grid_write(ds_list_find_value(argument1,i)))
    file_text_writeln(argument0)
}

#define grid3dRead
/*
    grid3dRead(file,grid)
    
    0 file
    1 grid
    
    reads the grid from file. 
    file must be an open readable text file. 
*/

var size,grid,i;

size=file_text_read_real(argument0)
file_text_readln(argument0)

grid3dResize(argument1,0,0,size)

for(i=0 i<size i+=1)
{
    ds_grid_read(ds_list_find_value(argument1,i),file_text_read_string(argument0))
    file_text_readln(argument0)
}

