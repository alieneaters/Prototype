if global.gmech_initialized=1
{
if string(global.gmech_version)<>string(global.gmech_newestVersion) then return 1 else return 0
}
else
{
return 0
}
