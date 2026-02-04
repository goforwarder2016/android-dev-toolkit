@echo off
setlocal
REM =============================================================================
REM Android Dev Toolkit - Windows CMD 一键安装
REM 将 config\windows\cmd 复制到 %USERPROFILE%\.android-dev-toolkit\cmd
REM 可选：设置 CMD 启动时自动加载（注册表 Autorun）
REM =============================================================================

set "SCRIPT_DIR=%~dp0"
if "%SCRIPT_DIR:~-1%"=="\" set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
set "SRC=%SCRIPT_DIR%\config\windows\cmd"
set "TARGET=%USERPROFILE%\.android-dev-toolkit\cmd"
set "LOAD_CMD=call ^"%TARGET%\android-dev.cmd^""

if not exist "%SRC%\android-dev.cmd" (
  echo Error: config not found at %SRC%
  exit /b 1
)

echo Installing Android Dev Toolkit for CMD...
mkdir "%TARGET%" 2>nul
xcopy /E /Y "%SRC%\*" "%TARGET%\" >nul
echo Installed to: %TARGET%

set /p AUTO="每次打开 CMD 时自动加载? (Y/N，默认 N): "
if /i "%AUTO%"=="Y" (
  reg add "HKCU\Software\Microsoft\Command Processor" /v Autorun /t REG_SZ /d "%LOAD_CMD%" /f >nul 2>&1
  if errorlevel 1 (
    echo Failed to set Autorun. Run this script as Administrator or add manually:
    echo   reg add "HKCU\Software\Microsoft\Command Processor" /v Autorun /t REG_SZ /d "%LOAD_CMD%" /f
  ) else (
    echo Autorun set. New CMD windows will load the toolkit automatically.
  )
) else (
  echo To load in current window, run: call "%TARGET%\android-dev.cmd"
  echo To remove Autorun later: reg delete "HKCU\Software\Microsoft\Command Processor" /v Autorun /f
)

echo.
echo Done. Open a new CMD and run: call "%TARGET%\android-dev.cmd"
endlocal
