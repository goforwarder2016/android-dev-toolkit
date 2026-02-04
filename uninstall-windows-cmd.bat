@echo off
setlocal
REM =============================================================================
REM Android Dev Toolkit - Windows CMD 一键卸载
REM 移除注册表 Autorun 并删除 %USERPROFILE%\.android-dev-toolkit\cmd
REM =============================================================================

set "TARGET=%USERPROFILE%\.android-dev-toolkit\cmd"

echo 正在卸载 Android Dev Toolkit for CMD...

REM 移除 CMD 启动时自动加载
reg query "HKCU\Software\Microsoft\Command Processor" /v Autorun >nul 2>&1
if %errorlevel% equ 0 (
  reg delete "HKCU\Software\Microsoft\Command Processor" /v Autorun /f >nul 2>&1
  if %errorlevel% equ 0 (
    echo 已移除 CMD Autorun
  ) else (
    echo 移除 Autorun 失败，请以管理员身份运行或手动执行:
    echo   reg delete "HKCU\Software\Microsoft\Command Processor" /v Autorun /f
  )
) else (
  echo 未设置 CMD Autorun
)

REM 删除安装目录
if exist "%TARGET%" (
  rd /s /q "%TARGET%"
  echo 已删除 %TARGET%
) else (
  echo 未找到安装目录 %TARGET%
)

echo 卸载完成。
endlocal
