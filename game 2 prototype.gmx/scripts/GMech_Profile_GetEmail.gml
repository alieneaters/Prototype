g_user=string(GMech_Username())
ret="N/A"
//ret=string(GMech_Netread("http://www.gmechanism.com/ini_read_var.php?type=2&user="+string(g_user)+"&gid="+string(game_id)+"&section=basic&key=email&default=N/A",1000))
if GMech_SignedIn()
{
    ini_open("user.ini")
    ret=string(ini_read_string("basic","email","N/A"))
    ini_close()
}
if string(ret)="NA" then ret="N/A"
return string(ret);
