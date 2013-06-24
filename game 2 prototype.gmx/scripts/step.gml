var dis,dis2;
dis = point_dis(0,-point_direction(0,z,1,z-9999999),global.level_colid)
dis2 = point_dis(0,-point_direction(0,z,1,z+9999999),global.level_colid)
if dis < 50 then {z += 50-dis zto += 50-dis zsp = 0}
if dis > 55 then zsp -= 1
if zsp > 0 then zsp -= 0.5
if zsp < 0 then zsp += 0.5
if dis2 < 20 then
{
zsp = -1
}
z += zsp

if keyboard_check (ord("D")) then {if point_dis(direction,0,global.level_colid) > 20 then {speed = 3} else {speed = 0}}
if keyboard_check (ord("A")) then {if point_dis(direction+180,0,global.level_colid) > 20 then {speed = -3} else {speed = 0}}

if mouse_check_button (mb_left) {
Convert_2d (mouse_x,mouse_y,x,y,z,0)
move_towards_point (x_3d,y_3d,4)
}
