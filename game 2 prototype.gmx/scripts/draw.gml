d3d_model_draw (level_mod,0,0,0,background_get_texture (level_back))

d3d_model_draw (internalFrame[frame],x,y,z,background_get_texture (player_back))

xto=x-lengthdir_x (lengthdir_x(11,0),direction+90)
yto=y-lengthdir_y (lengthdir_x(11,0),direction+90)
zto=z-lengthdir_y (11,0)
d3d_set_projection_ext (xto,yto,zto,x,y,z,0,0,1,45,1280/720,9999,0.01)
Convert_Prepare (xto,yto,zto,x,y,z,0,0,1,45,1280/720)
