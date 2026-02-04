# Android 开发命令速查表

本工具包收集的别名/函数一览，macOS 与 Windows 命名一致（Windows 为 PowerShell 函数）。

---

## 一、构建 (macOS / Qt)

| 别名 | 命令 | 说明 |
|------|------|------|
| `m` | `qmake ; make` | 生成 Makefile 并编译 |
| `cm` | `make clean ; qmake ; make` | 清理后重新编译 |

---

## 二、Python

| 别名 | 命令 | 说明 |
|------|------|------|
| `python` | `python3` | 使用 Python 3 |
| `pip` | `python3 -m pip` | 使用 pip |

---

## 三、搜索与查找

| 别名/函数 | 命令 | 说明 |
|-----------|------|------|
| `grp` | `grep -rn` | 递归、显示行号 |
| `grpi` | `grep -irn` | 递归、忽略大小写、显示行号 |
| `fd` | `find . -name` | 按名称查找 |
| `fdi` | `find . -iname` | 按名称查找（不区分大小写） |

---

## 四、目录跳转

| 别名/函数 | 说明 |
|-----------|------|
| `cd-` | 回到上一目录 |
| `cd1` / `cd2` / `cd3` | 向上一级 / 两级 / 三级 |
| `cdd` | `~/debug` |
| `cdb` | `~/debug/Bug` |
| `cdr` | `~/debug/replace` |
| `cdt` | `~/debug/test-log` |

---

## 五、ADB - 设备与连接

| 别名/函数 | 命令 | 说明 |
|-----------|------|------|
| `ash` | `adb shell` | 进入设备 shell |
| `aks` | `pkill adb; adb start-server` | 重启 adb 服务 |
| `adc` | `adb disconnect` | 断开连接 |
| `arr` | `adb root; adb remount` | root + 重新挂载 |
| `adl` | `adb devices -l` | 列出设备详情 |
| `adw` | `adb wait-for-device` | 等待设备 |
| `adr` | `adb reboot` | 重启设备 |
| `adrb` | `adb reboot bootloader` | 重启到 bootloader |
| `act <后缀>` | `adb connect 192.168.<后缀>` | 如 `act 1.100` → 192.168.1.100 |
| `ad` | `adb` | 多设备时：`ad -s emulator-5554 shell` |

---

## 六、ADB - 安装与文件

| 别名/函数 | 命令 | 说明 |
|-----------|------|------|
| `ain [apk]` | `adb install -r` | 覆盖安装 |
| `ainu <pkg>` | `adb uninstall` | 卸载应用 |
| `ains` | `adb install -r -d` | 允许降级安装 |
| `apush` | `adb push` | 推文件到设备 |
| `apull` | `adb pull` | 从设备拉取文件 |
| `aforward` | `adb forward` | 端口转发 |

---

## 七、ADB - Logcat

| 别名/函数 | 命令 | 说明 |
|-----------|------|------|
| `lgc` | `adb logcat -c` | 清空 log |
| `lgt` | `adb logcat -v time` | 带时间戳的 log |
| `lgf [file]` | `adb logcat -v time -f` | 输出到文件 |
| `lgv` | `adb logcat *:V` | 全部 Verbose |
| `lgw` | `adb logcat *:W` | 仅 Warning 及以上 |
| `lgtc` | 清空后实时 log | 组合：`lgc` + `lgt` |

---

## 八、ADB - Shell 常用

| 别名/函数 | 命令 | 说明 |
|-----------|------|------|
| `apklist` | `adb shell pm list packages` | 列出所有包 |
| `apklist3` | `adb shell pm list packages -3` | 仅第三方包 |
| `apkpath <pkg>` | `adb shell pm path` | 包路径 |
| `apkclear <pkg>` | `adb shell pm clear` | 清除应用数据 |
| `awm` | `adb shell wm` | 窗口/分辨率 |
| `adumpsys` | `adb shell dumpsys` | 系统服务信息 |
| `aam` | `adb shell am` | Activity Manager |

---

## 九、屏幕与录制

| 别名/函数 | 说明 |
|-----------|------|
| `arecord` | `adb shell screenrecord` |
| `acap` | `adb shell screencap -p` 截图 |

---

## 十、调试与抓取

| 别名/函数 | 说明 |
|-----------|------|
| `gfocus` | 获取当前焦点 Activity（需本机脚本） |
| `gtrace` | systrace（需 ANDROID_HOME/platform-tools） |

---

## 十一、APK 签名与替换

| 别名/函数 | 说明 |
|-----------|------|
| `dsign` | 使用 gf 平台密钥签名 |
| `gsign` | 使用 Google 平台密钥签名 |
| `updapk` | 替换 APK 脚本 |
| `updso` | 替换 so 脚本 |

---

## 十二、Fastboot（设备需在 bootloader 模式）

| 别名/函数 | 命令 | 说明 |
|-----------|------|------|
| `fbl` | `fastboot devices` | 列出设备 |
| `fbr` | `fastboot reboot` | 重启 |
| `fbrb` | `fastboot reboot-bootloader` | 进入 bootloader |
| `fbfl` | `fastboot flashall` | 刷入全部 |
| `fbf` | `fastboot flash` | 刷入分区 |
| `fbw` | `fastboot -w` | 清除数据 |

---

## 十三、Gradle

| 别名/函数 | 说明 |
|-----------|------|
| `gass` | `./gradlew assembleDebug` |
| `gasr` | `./gradlew assembleRelease` |
| `ginst` | `./gradlew installDebug` |
| `ginstR` | `./gradlew installRelease` |
| `gclean` | `./gradlew clean` |
| `gbuild` | `./gradlew build` |
| `gdeps` | `./gradlew dependencies` |

---

## 十四、gf 设备

| 别名/函数 | 说明 |
|-----------|------|
| `decode` | Decode.jar |
| `dlog` | gf 日志脚本 |
| `dlogcat` | gf logcat 脚本 |
| `rkld` / `rkuf` / `rkdi` | upgrade_tool 子命令 |
| `freset` | 恢复出厂 |

---

## 十五、其他工具

| 别名/函数 | 说明 |
|-----------|------|
| `oss` | 打开 OSS 浏览器（macOS，需路径） |
| `oe` | `open -e` 用默认编辑器打开 |

---

## 环境变量（可选）

- **macOS**：在 `~/.android-dev-toolkit/android-dev.sh` 或 `~/.zshrc` 中设置  
  - `ANDROID_DEV_TOOLS`：工具目录，默认 `$HOME/tools/droid`  
  - `ANDROID_HOME`：Android SDK 路径  

- **Windows**：在系统环境变量或 PowerShell 配置中设置  
  - `ANDROID_DEV_TOOLS`：工具目录  
  - `ANDROID_HOME`：Android SDK 路径  

修改后重新 source 配置或重启终端即可生效。
