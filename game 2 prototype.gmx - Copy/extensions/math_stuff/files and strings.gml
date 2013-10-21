#define readFiles
/*
    readFiles(startDirectory,extension,dsList)
    
    This searches all files under the specified directory. 
    File names are saved in a ds_list which is supplied by the user. 
    startDirectory is the name of the directory to start searching. 
    extension is the part of the files to be found (including the period, and must be in lower case.) 
    dsList is the data structure to save the file names in. 
*/

var file_name, dir_name, full_path;
var subdir_queue;

// Put the starting position into the queue.
subdir_queue = ds_queue_create();
ds_queue_enqueue(subdir_queue, argument0);

while (!ds_queue_empty(subdir_queue)) 
{
    // Pop one directory out of the queue.
    dir_name = ds_queue_dequeue(subdir_queue);

    // Search all files and subdirectories under the directory.
    file_name = file_find_first(dir_name + '\*', fa_directory);
    
    while(file_name != '') 
    {
        full_path = dir_name + '\' + file_name;

        if (file_attributes(full_path, fa_directory)) 
        { // a directory
            // Put subdirectories into the queue.
            if (file_name != '.' && file_name != '..') 
            {
                ds_queue_enqueue(subdir_queue, full_path);
            }
        }
        else 
        { // a normal file
        
            // Add the file to the list if it has the specified extension.
            if (string_lower(filename_ext(file_name)) == argument1) 
            {
               ds_list_add(argument2, full_path);
            }
        }
        file_name = file_find_next();
    }
    file_find_close();
}

ds_queue_destroy(subdir_queue);

#define stringExtract
/*
    stringExtract(string,tokenString,index)
    
    0 string
    1 tokenString
    2 index
    
    Returns the element at the given index within a given string of elements. 
    string is the complete string you want to extract other strings from. 
    tokenString is the character or string seperating the elements in string. 
    index is the element to return, {0..n-1} 
    Example: stringExtract("cat,dog,mouse",",",1) = "dog" GMLscripts.com
*/

var len;

len = string_length(argument1)-1

repeat argument2 argument0 = string_delete(argument0,1,string_pos(argument1,argument0)+len)

argument0 = string_delete(argument0,string_pos(argument1,argument0),string_length(argument0))

return argument0

#define getNumber
/*
    getNumber(text,defualt)
    
    0 text
    1 default value shown
        
    asks the user for a number. 
    returns a number with a decimal point and negative sign. 
    text is the text to display. 
    default is the default value shown. 
    does not get numbers with more than 10 characters because real() can't handle a huge number.
*/

var stringOriginal,stringDigits,dec,neg;

stringOriginal=get_string(argument0,argument1)
neg=1

if string_char_at(stringOriginal,1)="-"
{
    neg=-1
    stringOriginal=string_delete(stringOriginal,1,1)
}

dec=string_pos(".",stringOriginal)
stringDigits=string_digits(stringOriginal)
stringOriginal=string_replace(stringOriginal,".","")

if stringDigits!=stringOriginal return argument1

if dec>0
{
    stringOriginal=string_insert(".",stringDigits,dec)
}

if string_length(stringOriginal)>11
{
    stringOriginal=string_delete(stringOriginal,11,string_length(stringOriginal)-10)
}

return real(stringOriginal)*neg

#define fileTextWriteString
/*
    fileTextWriteString(file,string)
    
    0 file
    1 string
        
    writes the string to the file and a new line
*/

file_text_write_string(argument0,argument1)
file_text_writeln(argument0)

#define fileTextWriteReal
/*
    fileTextWriteReal(file,real)
    
    0 file
    1 real
    
    writes the real to the file and a new line
*/

file_text_write_real(argument0,argument1)
file_text_writeln(argument0)

#define fileTextReadString
/*
    fileTextReadString(file)
    
    0 file

   reads a string from the file and a new line. returns the string. 
*/

var line;

line=file_text_read_string(argument0)
file_text_readln(argument0)

return line

#define fileTextReadReal
/*
    fileTextReadReal(file)
    
    0 file
        
    reads the real from the file and a new line. returns the real. 
*/

var line;

line=file_text_read_real(argument0)
file_text_readln(argument0)

return line

#define fileBinReadWord
/*
    fileBinReadWord(file,size,binend)
    
    returns an integer word of the given size from the given file. 
    file is an open binary file. 
    size is the word in bytes. 
    bigend is whether to use big-endian byte order or not. 
    GMLscripts.com
*/
{
    var file,size,bigend,value,i,b;
    file = argument0;
    size = argument1;
    bigend = argument2;
    value = 0;
    for (i=0; i<size; i+=1) {
        b[i] = file_bin_read_byte(file);
    }
    if (bigend) for (i=0; i<size; i+=1) value = value << 8 | b[i];
    else for (i=size-1; i>=0; i-=1) value = value << 8 | b[i];
    return value;
}

#define fileBinWriteWord
/*
    fileBinWriteWord(file,size,bigend,value)

    writes the integer value to the file using size bytes and big or small endian. 
    returns nothing. GMLscripts.com
*/

{
    var file,size,bigend,value,i,b;
    file = argument0;
    size = argument1;
    bigend = argument2;
    value = argument3;
    
    for (i=0; i<size; i+=1) {
        b[i] = value & 255;
        value = value >> 8;
    }
    if (bigend) for (i=size-1; i>=0; i-=1) file_bin_write_byte(file,b[i]);
    else for (i=0; i<size; i+=1) file_bin_write_byte(file,b[i]);
}

#define fileBinWriteInt
/*
    fileBinWriteInt(file,value)
    
    0 file
    1 value
        
    writes the value to the file. 
    reads using big endian. 
    the value must be larger than 0 and smaller than 65536. 
    does not save decimal values.
*/

file_bin_write_byte(argument0,(argument1>>8) & 255)
file_bin_write_byte(argument0,argument1 & 255)

#define fileBinReadInt
/*
    fileBinReadInt(file)
    
    0 file
        
    reads two bytes and returns an integer value. 
    uses big endian byte order. 
*/

return file_bin_read_byte(argument0) << 8 | file_bin_read_byte(argument0)

#define fileBinWriteString
/*
    fileBinWriteString(file,string)
    
    writes the string to the open binary file. 
    the characters are written one byte at a time and a null is placed at the end. 
*/

var m,i;

m=string_length(argument1)

for(i=1 i<=m i+=1) file_bin_write_byte(argument0,ord(string_char_at(argument1,i)))

file_bin_write_byte(argument0,0)


#define fileBinReadString
/*
    fileBinReadString(file)
    
    reads a string from the open binary file and returns it. 
    stops reading characters when 0 is read (NULL)
*/

var s;

s=""

b=file_bin_read_byte(argument0)

while b>0 
{
    s+=chr(b)
    
    b=file_bin_read_byte(argument0)
}

return s

