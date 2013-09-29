var dis,dis2;
dis = point_dis(0,-point_direction(0,z,1,z-9999999),global.level_colid)
dis2 = point_dis(0,-point_direction(0,z,1,z+9999999),global.level_colid)
if dis < 50 then {z += 50-dis zsp = 0}
if dis > 55 then zsp -= 1
if zsp > 0 then zsp -= 0.5
if zsp < 0 then zsp += 0.5
if dis2 < 20 then
{
zsp = -1
}
z += zsp

if mouse_check_button (mb_left) {
Convert_2d (mouse_x,mouse_y,x,y,z,0)
if y>y_3d {if point_dis(direction,0,global.level_colid) > 20 then {speed=3} else {speed=0} walking=true}
if y<y_3d {if point_dis(direction+180,0,global.level_colid) > 20 then {speed=-3} else {speed=0} walking=true}}
if mouse_check_button_released (mb_left) {speed=0 walking=false}

if walking=false && point_distance_3d (x,y,z,enemy_parent.x,enemy_parent.y,enemy_parent.z)<global.range then {bullet_create (x,y,z,bullet_obj,(90),0,(global.attack))}
