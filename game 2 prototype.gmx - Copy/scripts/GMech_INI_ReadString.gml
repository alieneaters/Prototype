gmech_section=string_lower(argument0)
gmech_key=string_lower(argument1)
gmech_def=string(argument2)
g_ans=gmech_def
if global.gmech_initialized=1
{
    //g_ans=string(GMech_Netread("http://www.gmechanism.com/ini_read_var.php?type=1&user="+string(GMech_Username())+"&gid="+string(game_id)+"&section="+string(gmech_section)+"&key="+string(gmech_key)+"&default="+string(gmech_def),1000))
    ini_open("remote.ini")
    g_ans=ini_read_string(gmech_section,gmech_key,gmech_def)
    ini_close()
    return string(g_ans);
}
else
{
    return real(gmech_def);
}
