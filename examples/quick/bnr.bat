rebuild -g -c plugin.d
ren _plugin.obj plugin.obj
rebuild -L/M -clean quick.d -I..\.. && quick.exe
pause
