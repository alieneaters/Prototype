g_user=string_lower(argument0)
g_pass=argument1
if GMech_Connected() and file_exists(working_directory+"\acc.dat")
{
    if string_lettersdigits(g_user)<>string(g_user) and string(g_user)<>""
    {
        return 0;
    }
    else
    {
        userExists=false;
        f=file_text_open_read(working_directory+"\acc.dat")
        while(!file_text_eof(f))
        {
            data_1=file_text_read_string(f)
            file_text_readln(f)
            data_2=file_text_read_string(f)
            file_text_readln(f)
            if string(data_1)=string(g_user) then userExists=true
        }
        file_text_close(f)
        if userExists
        {
            return 2;
        }
        else
        {
            f=file_text_open_append(working_directory+"\acc.dat")
            file_text_write_string(f,g_user)
            file_text_writeln(f)
            file_text_write_string(f,g_pass)
            file_text_writeln(f)
            file_text_close(f)
            http_get("http://www.gmechanism.com/APISignup.php?user="+string(g_user)+"&pass="+string(g_pass))
            return 1;
        }
    }
}
else
{
    return 3;
}
