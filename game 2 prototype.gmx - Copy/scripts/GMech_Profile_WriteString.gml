g_user=string(GMech_Username())
gmech_key=string(argument0)
gmech_str=string(argument1)
if global.gmech_initialized=1
{
    http_get("http://www.gmechanism.com/ini_write_var.php?type=2&user="+string(g_user)+"&gid="+string(game_id)+"&section="+string(game_id)+"&key="+string(gmech_key)+"&value="+string(gmech_str))
    ini_open("user.ini")
    ini_write_string(string(game_id),string(gmech_key),string(gmech_str))
    ini_close()
    return 1;
}
else
{
    return 0;
}
