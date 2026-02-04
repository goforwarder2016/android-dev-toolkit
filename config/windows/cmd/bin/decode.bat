@echo off
if not defined ANDROID_DEV_TOOLS set "ANDROID_DEV_TOOLS=%USERPROFILE%\tools\droid"
set "j=%ANDROID_DEV_TOOLS%\Decode.jar"
if exist "%j%" (java -jar "%j%" %*) else (echo Decode.jar not found)
