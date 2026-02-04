@echo off
if not defined ANDROID_DEV_TOOLS set "ANDROID_DEV_TOOLS=%USERPROFILE%\tools\droid"
set "j=%ANDROID_DEV_TOOLS%\google_signkey\signapk.jar"
set "x=%ANDROID_DEV_TOOLS%\google_signkey\platform.x509.pem"
set "p=%ANDROID_DEV_TOOLS%\google_signkey\platform.pk8"
if exist "%j%" (java -jar "%j%" "%x%" "%p%" %*) else (echo google signapk not found)
