@echo off
if not defined ANDROID_DEV_TOOLS set "ANDROID_DEV_TOOLS=%USERPROFILE%\tools\droid"
set "p=%ANDROID_DEV_TOOLS%\replace_so.bat"
if exist "%p%" (call "%p%") else (echo replace_so.bat not found)
