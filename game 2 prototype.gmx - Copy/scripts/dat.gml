e=extract (object_get_name (self),"_",1)
num=import_md2 ("data\MN"+string(e)+".md2","MN"+string(e))
modex=background_add ("data\MN"+string(e)+".png",0,0)
