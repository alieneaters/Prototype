/* 
P3DC (Precise 3D Collisions)
V6.00
----
Adds a wall to the current model; Current model is returned by the last called p3dc_begin_model();
Same arguments for d3d_draw_wall(x1,y1,z1,x2,y2,z2);
----
ARGUMENTS:
Arg0: X1
Arg1: Y1
Arg2: Z1
Arg3: X2
Arg4: Y2
Arg5: Z2
----
Returns the triangle location identifier (Triangle LID).
Only used for overwriting models after they've been created.
*/
return external_call(global.p3dc_apw,argument0,argument1,argument2,argument3,argument4,argument5);
