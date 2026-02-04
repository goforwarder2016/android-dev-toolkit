# Android 开发工具包 (Android Dev Toolkit)

跨平台 Android 开发常用命令集合，支持 **macOS** 与 **Windows** 一键导入系统配置。

## 功能

- **双平台**：macOS (zsh/bash)、Windows (PowerShell 或经典 CMD)
- **一键导入**：运行安装脚本即可写入当前用户配置
- **命令覆盖**：ADB、Fastboot、Gradle、Logcat、APK 签名、调试等

## 目录结构

```
android-dev-toolkit/
├── README.md
├── LICENSE                  # MIT 许可证
├── .gitignore              # Git 忽略规则
├── .gitattributes          # Git 属性（行尾等）
├── install-macos.sh          # macOS 一键安装
├── uninstall-macos.sh       # macOS 一键卸载
├── install-windows.ps1      # Windows PowerShell 一键安装
├── uninstall-windows.ps1    # Windows PowerShell 一键卸载
├── install-windows-cmd.bat  # Windows CMD（经典 DOS 窗口）一键安装
├── uninstall-windows-cmd.bat # Windows CMD 一键卸载
├── config/
│   ├── macos/
│   │   └── android-dev.sh   # macOS 别名与函数
│   └── windows/
│       ├── android-dev.ps1  # Windows PowerShell 函数
│       └── cmd/
│           ├── android-dev.cmd  # CMD 配置（doskey + 环境变量）
│           └── bin/             # CMD 下需参数或工具路径的 .bat
└── docs/
    └── COMMANDS.md         # 命令速查表
```

## 安装

### macOS

```bash
cd android-dev-toolkit
chmod +x install-macos.sh
./install-macos.sh
```

安装脚本会：

1. 将 `config/macos/android-dev.sh` 复制到 `~/.android-dev-toolkit/`
2. 在 `~/.zshrc`（或 `~/.bashrc`）末尾添加一行：`source ~/.android-dev-toolkit/android-dev.sh`
3. 卸载：`./uninstall-macos.sh` 或 `./install-macos.sh uninstall`；查看状态：`./install-macos.sh status`

重新打开终端或执行 `source ~/.zshrc` 后生效。

### Windows（PowerShell）

在 PowerShell 中执行（首次若提示无法执行脚本，先运行第一行）：

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
cd path\to\android-dev-toolkit
.\install-windows.ps1
```

可选参数：`-Action install`（默认）、`-Action uninstall`、`-Action status`。

安装脚本会：

1. 将 `config/windows/android-dev.ps1` 复制到 `$env:USERPROFILE\.android-dev-toolkit\`
2. 在 PowerShell 用户配置文件中添加加载语句（不存在则创建）
3. 卸载：`.\uninstall-windows.ps1` 或 `.\install-windows.ps1 -Action uninstall`

重新打开 PowerShell 后生效。

### Windows（经典 CMD / DOS 窗口）

在 **命令提示符 (cmd.exe)** 中执行：

```cmd
cd path\to\android-dev-toolkit
install-windows-cmd.bat
```

安装脚本会：

1. 将 `config\windows\cmd` 复制到 `%USERPROFILE%\.android-dev-toolkit\cmd\`
2. 询问是否「每次打开 CMD 时自动加载」；选 Y 则写入注册表 `HKCU\...\Command Processor\Autorun`，新开的 CMD 会自动加载
3. 若选 N，则需在每次要用时执行：`call %USERPROFILE%\.android-dev-toolkit\cmd\android-dev.cmd`

**说明**：CMD 下通过 `doskey` 定义别名，仅对当前窗口有效；自动加载依赖注册表 Autorun。

卸载：在 CMD 中执行 `uninstall-windows-cmd.bat`，将移除注册表 Autorun 并删除 `%USERPROFILE%\.android-dev-toolkit\cmd`。

## 卸载

| 平台 | 卸载方式 |
|------|----------|
| **macOS** | `./uninstall-macos.sh`（或 `./install-macos.sh uninstall`） |
| **Windows PowerShell** | `.\uninstall-windows.ps1`（或 `.\install-windows.ps1 -Action uninstall`） |
| **Windows CMD** | `uninstall-windows-cmd.bat` |

卸载会：从 shell 配置/注册表移除加载项，并删除本工具包复制到用户目录下的文件（`~/.android-dev-toolkit` 或 `%USERPROFILE%\.android-dev-toolkit\`）。

## 配置说明

- **工具路径**：脚本内使用 `$HOME`（macOS）或 `%USERPROFILE%`/`$env:USERPROFILE`（Windows），如需自定义工具目录（如 `~/tools/droid`），请编辑复制后的文件或设置环境变量 `ANDROID_DEV_TOOLS`、`ANDROID_HOME`：
  - macOS: `~/.android-dev-toolkit/android-dev.sh`
  - Windows PowerShell: `$env:USERPROFILE\.android-dev-toolkit\android-dev.ps1`
  - Windows CMD: `%USERPROFILE%\.android-dev-toolkit\cmd\android-dev.cmd`（或通过环境变量）
- **ADB 连接**：`act 1.100` 表示连接 `192.168.1.100`，网段可在脚本中修改。

## 命令速查

详见 [docs/COMMANDS.md](docs/COMMANDS.md)。

## 许可证

本项目采用 [MIT 许可证](LICENSE)。
