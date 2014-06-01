rebuild -g -c plugin.d
ren _plugin.obj plugin.obj
rebuild -g -clean quicker.d -I..\.. && quicker.exe
pause
