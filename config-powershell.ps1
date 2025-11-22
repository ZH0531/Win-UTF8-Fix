# PowerShell UTF-8 永久配置
$ErrorActionPreference = 'Stop'

# 配置内容
$utf8Config = @'
# UTF-8 Encoding Configuration
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
$PSDefaultParameterValues['*:Encoding'] = 'utf8'
chcp 65001 > $null
'@

try {
    # 确保配置文件目录存在
    $profileDir = Split-Path -Parent $PROFILE
    if (!(Test-Path $profileDir)) {
        New-Item -Path $profileDir -ItemType Directory -Force | Out-Null
    }

    # 检查是否已配置
    if (Test-Path $PROFILE) {
        $currentContent = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue
        if ($currentContent -match 'UTF-8 Encoding Configuration') {
            Write-Host "  已存在 UTF-8 配置，跳过" -ForegroundColor Yellow
            exit 0
        }
    }

    # 添加配置
    if (!(Test-Path $PROFILE)) {
        New-Item -Path $PROFILE -ItemType File -Force | Out-Null
    }
    Add-Content -Path $PROFILE -Value "`n$utf8Config" -Encoding UTF8
    
    Write-Host "  配置文件: $PROFILE" -ForegroundColor Gray
    exit 0
}
catch {
    Write-Host "  错误: $_" -ForegroundColor Red
    exit 1
}
