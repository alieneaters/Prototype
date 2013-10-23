g_user=string_lower(argument0)
g_pass=argument1
if GMech_Connected() and file_exists(working_directory+"\acc.dat")
{
    //Check local file
    userExists=false;
    userCorrect=false;
    f=file_text_open_read(working_directory+"\acc.dat")
    while(!file_text_eof(f))
    {
        data_1=file_text_read_string(f)
        file_text_readln(f)
        data_2=file_text_read_string(f)
        file_text_readln(f)
        if string_lower(data_1)=string_lower(g_user) then userExists=true
        if string(data_2)=string(g_pass) then userCorrect=true
    }
    file_text_close(f)
    if userExists
    {
        if userCorrect
        {
            global.gmech_username=string_lower(g_user)
            global.userAch=ds_list_create()
            http_get("http://www.gmechanism.com/users/userINI.php?user=[USER]"+string(GMech_Username()))
            show_debug_message("GMechAPI: Fetch user's INI file")
            http_get("http://www.gmechanism.com/gstats_set.php?user="+string(global.gmech_username)+"&gid="+string(game_id))
            GMech_UpdateAchievements()
            GMech_UpdateBoards()
            return 1;
        }
        else
        {
            return 2;
        }
    }
    else
    {
        return 0;
    }
}
else
{
    return 4;
}
