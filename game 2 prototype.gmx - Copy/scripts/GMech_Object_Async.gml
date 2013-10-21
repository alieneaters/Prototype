//Get Async stuff
if string_count("APIGetAccounts.php",ds_map_find_value(async_load, "url"))>0
{
    accList = ds_map_find_value(async_load, "result");
    //Write to file
    if file_exists(working_directory+"\acc.dat") then file_delete(working_directory+"\acc.dat")
    f=file_text_open_write(working_directory+"\acc.dat")
    file_text_write_string(f,string(accList))
    file_text_writeln(f)
    file_text_close(f)
}
if string_count("APIVersion.php",ds_map_find_value(async_load, "url"))>0
{
    global.gmech_newestVersion = ds_map_find_value(async_load, "result");
    if GMech_Updates() then show_debug_message("GMechAPI: UPDATE AVAILABLE! Download at www.gmechanism.com")
}
if string_count("ip.php",ds_map_find_value(async_load, "url"))>0
{
    global.gmech_publicIP=string(ds_map_find_value(async_load, "result"))
    show_debug_message("GMechAPI: IP Retrieved")
}
if string_count("getINI.php",ds_map_find_value(async_load, "url"))>0
{
    gini=string(ds_map_find_value(async_load, "result"))
    f=file_text_open_write("remote.ini")
    file_text_write_string(f,gini)
    file_text_writeln(f)
    file_text_close(f)
    show_debug_message("GMechAPI: Obtained GameINI from server")
}
if string_count("APICheckRegistered.php",ds_map_find_value(async_load, "url"))>0
{
    global.gmech_registered=real(ds_map_find_value(async_load, "result"))
    if global.gmech_registered=1
    {
        show_debug_message("GMechAPI: Game is registered!")
        http_get("http://www.gmechanism.com/ini_read_var.php?type=0&user=0&gid="+string(game_id)+"&section="+string(game_id)+"&key=plays&default=-1")
    }
    else
    {
        show_debug_message("GMechAPI: Game is NOT registered!")
    }
}
if string_count("ini_read_var.php",ds_map_find_value(async_load, "url"))>0 //THIS IS NOT UNIQUE! - PLayCount I think
{
    global.gmech_playCount=real(ds_map_find_value(async_load, "result"))
    if global.gmech_playCount>(-1)
    {
        global.gmech_playCount+=1
        http_get("http://www.gmechanism.com/ini_write_var.php?type=0&user=0&gid="+string(game_id)+"&section="+string(game_id)+"&key=plays&value="+string(global.gmech_playCount))
    }
    show_debug_message("GMechAPI: PlayCount established.")
}
if string_count("APIGetScoreboardList.php",ds_map_find_value(async_load,"url"))>0
{
    //WE have a list of boards, create it into an array then fetch those
    char=string(chr(13)+chr(10))
    hs=ds_map_find_value(async_load,"result")
    hs=string_replace_all(hs,chr(13),"$")
    hs=string_replace_all(hs,chr(10),"$")
    hs=string_replace_all(hs,"$$","$")
    ct=string_count("$",hs)
    prehs=hs
    localList=ds_list_create()
    for(gmech_c=1;gmech_c<=ct;gmech_c+=1)
    {
        thisUser=string_copy(hs,0,string_pos("$",hs))
        thisUser=string_replace_all(thisUser,"$","")
        hs=string_replace(hs,string(thisUser)+"$","")
        ds_list_add(localList,real(thisUser))
    }
    show_debug_message("GMechAPI: "+string(ds_list_size(localList))+" boards exist. Send request for "+string(prehs))
    for(gmech_d=0;gmech_d<ds_list_size(localList);gmech_d+=1)
    {
        show_debug_message("GMechAPI: Requesting TID "+string(ds_list_find_value(localList,gmech_d)))
        http_get("http://www.gmechanism.com/highscores/APIGetScoreboard.php?gid="+string(game_id)+"&tid="+string(ds_list_find_value(localList,gmech_d)))
    }
}
if string_count("APIGetScoreboard.php",ds_map_find_value(async_load,"url"))>0
{
    //Now get the table ID
    url=ds_map_find_value(async_load,"url")
    tableID=string_copy(url,string_pos("&tid=",url),15)
    tableID=string_replace(tableID,"&tid=","")
    show_debug_message("GMechAPI: Retrieved scoreboard "+string(tableID))
    hs=ds_map_find_value(async_load,"result")
    hs=string_replace_all(hs,chr(13),"$")
    hs=string_replace_all(hs,chr(10),"$")
    hs=string_replace_all(hs,"$$","$")
    ct=string_count("$",hs)
    for(gmech_c=1;gmech_c<=ct;gmech_c+=1)
    {
        thisUser=string_copy(hs,1,string_pos("$",hs))
        thisUser=string_replace_all(thisUser,"$","")
        hs=string_replace(hs,string(thisUser)+"$","")
        thisScore=string_copy(hs,1,string_pos("$",hs))
        thisScore=string_replace_all(thisScore,"$","")
        hs=string_replace(hs,string(thisScore)+"$","") //i is table ID, c is entry
        if string(thisUser)<>""
        {
            global.gmech_scoreArray[tableID,gmech_c]=string(thisScore)+"|"+string(thisUser)
        }
    }
}
if string_count("APIAchDefinitions.php",ds_map_find_value(async_load,"url"))>0
{
    achRaw=ds_map_find_value(async_load,"result")
    achRaw=string_replace_all(achRaw,chr(13),"$")
    achRaw=string_replace_all(achRaw,chr(10),"$")
    achRaw=string_replace_all(achRaw,"$$","$")
    loopAmt=string_count("$",achRaw)/2
    for(gmech_c=1;gmech_c<=loopAmt;gmech_c+=1)
    {
        g_title=string_copy(achRaw,1,string_pos("$",achRaw))
        g_title=string_replace_all(g_title,"$","")
        achRaw=string_replace(achRaw,string(g_title)+"$","")
        g_id=string_copy(achRaw,1,string_pos("$",achRaw))
        g_id=string_replace_all(g_id,"$","")
        achRaw=string_replace(achRaw,string(g_id)+"$","")
        global.gameAch[g_id]=string(g_title)
    }
    show_debug_message("GMechAPI: Game achievement definitions retrieved")
}
if string_count("userAchievements.php",ds_map_find_value(async_load,"url"))>0
{
    achRaw=ds_map_find_value(async_load,"result")
    achRaw=string_replace_all(achRaw,chr(13),"$")
    achRaw=string_replace_all(achRaw,chr(10),"$")
    achRaw=string_replace_all(achRaw,"$$","$")
    loopAmt=string_count("$",achRaw)
    for(gmech_c=1;gmech_c<=loopAmt;gmech_c+=1)
    {
        g_id=string_copy(achRaw,1,string_pos("$",achRaw))
        g_id=string_replace_all(g_id,"$","")
        achRaw=string_replace(achRaw,string(g_id)+"$","")
        if real(g_id)>0 then ds_list_add(global.userAch,real(g_id))
    }
    show_debug_message("GMechAPI: User achievements retrieved")
}
/*
if string_count("APILogin.php",ds_map_find_value(async_load,"url"))>0
{
    res=ds_map_find_value(async_load,"result")
    if (!is_real(res)){res=real(res)}
    switch(res)
    {
        /*
        case 0: //No exist
            return 0;
        break;
        case 1: //Bad pass
            return 2;
        break;
        case 2: //SUCCESS
            //Call to online tracker PHP, populate userlists, get INI
            global.gmech_username=string_lower(global.gmech_triedUser)
            http_get("http://www.gmechanism.com/users/userINI.php?user=[USER]"+string(GMech_Username()))
            show_debug_message("GMechAPI: Write returned USER netread() to file")
            GMech_UpdateAchievements()
            GMech_UpdateBoards()
            return true;
        break;
        /*
        case 3: //Banned
            return 3;
        break;
    }
    GMech_UpdateAchievements()
    GMech_UpdateBoards()   
}
*/
if string_count("userINI.php",ds_map_find_value(async_load,"url"))>0
{
    gini=string(ds_map_find_value(async_load,"result"))
    f=file_text_open_write("user.ini")
    file_text_write_string(f,gini)
    file_text_writeln(f)
    file_text_close(f)
}
/*
if string_count("APISignup.php",ds_map_find_value(async_load,"url"))>0
{
    res=real(ds_map_find_value(async_load,"result"))
    if res=1
    {
        show_message("Thanks for signing up!")
    }
    else
    {
        show_message("Sorry, that username has been taken!")
    }
}
*/
