/*
Function: Returns the source of an online document.
Arguments:
   0 - string - online document
   1 - real - number of bytes to read
Returns:
  string - the source of the document
Example:
  src = netread("http://google.com",5000);
  draw_text(10,10,src);
*/
theRes=""
if GMech_Windows()
{
    act = external_define('NetRead.dll',"NetRead",1,1,2,1,1);
    theRes=external_call(act,argument0,string(argument1));
}
else if GMech_HTML()
{
    theRes=Davejax(argument0,false);
}
else if GMech_Mac()
{
    /*
    res=GMech_MacDLFile(argument0,"tmpFile.txt");
    show_message(string(res))
    if file_exists("tmpFile.txt")
    {
        g_tf=file_text_open_read("tmpFile.txt")
        while(!file_text_eof(g_tf))
        {
            theRes=string(theRes)+file_text_read_string(g_tf)
            file_text_readln(g_tf)
        }
        file_text_close(g_tf)
    }
    */
}
return theRes;
