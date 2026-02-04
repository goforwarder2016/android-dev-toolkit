# =============================================================================
# Android Dev Toolkit - Windows PowerShell 一键卸载
# 从 PowerShell 用户配置移除加载语句并删除 $env:USERPROFILE\.android-dev-toolkit
# =============================================================================

# 不使用 Stop，允许部分操作失败时继续执行清理
$ErrorActionPreference = "Continue"
$ToolkitName = "android-dev-toolkit"
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

Write-Host "正在卸载 Android Dev Toolkit..."

$content = Get-ProfileContent
if ($content -match "android-dev-toolkit|android-dev\.ps1") {
  $newContent = $content -replace "`n# Android Dev Toolkit \(one-click install\)`n\. `".*android-dev\.ps1`"`n?", "`n"
  Set-Content -Path $ProfilePath -Value $newContent.TrimEnd()
  Write-Host "已从 $ProfilePath 移除注入"
} else {
  Write-Host "未在配置文件中检测到注入"
}

if (Test-Path $TargetDir) {
  Remove-Item $TargetDir -Recurse -Force
  Write-Host "已删除 $TargetDir"
} else {
  Write-Host "未找到安装目录 $TargetDir"
}

Write-Host "卸载完成。请重新打开 PowerShell 使配置生效。"
