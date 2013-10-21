//argument0: online (t/f)
/*
if argument0=1 then gstat="n" else gstat="offline"
if GMech_SignedIn()
{
    if GMech_HTML()
    {
        //We can use Davejax async
        //www.lukeescude.com/gmech/setonline.php?user=&gid=12345&ts=n
        k=Davejax("http://www.gmechanism.com/setonline.php?user="+string(GMech_Username())+"&gid="+string(game_id)+"&ts="+string(gstat),true)
    }
    else
    {
        //We use GMStudio async
        http_get("http://www.gmechanism.com/setonline.php?user="+string(GMech_Username())+"&gid="+string(game_id)+"&ts="+string(gstat))
    }
}
*/
