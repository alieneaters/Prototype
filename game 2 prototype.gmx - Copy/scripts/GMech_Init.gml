//ARGUMENTS:
//Argument0: Password
//Argument1: GMech instance
//Start all variables
show_debug_message("GMechAPI: Init")
global.gmech_updates=0
global.gmech_username=""
global.gmech_gotScores=0
global.gmech_version="3.2"
global.gmech_playCount=(-1)
global.gmech_initialized=0
global.gmech_publicIP=""
if os_is_network_connected()
{
    show_debug_message("GMechAPI: Net connected!")
    /* No longer legit
    if GMech_Windows() //We're in Windows
    {
        if directory_exists("C:\GMechanism")=0 then directory_create("C:\GMechanism")
        if directory_exists("C:\GMechanism\Cache")=0 then directory_create("C:\GMechanism\Cache")
    }
    */
    http_get("http://www.gmechanism.com/APIGetAccounts.php")
    show_debug_message("GMechAPI: Clean and create GMech Object");
    if (is_real(argument1))
    {
        with(argument1){instance_destroy()}
        if instance_exists(argument1)=0 {object_set_persistent(argument1,true); tc=instance_create(0,0,argument1); object_set_persistent(tc,true); }
    }
    else
    {
        show_debug_message("GMechAPI: FATAL ERROR! Supplied GMech Object identifier is NOT REAL. No communication with the server can take place!")
    }
    show_debug_message("GMechAPI: Assign variables and ds_list")
    http_get("http://www.gmechanism.com/APIVersion.php")
    global.gmech_onlineUserList=ds_list_create()
    global.gmech_blockUsers=ds_list_create() //Keep this the same!
    http_get("http://www.lukeescude.com/ip.php")
    global.gmech_playCount=(-1)
    //global.gmech_defaultAvatar=sprite_add("http://lukeescude.dyndns.org/GMech/avatars/defaultAvatar.png",1,false,true,0,0)
    //Now download game INI
    show_debug_message("GMechAPI: Netread() to get INI")
    http_get("http://www.gmechanism.com/gameINI/getINI.php?gid="+string(game_id))
    show_debug_message("GMechAPI: Create score arrays")
    for(gmech_i=0; gmech_i<=100; gmech_i+=1)
    {
        for(gmech_c=0;gmech_c<=100;gmech_c+=1)
        {
            global.gmech_scoreArray[gmech_i,gmech_c]="0|N/A"
        }
    }
    show_debug_message("GMechAPI: Create achievement arrays")
    for(gmech_i=0; gmech_i<=100; gmech_i+=1)
    {
        global.gameAch[gmech_i]=""
    }
    global.userAch=ds_list_create()
    //Get REGISTERED with argument1
    http_get("http://www.gmechanism.com/APICheckRegistered.php?gid="+string(game_id)+"&pass="+string(argument0))
    //Get HS tables with netread
    global.gmech_initialized=1
    show_debug_message("GMechAPI: UpdateBoards()")
    GMech_UpdateBoards()
    GMech_UpdateAchievements()
    show_debug_message("GMechAPI: Init complete")
    return true;
}
else
{
    global.gmech_initialized=0
    show_debug_message("Internet connection not found!")
    return false;
}
