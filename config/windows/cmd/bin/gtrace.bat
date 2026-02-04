@echo off
if not defined ANDROID_HOME set "ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk"
set "py=%ANDROID_HOME%\platform-tools\systrace\systrace.py"
if exist "%py%" (python "%py%" %*) else (echo systrace not found)
