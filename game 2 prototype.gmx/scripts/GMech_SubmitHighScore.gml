show_debug_message("GMechAPI: SubmitScore: Assign variables")
gmech_tid=argument0 //Hightscore table slot id
gmech_score=argument1
gmech_gid=game_id
gmech_rev=argument2
//username=argument3
gmech_lboard=argument4
show_debug_message("GMechAPI: SubmitScore: Primary checksum")
gmech_firstinst=string_length(string(gmech_tid))+string_length(string(gmech_score))+string_length(string(gmech_gid))+string_length(string(gmech_rev))
//90 gid, tid, user, score
if GMech_Connected()
{
if gmech_tid>0 and gmech_tid<101
{
    if GMech_SignedIn() or string(argument3)<>""
    {
        if gmech_rev=true or gmech_rev=false
        {
            if GMech_SignedIn() then gmech_user=string(GMech_Username()) else gmech_user=string(argument3)
            if string(gmech_user)<>""
            {  
                show_debug_message("GMechAPI: SubmitScore: Secondary checksum")
                g_check=real(game_id) mod (gmech_firstinst+string_length(string(gmech_user)))
                show_debug_message("GMechAPI: SubmitScore: Go online")
                hstta=http_get("http://www.gmechanism.com/highscores/APISubmitScore.php?gid="+string(game_id)+"&tid="+string(gmech_tid)+"&user="+string(gmech_user)+"&score="+string(gmech_score)+"&rev="+string(gmech_rev)+"&leaderboard="+string(gmech_lboard)+"&checksum="+string(g_check))
                /*
                hs=string_replace_all(hs,chr(13),"$")
                hs=string_replace_all(hs,chr(10),"$")
                hs=string_replace_all(hs,"$$","$")
                for(gmech_c=1;gmech_c<=string_count("$",hs);gmech_c+=1)
                {
                    thisUser=string_copy(hs,1,string_pos("$",hs))
                    thisUser=string_replace_all(thisUser,"$","")
                    hs=string_replace(hs,string(thisUser)+"$","")
                    thisScore=string_copy(hs,1,string_pos("$",hs))
                    thisScore=string_replace_all(thisScore,"$","")
                    hs=string_replace(hs,string(thisScore)+"$","")
                    global.gmech_scoreArray[gmech_tid,gmech_c]=string(thisScore)+"|"+string(thisUser)
                }
                */
                show_debug_message("GMechAPI: SubmitScore: Finished")
                GMech_UpdateBoards()
            }
            else
            {
                show_message("Invalid Guest Username parameter!")
            }
        }
        else
        {
            show_message("Invalid flag: Reversed scoreboard is either true or false")
        }
    }
    else
    {
        show_message("Unable to submit your score, you are not signed in to GMechanism!")
    }
}
else
{
    show_message("Highscore Table ID is invalid! (1-100)")
}
}
else
{
    show_message("GMechanism not connected!")
}
