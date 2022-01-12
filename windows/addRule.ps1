# 不支持 Service Mode
taskkill /f /im "Clash for Windows.exe"
taskkill /f /im "clash-win64.exe"

if ($args.Count -eq 0) {
    return
}

$newRule = "`r`n  - DOMAIN-SUFFIX," + $args[0]
Write-Output $newRule
Add-Content -Path "C:\Users\hanzi\.config\clash\ruleset\myproxy.yaml" -Value $newRule
Start-Process "C:\Users\hanzi\AppData\Local\Programs\Clash for Windows\Clash for Windows.exe"
