d3d_start ()
p3dc_init ()
md2_Init ()
view_enabled=true
view_hport[0]=display_get_width ()
view_wport[0]=display_get_height ()
view_xport[0]=0
view_yport[0]=0
view_xview[0]=0
view_yview[0]=0
view_wview[0]=display_get_width ()
view_hview[0]=display_get_height ()
view_vborder[0]=32
view_hborder[0]=32
view_hspeed[0]=-1
view_vspeed[0]=-1
view_object[0]=noone
view_visible[0]=true

global.level_colid=p3dc_begin_model ()
p3dc_add_model ("Level model.d3d",0,0,0)
p3dc_end_model ()

col=p3dc_begin_model ()
p3dc_add_block (-5,-5,-5,5,5,5)
p3dc_end_model ()

level_mod=d3d_model_create ()
d3d_model_load (level_mod,"Level model.d3d")

maxframe=import_md2 ("Character.md2","Player_Animation")

z=0
xto=x
yto=y
zsp=0
dis=0
dis2=0
zto=z-lengthdir_y (11,0)
