@echo off
cd /d "%~dp0"
:loop
if "%~1" == "" goto :eof
lame.exe --decode %1 "%~1.wav"
shift
goto :loop
