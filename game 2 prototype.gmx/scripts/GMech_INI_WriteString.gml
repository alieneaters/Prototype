gmech_section=string_lower(argument0)
gmech_key=string_lower(argument1)
gmech_str=string(argument2)
if global.gmech_initialized=1
{
    http_get("http://www.gmechanism.com/ini_write_var.php?type=1&user="+string(GMech_Username())+"&gid="+string(game_id)+"&section="+string(gmech_section)+"&key="+string(gmech_key)+"&value="+string(gmech_str))
    ini_open("remote.ini")
    ini_write_string(gmech_section,gmech_key,gmech_str)
    ini_close()
    return 1;
}
else
{
    return 0;
}
