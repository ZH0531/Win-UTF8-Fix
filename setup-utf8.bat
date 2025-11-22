@echo off
chcp 65001 >nul
title Windows UTF-8 一键修复工具

cls
echo ==========================================
echo   Windows UTF-8 一键修复工具 v1.0
echo ==========================================
echo.
echo 此工具将完成：
echo  [1] PowerShell UTF-8 配置（永久）
echo  [2] Git UTF-8 配置（全局）
echo  [3] 系统 UTF-8 Beta（需重启电脑）
echo.
echo 按任意键开始...
pause >nul

echo.
echo [1/3] 配置 PowerShell UTF-8...
powershell -ExecutionPolicy Bypass -File "%~dp0config-powershell.ps1"
if errorlevel 1 (
    echo [警告] PowerShell 配置失败，继续...
) else (
    echo [完成] PowerShell 配置成功
)

echo.
echo [2/3] 配置 Git UTF-8...
call "%~dp0config-git.bat"
echo [完成] Git 配置成功

echo.
echo [3/3] 系统 UTF-8 Beta（需管理员权限+重启）
echo.
choice /C YN /M "是否启用系统 UTF-8 并重启电脑"

if errorlevel 2 goto skip_reboot
if errorlevel 1 goto do_reboot
goto skip_reboot

:do_reboot
echo.
echo 正在请求管理员权限...
powershell -Command "Start-Process powershell -ArgumentList '-ExecutionPolicy Bypass -File \"%~dp0enable-system-utf8.ps1\"' -Verb RunAs"
echo.
echo [提示] 如果 UAC 弹窗出现，请点击"是"
echo [提示] 系统将在确认后自动重启
echo.
pause
exit

:skip_reboot
echo.
echo [跳过] 系统 UTF-8 Beta 设置已跳过
echo.
echo ==========================================
echo   配置完成！
echo ==========================================
echo.
echo 生效方式：
echo  - 关闭并重新打开 PowerShell/终端
echo  - Git 命令立即生效
echo.
echo 测试命令：
echo  - PowerShell: Write-Host "你好世界"
echo  - Git: git log --oneline -1
echo.
echo 如需完全生效，建议手动启用系统 UTF-8：
echo  Win+R → intl.cpl → 管理 → 更改系统区域设置
echo  勾选"Beta: 使用 Unicode UTF-8"→ 重启
echo.
pause
