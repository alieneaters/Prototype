g_user=string(GMech_Username())
gmech_key=argument0
gmech_default=argument1
ret="N/A"
ini_open("user.ini")
ret=ini_read_real(string(game_id),string(gmech_key),real(gmech_default))
ini_close()
return real(ret);
