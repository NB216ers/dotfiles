function Test-ProxyWorking {
    param (
        [string]$ProxyAddress = "http://127.0.0.1:10809",
        [string]$TestUrl = "https://www.google.com"
    )
    try {
        $response = Invoke-WebRequest -Uri $TestUrl -Proxy $ProxyAddress -TimeoutSec 3 -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

function Test-ProxyConnection {
    param (
        [string]$TestUrl = "https://www.google.com",
        [int]$Timeout = 3
    )
    
    if (-not $env:HTTP_PROXY) {
        Write-Host "❌ 未检测到代理设置" -ForegroundColor Red
        return $false
    }

    try {
        Write-Host "正在测试代理连接 ($env:HTTP_PROXY)..." -ForegroundColor Cyan
        $response = Invoke-WebRequest -Uri $TestUrl -Proxy $env:HTTP_PROXY -TimeoutSec $Timeout -ErrorAction Stop
        
        if ($response.StatusCode -eq 200) {
            Write-Host "✅ 代理连接验证成功！" -ForegroundColor Green
            return $true
        }
    } catch {
        Write-Host "❌ 代理连接失败: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

function Set-SmartProxy {
    param (
        [string[]]$ProxyList = @("http://127.0.0.1:10809","http://127.0.0.1:7890"),
        [switch]$AutoVerify
    )
    
    foreach ($proxy in $ProxyList) {
        if (Test-ProxyWorking -ProxyAddress $proxy) {
            $env:HTTP_PROXY = $proxy
            $env:HTTPS_PROXY = $proxy
            Write-Host "✅ 代理已设置: $proxy" -ForegroundColor Green
            
            if ($AutoVerify) {
                if (-not (Test-ProxyConnection)) {
                    Remove-Item Env:\HTTP_PROXY -ErrorAction SilentlyContinue
                    Remove-Item Env:\HTTPS_PROXY -ErrorAction SilentlyContinue
                    Write-Host "⚠️ 已清除无效代理设置" -ForegroundColor Yellow
                    return $false
                }
            }
            return $true
        }
    }
    
    Write-Host "❌ 无可用代理" -ForegroundColor Red
    return $false
}

Export-ModuleMember -Function Test-ProxyWorking, Test-ProxyConnection, Set-SmartProxy
