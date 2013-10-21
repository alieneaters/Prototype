if global.gmech_initialized=1
{
    /*
    show_debug_message("GMechAPI: Clear online user arrays")
    ds_list_clear(global.gmech_onlineUserList)
    show_debug_message("GMechAPI: Get the online users to update")
    if GMech_HTML() then hs=Davejax("http://www.gmechanism.com/setonline.php?user="+string(GMech_Username())+"&gid="+string(game_id)+"&ts=n",false) else hs=GMech_Netread("http://www.gmechanism.com/setonline.php?user="+string(GMech_Username())+"&gid="+string(game_id)+"&ts=n",8000)
    char=string(chr(13)+chr(10))
    show_debug_message("GMechAPI: Got online userlist, parse it.")
    hs=string_replace_all(hs,chr(13),"$")
    hs=string_replace_all(hs,chr(10),"$")
    hs=string_replace_all(hs,"$$","$")
    for(gmech_c=1;gmech_c<=string_count("$",hs);gmech_c+=1)
    {
        thisUser=string_copy(hs,1,string_pos("$",hs))
        thisUser=string_replace_all(thisUser,"$","")
        hs=string_replace(hs,string(thisUser)+"$","")
        ds_list_add(global.gmech_onlineUserList,string(thisUser))
    }
    */
}
