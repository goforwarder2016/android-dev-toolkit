@echo off
REM =============================================================================
REM Android Dev Toolkit - Windows CMD (经典 DOS 窗口) 配置
REM 用法: 在 CMD 中执行 call android-dev.cmd 或在“安装”时勾选“每次打开 CMD 自动加载”
REM =============================================================================

REM 本脚本所在目录（安装后为 %USERPROFILE%\.android-dev-toolkit\cmd）
set "SCRIPT_DIR=%~dp0"
if "%SCRIPT_DIR:~-1%"=="\" set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
set "BIN_DIR=%SCRIPT_DIR%\bin"

REM 工具路径（可通过系统环境变量 ANDROID_DEV_TOOLS、ANDROID_HOME 覆盖，不 setlocal 以便本窗口保留）
if not defined ANDROID_DEV_TOOLS set "ANDROID_DEV_TOOLS=%USERPROFILE%\tools\droid"
if not defined ANDROID_HOME set "ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk"
set "PLATFORM_TOOLS=%ANDROID_HOME%\platform-tools"

REM 将 bin 目录加入 PATH，便于调用 gfocus.bat 等
set "PATH=%BIN_DIR%;%PATH%"

REM -----------------------------------------------------------------------------
REM 目录跳转（cd 在 CMD 中直接执行，用 doskey 包装）
REM -----------------------------------------------------------------------------
doskey cd1=cd ..
doskey cd2=cd ..\..
doskey cd3=cd ..\..\..
doskey cdd=cd /d "%USERPROFILE%\debug"
doskey cdb=cd /d "%USERPROFILE%\debug\Bug"
doskey cdr=cd /d "%USERPROFILE%\debug\replace"
doskey cdt=cd /d "%USERPROFILE%\debug\test-log"

REM -----------------------------------------------------------------------------
REM ADB - 设备与连接
REM -----------------------------------------------------------------------------
doskey ash=adb shell
doskey aks=taskkill /F /IM adb.exe 2^>nul $T adb start-server
doskey adc=adb disconnect
doskey arr=adb root $T adb remount
doskey adl=adb devices -l
doskey adw=adb wait-for-device
doskey adr=adb reboot
doskey adrb=adb reboot bootloader
doskey act=adb connect 192.168.$*
doskey ad=adb $*

REM -----------------------------------------------------------------------------
REM ADB - 安装与文件
REM -----------------------------------------------------------------------------
doskey ain=adb install -r $*
doskey ainu=adb uninstall $*
doskey ains=adb install -r -d $*
doskey apush=adb push $*
doskey apull=adb pull $*
doskey aforward=adb forward $*

REM -----------------------------------------------------------------------------
REM ADB - Logcat
REM -----------------------------------------------------------------------------
doskey lgc=adb logcat -c
doskey lgt=adb logcat -v time
doskey lgf=adb logcat -v time -f $*
doskey lgv=adb logcat *:V
doskey lgw=adb logcat *:W
doskey lgtc=adb logcat -c $T adb logcat -v time $*

REM -----------------------------------------------------------------------------
REM ADB - Shell 常用
REM -----------------------------------------------------------------------------
doskey apklist=adb shell pm list packages
doskey apklist3=adb shell pm list packages -3
doskey apkpath=adb shell pm path $*
doskey apkclear=adb shell pm clear $*
doskey awm=adb shell wm $*
doskey adumpsys=adb shell dumpsys $*
doskey aam=adb shell am $*

REM -----------------------------------------------------------------------------
REM 屏幕与录制
REM -----------------------------------------------------------------------------
doskey arecord=adb shell screenrecord $*
doskey acap=adb shell screencap -p $*

REM -----------------------------------------------------------------------------
REM Fastboot
REM -----------------------------------------------------------------------------
doskey fbl=fastboot devices
doskey fbr=fastboot reboot
doskey fbrb=fastboot reboot-bootloader
doskey fbfl=fastboot flashall
doskey fbf=fastboot flash $*
doskey fbw=fastboot -w

REM -----------------------------------------------------------------------------
REM Gradle
REM -----------------------------------------------------------------------------
doskey gass=gradlew.bat assembleDebug
doskey gasr=gradlew.bat assembleRelease
doskey ginst=gradlew.bat installDebug
doskey ginstR=gradlew.bat installRelease
doskey gclean=gradlew.bat clean
doskey gbuild=gradlew.bat build
doskey gdeps=gradlew.bat dependencies

REM -----------------------------------------------------------------------------
REM 搜索（CMD 下用 findstr / dir 简化）
REM -----------------------------------------------------------------------------
doskey grp=findstr /s /n $*
doskey fd=dir /s /b $*

REM -----------------------------------------------------------------------------
REM 依赖工具路径的命令（通过 bin 目录下的 .bat 调用，需设置 ANDROID_DEV_TOOLS）
REM -----------------------------------------------------------------------------
doskey gfocus=call "%BIN_DIR%\gfocus.bat"
doskey gtrace=call "%BIN_DIR%\gtrace.bat" $*
doskey dsign=call "%BIN_DIR%\dsign.bat" $*
doskey gsign=call "%BIN_DIR%\gsign.bat" $*
doskey updapk=call "%BIN_DIR%\updapk.bat"
doskey updso=call "%BIN_DIR%\updso.bat"
doskey decode=call "%BIN_DIR%\decode.bat" $*
doskey dlog=call "%BIN_DIR%\dlog.bat"
doskey dlogcat=call "%BIN_DIR%\dlogcat.bat"
doskey rkld=call "%BIN_DIR%\rkld.bat" $*
doskey rkuf=call "%BIN_DIR%\rkuf.bat" $*
doskey rkdi=call "%BIN_DIR%\rkdi.bat" $*
doskey freset=call "%BIN_DIR%\freset.bat"

REM -----------------------------------------------------------------------------
REM 提示
REM -----------------------------------------------------------------------------
echo [Android Dev Toolkit] CMD 别名已加载。输入 adb、fastboot 等短命令即可使用。
