@echo off
if not defined ANDROID_DEV_TOOLS set "ANDROID_DEV_TOOLS=%USERPROFILE%\tools\droid"
set "p=%ANDROID_DEV_TOOLS%\get_focus_activity.bat"
if exist "%p%" (call "%p%") else (echo get_focus_activity.bat not found)
