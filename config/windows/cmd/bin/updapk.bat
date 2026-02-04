@echo off
if not defined ANDROID_DEV_TOOLS set "ANDROID_DEV_TOOLS=%USERPROFILE%\tools\droid"
set "p=%ANDROID_DEV_TOOLS%\replace_apk.bat"
if exist "%p%" (call "%p%") else (echo replace_apk.bat not found)
