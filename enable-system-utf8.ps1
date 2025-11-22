# 启用 Windows 系统 UTF-8 Beta 功能（需管理员权限）
# 此操作需要重启电脑

$ErrorActionPreference = 'Stop'

# 检查管理员权限
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "错误: 需要管理员权限" -ForegroundColor Red
    pause
    exit 1
}

Write-Host "==========================================` -ForegroundColor Cyan
Write-Host "  启用系统 UTF-8 Beta 功能" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "此操作将：" -ForegroundColor Yellow
Write-Host "  1. 修改系统区域设置" -ForegroundColor White
Write-Host "  2. 启用 UTF-8 Beta 支持" -ForegroundColor White
Write-Host "  3. 重启计算机" -ForegroundColor White
Write-Host ""

$confirm = Read-Host "确认继续吗？(Y/N)"
if ($confirm -ne 'Y' -and $confirm -ne 'y') {
    Write-Host "已取消" -ForegroundColor Yellow
    pause
    exit 0
}

try {
    # 设置注册表项以启用 UTF-8
    $regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Nls\CodePage"
    Set-ItemProperty -Path $regPath -Name "OEMCP" -Value "65001" -Type String -Force
    Set-ItemProperty -Path $regPath -Name "ACP" -Value "65001" -Type String -Force
    
    Write-Host ""
    Write-Host "✓ 系统 UTF-8 已启用" -ForegroundColor Green
    Write-Host ""
    Write-Host "系统将在 10 秒后重启..." -ForegroundColor Yellow
    Write-Host "按 Ctrl+C 取消重启" -ForegroundColor Gray
    Write-Host ""
    
    Start-Sleep -Seconds 10
    
    # 重启计算机
    Restart-Computer -Force
}
catch {
    Write-Host ""
    Write-Host "错误: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "手动方法：" -ForegroundColor Yellow
    Write-Host "  1. Win+R 运行: intl.cpl" -ForegroundColor White
    Write-Host "  2. 管理 → 更改系统区域设置" -ForegroundColor White
    Write-Host "  3. 勾选 'Beta: 使用 Unicode UTF-8'" -ForegroundColor White
    Write-Host "  4. 重启电脑" -ForegroundColor White
    Write-Host ""
    pause
    exit 1
}
