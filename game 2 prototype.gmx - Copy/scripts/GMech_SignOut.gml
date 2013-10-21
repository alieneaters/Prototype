if global.gmech_initialized=1
{
    //Send logoff code to server
    GMech_System_UpdateOnlineStatus(false)
    ds_list_destroy(global.userAch)
    //Delete user ini
    if file_exists("user.ini") then file_delete("user.ini")
    global.gmech_username=""
}
return true;
