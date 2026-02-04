# =============================================================================
# Android Dev Toolkit - Windows 一键安装
# 将 config/windows/android-dev.ps1 复制到 $env:USERPROFILE\.android-dev-toolkit
# 并在 PowerShell 用户配置文件中添加 . .\android-dev.ps1
# =============================================================================

$ErrorActionPreference = "Stop"
$ToolkitName = "android-dev-toolkit"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ConfigSrc = Join-Path $ScriptDir "config\windows\android-dev.ps1"
$TargetDir = Join-Path $env:USERPROFILE ".$ToolkitName"
$TargetFile = Join-Path $TargetDir "android-dev.ps1"
$ProfilePath = $PROFILE.CurrentUserAllHosts

function Get-ProfileContent {
  if (Test-Path $ProfilePath) {
    Get-Content $ProfilePath -Raw
  } else {
    ""
  }
}

function Install-Toolkit {
  if (-not (Test-Path $ConfigSrc)) {
    Write-Host "错误: 未找到配置文件: $ConfigSrc" -ForegroundColor Red
    exit 1
  }
  New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
  Copy-Item $ConfigSrc $TargetFile -Force
  Write-Host "已复制配置到: $TargetFile"

  $dotSourceLine = ". `"$TargetFile`""
  $commentLine = "# Android Dev Toolkit (one-click install)"
  $content = Get-ProfileContent
  if ($content -match "android-dev-toolkit|android-dev\.ps1") {
    Write-Host "检测到已有注入，跳过写入配置文件"
  } else {
    $dir = Split-Path $ProfilePath -Parent
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    $append = "`n$commentLine`n$dotSourceLine`n"
    Add-Content -Path $ProfilePath -Value $append
    Write-Host "已在 PowerShell 配置末尾添加加载语句: $ProfilePath"
  }
  Write-Host "安装完成。请重新打开 PowerShell 或执行: . `"$TargetFile`""
}

function Uninstall-Toolkit {
  $content = Get-ProfileContent
  if ($content -match "android-dev-toolkit|android-dev\.ps1") {
    $newContent = $content -replace "`n# Android Dev Toolkit \(one-click install\)`n\. `".*android-dev\.ps1`"`n?", "`n"
    Set-Content -Path $ProfilePath -Value $newContent.TrimEnd()
    Write-Host "已从 $ProfilePath 移除注入"
  }
  if (Test-Path $TargetDir) {
    Remove-Item $TargetDir -Recurse -Force
    Write-Host "已删除 $TargetDir"
  }
  Write-Host "卸载完成"
}

function Get-Status {
  if (Test-Path $TargetFile) {
    Write-Host "已安装: $TargetFile"
    $content = Get-ProfileContent
    if ($content -match "android-dev") {
      Write-Host "已注入: $ProfilePath"
    } else {
      Write-Host "未注入 $ProfilePath，请手动添加: . `"$TargetFile`""
    }
  } else {
    Write-Host "未安装。运行 .\install-windows.ps1 -Action install 进行安装"
  }
}

param(
  [ValidateSet("install", "uninstall", "status")]
  [string]$Action = "install"
)

switch ($Action) {
  "install"   { Install-Toolkit }
  "uninstall" { Uninstall-Toolkit }
  "status"    { Get-Status }
}
