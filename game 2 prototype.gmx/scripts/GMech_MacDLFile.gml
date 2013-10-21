/*
argument0 = url to download from
argument1 = local file to save as
returns the error code from the server. 200 is a succesful download.
NOTE: urls with usernames and passwords do not work.
*/
var server, file, i, port, tcp, endloop, url, error;
server = "";
file = "/"
port = 80;
i = 0;
error = 200;
if(string_pos("http://", argument0) == 1)argument0 = string_delete(argument0, 1,7)
//get file part of url
i = string_pos("/", argument0);
if(i)
{
    file = string_copy(argument0, i, string_length(argument0)-i+1);
    argument0 = string_delete(argument0, i, string_length(file));
}
//get port part
i = string_pos(":", argument0);
if(i)
{
    port = real(string_copy(argument0, 1, i-1));
    argument0 = string_delete(argument0, 1, i);
}
//get server part
server = argument0;
//the code above interpretes the url into a server variable, file variable and port.
dydllinit()
tcp = dytcpconnect(server, port, 0);
if(!tcp)return false;
dysetformat(tcp, 1, chr(13) + chr(10)); //set format to text mode to receive one line at a time.
//send get request
dyclearbuffer(0);
dywritechars("GET " + file+ " HTTP/1.1" + chr(13) + chr(10),0);
dywritechars("Host: " + server + chr(13) + chr(10),0);
dywritechars("Connection: close"+chr(13) + chr(10),0);
dywritechars("Accept: image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, application/xaml+xml, application/vnd.ms-xpsdocument, application/x-ms-xbap, application/x-ms-application, application/x-alambik-script, application/x-alambik-alamgram-link, */*"+chr(13)+chr(10),0);
dywritechars("Accept-Language: en-us"+chr(13) + chr(10),0);
dywritechars("User-Agent: Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; InfoPath.1; .NET CLR 2.0.50727; .NET CLR 1.1.4322)"+chr(13) + chr(10),0);
dysendmessage(tcp,0,0,0);
//receive file header
//interpret header for any errors.
endloop = false;
while(!endloop)
{
    dyreceivemessage(tcp,0,0); //receive one line
    i = dyreadsep(" ",0); //read first word
    switch(i)
    {
//check http error code
        case "HTTP/1.1":
        case "HTTP/1.0":
            error = real(dyreadsep(" ",0));
            if(error != 200 && error != 301)
            {
                dyclosesock(tcp);
                return error;
            }
        break;
//if page moved than locate new page and download from it.
        case "Location:":
            if(error == 301)
            {
                dyclosesock(tcp);
                url = dyreadsep(chr(13) + chr(10),0);
                return GMech_MacDLFile(url,argument1);
            }
        break;
//if blank line (end of header) then exit loop
        case "":
            endloop = true
        break;
    }
}
dysetformat(tcp,formatnone,''); //turn off all formatting so we can receive file data.
if(file_exists(argument1))file_delete(argument1);
file = dyfileopen(argument1, 1);
//start receiving file
while(dyreceivemessage(tcp, 50000,0) > 0) //receive 50000 bytes
{
    dyfilewrite(file,0); //write file chunk to file.
}
dyclosesock(tcp);
dyfileclose(file);
return 200;
