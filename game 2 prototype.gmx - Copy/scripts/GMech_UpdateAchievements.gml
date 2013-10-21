show_debug_message("GMechAPI: Update achievement lists")
if GMech_Connected()
{
    //Update our System list of achievements... call defineAchievements.. populate global.gameAch[id]=str
    show_debug_message("GMechAPI: Request game achievement definitions")
    http_get("http://www.gmechanism.com/achievements/APIAchDefinitions.php?gid="+string(game_id))
    //Update user's acheivements... call userAchievements.. populate global.userAch
    if GMech_SignedIn()
    {
        show_debug_message("GMechAPI: Request user achievements")
        http_get("http://www.gmechanism.com/userdata/userAchievements.php?user="+string(GMech_Username())+"&gid="+string(game_id))
    }
    http_get("http://www.gmechanism.com/APIGetAccounts.php")
}
