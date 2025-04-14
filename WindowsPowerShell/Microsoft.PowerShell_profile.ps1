$env:EDITOR = 'nvim'

Invoke-Expression (&starship init powershell)


Invoke-Expression (& { (zoxide init powershell | Out-String) })

function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}

######################---代理检测设置---####################
# 在 PowerShell 启动时询问是否连接代理
$choice = $Host.UI.PromptForChoice("Proxy Settings", "Do you want to connect to a proxy?", @("&Yes", "&No"), 1)

if ($choice -eq 0) {
    # 用户选择"是"才加载模块
    if (Get-Module -ListAvailable -Name NetworkUtils) {
        Import-Module NetworkUtils -Force
        
        # 设置并验证代理
        if (Set-SmartProxy -AutoVerify) {
            Write-Host "✅ Proxy connected" -ForegroundColor Green
            # 添加快捷命令
            function proxy-off {
                Remove-Item Env:\HTTP_PROXY -ErrorAction SilentlyContinue
                Remove-Item Env:\HTTPS_PROXY -ErrorAction SilentlyContinue
                Write-Host "Proxy has been disabled" -ForegroundColor Yellow
            }
            function proxy-test { Test-ProxyConnection }
        }
    } else {
        Write-Warning "NetworkUtils module is not installed"
        Write-Host "Run the following command to create the module:" -ForegroundColor Cyan
        Write-Host "1. New-Item -ItemType Directory `"$env:USERPROFILE\Documents\PowerShell\Modules\NetworkUtils`""
        Write-Host "2. Save the module code as NetworkUtils.psm1 in this directory."
    }
} else {
    Write-Host "Proxy connection skipped" -ForegroundColor Yellow
}

######################---代理检测设置---####################
