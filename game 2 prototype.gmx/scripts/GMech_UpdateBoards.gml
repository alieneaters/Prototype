show_debug_message("GMechAPI: Clear cached boards")
if GMech_Connected()
{
    for(gmech_i=0; gmech_i<=100; gmech_i+=1)
    {
        for(gmech_c=0;gmech_c<=100;gmech_c+=1)
        {
            global.gmech_scoreArray[gmech_i,gmech_c]="0|N/A"
        }
    }
    show_debug_message("GMechAPI: Fetch the list of boards")
    //Http_get list of boards
    http_get("http://www.gmechanism.com/highscores/APIGetScoreboardList.php?gid="+string(game_id))
    http_get("http://www.gmechanism.com/APIGetAccounts.php")
}
