# =============================================================================
# Android Dev Toolkit - Windows PowerShell 配置
# 由 install-windows.ps1 注入到 PowerShell 用户配置
# =============================================================================

$script:TOOLS_DROID = if ($env:ANDROID_DEV_TOOLS) { $env:ANDROID_DEV_TOOLS } else { Join-Path $env:USERPROFILE "tools\droid" }
$script:ANDROID_SDK = if ($env:ANDROID_HOME) { $env:ANDROID_HOME } else { Join-Path $env:LOCALAPPDATA "Android\Sdk" }
$script:PLATFORM_TOOLS = Join-Path $script:ANDROID_SDK "platform-tools"

# -----------------------------------------------------------------------------
# 搜索与查找
# -----------------------------------------------------------------------------
function grp { param([string]$pattern) Get-ChildItem -Recurse -File | Select-String -Pattern $pattern }
function fd { param([string]$name) Get-ChildItem -Recurse -Filter $name -ErrorAction SilentlyContinue }
function fdi { param([string]$name) Get-ChildItem -Recurse -Filter $name -ErrorAction SilentlyContinue }

# -----------------------------------------------------------------------------
# 目录跳转
# -----------------------------------------------------------------------------
function cd1 { Set-Location .. }
function cd2 { Set-Location ..\.. }
function cd3 { Set-Location ..\..\.. }
function cdd { Set-Location (Join-Path $env:USERPROFILE "debug") }
function cdb { Set-Location (Join-Path $env:USERPROFILE "debug\Bug") }
function cdr { Set-Location (Join-Path $env:USERPROFILE "debug\replace") }
function cdt { Set-Location (Join-Path $env:USERPROFILE "debug\test-log") }

# -----------------------------------------------------------------------------
# ADB - 设备与连接
# -----------------------------------------------------------------------------
function ash { adb shell }
function aks { Get-Process adb -ErrorAction SilentlyContinue | Stop-Process -Force; adb start-server }
function adc { adb disconnect }
function arr { adb root; adb remount }
function adl { adb devices -l }
function adw { adb wait-for-device }
function adr { adb reboot }
function adrb { adb reboot bootloader }

function act {
  param([string]$suffix = "1.1")
  adb connect "192.168.$suffix"
}

function ain { param([string]$apk) adb install -r $apk }
function ainu { param([string]$pkg) adb uninstall $pkg }
function apush { param([string]$local, [string]$remote) adb push $local $remote }
function apull { param([string]$remote, [string]$local) adb pull $remote $local }
function aforward { adb forward @args }

# -----------------------------------------------------------------------------
# ADB - Logcat
# -----------------------------------------------------------------------------
function lgc { adb logcat -c }
function lgt { adb logcat -v time }
function lgf { param([string]$file) adb logcat -v time -f $file }
function lgv { adb logcat *:V }
function lgw { adb logcat *:W }

# -----------------------------------------------------------------------------
# ADB - Shell 常用
# -----------------------------------------------------------------------------
function apklist { adb shell pm list packages }
function apklist3 { adb shell pm list packages -3 }
function apkpath { param([string]$pkg) adb shell pm path $pkg }
function apkclear { param([string]$pkg) adb shell pm clear $pkg }
function awm { adb shell wm @args }
function adumpsys { adb shell dumpsys @args }
function aam { adb shell am @args }

# -----------------------------------------------------------------------------
# 调试与抓取
# -----------------------------------------------------------------------------
function gfocus {
  $p = Join-Path $script:TOOLS_DROID "get_focus_activity.ps1"
  if (Test-Path $p) { & $p } else { Write-Host "get_focus_activity.ps1 not found" }
}
function gtrace {
  $py = Join-Path $script:PLATFORM_TOOLS "systrace\systrace.py"
  if (Test-Path $py) { python $py @args } else { Write-Host "systrace not found" }
}

# -----------------------------------------------------------------------------
# APK 签名
# -----------------------------------------------------------------------------
function dsign {
  param([string]$apk)
  $j = Join-Path $script:TOOLS_DROID "gf_signkey\signapk.jar"
  $x = Join-Path $script:TOOLS_DROID "gf_signkey\platform.x509.pem"
  $p = Join-Path $script:TOOLS_DROID "gf_signkey\platform.pk8"
  java -jar $j $x $p $apk
}
function gsign {
  param([string]$apk)
  $j = Join-Path $script:TOOLS_DROID "google_signkey\signapk.jar"
  $x = Join-Path $script:TOOLS_DROID "google_signkey\platform.x509.pem"
  $p = Join-Path $script:TOOLS_DROID "google_signkey\platform.pk8"
  java -jar $j $x $p $apk
}

# -----------------------------------------------------------------------------
# 替换 APK / SO
# -----------------------------------------------------------------------------
function updapk {
  $p = Join-Path $script:TOOLS_DROID "replace_apk.ps1"
  if (Test-Path $p) { & $p } else { Write-Host "replace_apk.ps1 not found" }
}
function updso {
  $p = Join-Path $script:TOOLS_DROID "replace_so.ps1"
  if (Test-Path $p) { & $p } else { Write-Host "replace_so.ps1 not found" }
}

# -----------------------------------------------------------------------------
# gf 设备
# -----------------------------------------------------------------------------
function decode { java -jar (Join-Path $script:TOOLS_DROID "Decode.jar") @args }
function dlog { & (Join-Path $script:TOOLS_DROID "gf_Log.ps1") }
function dlogcat { & (Join-Path $script:TOOLS_DROID "gf_Logcat.ps1") }
function rkld { & (Join-Path $script:TOOLS_DROID "upgrade_tool.exe") ld @args }
function rkuf { & (Join-Path $script:TOOLS_DROID "upgrade_tool.exe") uf @args }
function rkdi { & (Join-Path $script:TOOLS_DROID "upgrade_tool.exe") di @args }
function freset { & (Join-Path $script:TOOLS_DROID "factory_reset.ps1") }

# -----------------------------------------------------------------------------
# Fastboot
# -----------------------------------------------------------------------------
function fbl { fastboot devices }
function fbr { fastboot reboot }
function fbrb { fastboot reboot-bootloader }
function fbfl { fastboot flashall }
function fbf { param([string]$part, [string]$img) fastboot flash $part $img }
function fbw { fastboot -w }

# -----------------------------------------------------------------------------
# Gradle
# -----------------------------------------------------------------------------
function gass { .\gradlew.bat assembleDebug }
function gasr { .\gradlew.bat assembleRelease }
function ginst { .\gradlew.bat installDebug }
function ginstR { .\gradlew.bat installRelease }
function gclean { .\gradlew.bat clean }
function gbuild { .\gradlew.bat build }
function gdeps { .\gradlew.bat dependencies }

# -----------------------------------------------------------------------------
# 常用组合
# -----------------------------------------------------------------------------
function lgtc { adb logcat -c; adb logcat -v time @args }

# -----------------------------------------------------------------------------
# 屏幕录制 / 截图
# -----------------------------------------------------------------------------
function arecord { adb shell screenrecord @args }
function acap { adb shell screencap -p @args }

# -----------------------------------------------------------------------------
# 多设备：ad -s emulator-5554 shell
# -----------------------------------------------------------------------------
function ad { adb @args }
