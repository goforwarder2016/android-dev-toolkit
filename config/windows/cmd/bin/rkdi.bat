@echo off
if not defined ANDROID_DEV_TOOLS set "ANDROID_DEV_TOOLS=%USERPROFILE%\tools\droid"
set "e=%ANDROID_DEV_TOOLS%\upgrade_tool.exe"
if exist "%e%" ("%e%" di %*) else (echo upgrade_tool.exe not found)
