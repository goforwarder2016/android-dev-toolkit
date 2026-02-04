@echo off
if not defined ANDROID_DEV_TOOLS set "ANDROID_DEV_TOOLS=%USERPROFILE%\tools\droid"
set "p=%ANDROID_DEV_TOOLS%\gf_Log.bat"
if exist "%p%" (call "%p%") else (echo gf_Log.bat not found)
