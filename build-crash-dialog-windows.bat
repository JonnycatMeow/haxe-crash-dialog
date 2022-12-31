@echo off 
cd crash-dialog
haxe hxwidgets-windows.hxml
copy build\windows\Main.exe ..\export\windows\IzzyEngine-CrashDialog.exe
cd ..
@echo on