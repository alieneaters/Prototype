e=extract (object_get_name (self),"_",1)
num=import_md2 ("data\EN"+string(e)+".md2","EN"+string(e))
modex=background_add ("data\EN"+string(e)+".png",0,0)
