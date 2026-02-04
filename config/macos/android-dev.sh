# =============================================================================
# Android Dev Toolkit - macOS 配置
# 来源: source ~/.android-dev-toolkit/android-dev.sh 或由 install-macos.sh 注入
# =============================================================================

# 工具根目录（可按本机修改，如 ~/tools/droid）
TOOLS_DROID="${ANDROID_DEV_TOOLS:-$HOME/tools/droid}"
ANDROID_SDK="${ANDROID_HOME:-$HOME/Library/Android/sdk}"
PLATFORM_TOOLS="${ANDROID_SDK}/platform-tools"

# -----------------------------------------------------------------------------
# 构建 (macOS / Qt)
# -----------------------------------------------------------------------------
alias m='qmake ; make'
alias cm='make clean ; qmake ; make'

# -----------------------------------------------------------------------------
# Python
# -----------------------------------------------------------------------------
alias python="python3"
alias pip="python3 -m pip"

# -----------------------------------------------------------------------------
# 搜索与查找
# -----------------------------------------------------------------------------
alias grp='grep -rn'
alias grpi='grep -irn'
alias fd='find . -name'
alias fdi='find . -iname'

# -----------------------------------------------------------------------------
# 目录跳转
# -----------------------------------------------------------------------------
alias cd-='cd -'
alias cd1='cd ../'
alias cd2='cd ../../'
alias cd3='cd ../../../'
alias cdd='cd ~/debug'
alias cdb='cd ~/debug/Bug'
alias cdr='cd ~/debug/replace'
alias cdt='cd ~/debug/test-log'

# -----------------------------------------------------------------------------
# ADB - 设备与连接
# -----------------------------------------------------------------------------
alias ash='adb shell'
alias aks='pkill adb; adb start-server'
alias adc='adb disconnect'
alias arr='adb root; adb remount'
alias adl='adb devices -l'
alias adw='adb wait-for-device'
alias adr='adb reboot'
alias adrb='adb reboot bootloader'

# adb connect: act 1.100 -> 192.168.1.100
act() { adb connect "192.168.${1:-1.1}"; }

# ADB 安装/卸载
alias ain='adb install -r'
alias ainu='adb uninstall'
alias ains='adb install -r -d'   # 允许降级

# ADB 文件
alias apush='adb push'
alias apull='adb pull'

# ADB 端口转发
alias aforward='adb forward'

# -----------------------------------------------------------------------------
# ADB - Logcat
# -----------------------------------------------------------------------------
alias lgc='adb logcat -c'
alias lgt='adb logcat -v time'
alias lgf='adb logcat -v time -f'
alias lgb='adb logcat -b'
alias lgv='adb logcat *:V'
alias lgw='adb logcat *:W'

# -----------------------------------------------------------------------------
# ADB - Shell 常用
# -----------------------------------------------------------------------------
alias apklist='adb shell pm list packages'
alias apklist3='adb shell pm list packages -3'
alias apkpath='adb shell pm path'
alias apkclear='adb shell pm clear'
alias awm='adb shell wm'
alias adumpsys='adb shell dumpsys'
alias aam='adb shell am'

# -----------------------------------------------------------------------------
# 调试与抓取
# -----------------------------------------------------------------------------
alias gfocus="${TOOLS_DROID}/get_focus_activity.sh 2>/dev/null || true"
alias gtrace="python3 ${PLATFORM_TOOLS}/systrace/systrace.py 2>/dev/null || echo 'systrace not found, check ANDROID_HOME'"

# -----------------------------------------------------------------------------
# APK 签名
# -----------------------------------------------------------------------------
alias dsign='java -jar ${TOOLS_DROID}/gf_signkey/signapk.jar ${TOOLS_DROID}/gf_signkey/platform.x509.pem ${TOOLS_DROID}/gf_signkey/platform.pk8'
alias gsign='java -jar ${TOOLS_DROID}/google_signkey/signapk.jar ${TOOLS_DROID}/google_signkey/platform.x509.pem ${TOOLS_DROID}/google_signkey/platform.pk8'

# -----------------------------------------------------------------------------
# 替换 APK / SO
# -----------------------------------------------------------------------------
alias updapk="${TOOLS_DROID}/replace_apk.sh 2>/dev/null || true"
alias updso="${TOOLS_DROID}/replace_so.sh 2>/dev/null || true"

# -----------------------------------------------------------------------------
# gf 设备
# -----------------------------------------------------------------------------
alias decode="java -jar ${TOOLS_DROID}/Decode.jar 2>/dev/null || true"
alias dlog="${TOOLS_DROID}/gf_Log_macOS.sh 2>/dev/null || true"
alias dlogcat="${TOOLS_DROID}/gf_Logcat_macOS.sh 2>/dev/null || true"
alias rkld="${TOOLS_DROID}/upgrade_tool ld 2>/dev/null || true"
alias rkuf="${TOOLS_DROID}/upgrade_tool uf 2>/dev/null || true"
alias rkdi="${TOOLS_DROID}/upgrade_tool di 2>/dev/null || true"
alias freset="${TOOLS_DROID}/factory_reset.sh 2>/dev/null || true"

# -----------------------------------------------------------------------------
# Fastboot（需在 bootloader 模式）
# -----------------------------------------------------------------------------
alias fbl='fastboot devices'
alias fbr='fastboot reboot'
alias fbrb='fastboot reboot-bootloader'
alias fbfl='fastboot flashall'
alias fbf='fastboot flash'
alias fboem='fastboot oem'
alias fbw='fastboot -w'

# -----------------------------------------------------------------------------
# Gradle（若在项目根目录）
# -----------------------------------------------------------------------------
alias gass='./gradlew assembleDebug'
alias gasr='./gradlew assembleRelease'
alias ginst='./gradlew installDebug'
alias ginstR='./gradlew installRelease'
alias gclean='./gradlew clean'
alias gbuild='./gradlew build'
alias gdeps='./gradlew dependencies'

# -----------------------------------------------------------------------------
# 应用/文件打开
# -----------------------------------------------------------------------------
alias oss="open -a ${TOOLS_DROID}/../oss-browser-darwin-x64/oss-browser.app 2>/dev/null || true"
alias oe='open -e'

# -----------------------------------------------------------------------------
# 多设备时指定设备执行（示例：ad -s emulator-5554 shell）
# -----------------------------------------------------------------------------
ad() { adb "$@"; }

# -----------------------------------------------------------------------------
# 常用组合：清 log 并实时看
# -----------------------------------------------------------------------------
lgtc() { adb logcat -c && adb logcat -v time "$@"; }

# -----------------------------------------------------------------------------
# 屏幕录制 / 截图
# -----------------------------------------------------------------------------
alias arecord='adb shell screenrecord'
alias acap='adb shell screencap -p'
