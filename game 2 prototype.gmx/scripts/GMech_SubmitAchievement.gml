if global.gmech_registered=1 and GMech_Connected()
{
    if GMech_SignedIn()
    {
        http_get("http://www.gmechanism.com/userData/submitAchievement.php?user="+string(GMech_Username())+"&gid="+string(game_id)+"&id="+string(argument0))
        ds_list_add(global.userAch,argument0)
    }
}
