@echo off
if not defined ANDROID_DEV_TOOLS set "ANDROID_DEV_TOOLS=%USERPROFILE%\tools\droid"
set "p=%ANDROID_DEV_TOOLS%\factory_reset.bat"
if exist "%p%" (call "%p%") else (echo factory_reset.bat not found)
