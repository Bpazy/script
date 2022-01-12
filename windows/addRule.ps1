# 不支持 Service Mode
Stop-Process -Name "Clash for Windows"
Stop-Process -Name "clash-win64"

if ($args.Count -eq 0) {
    return
}

if ($args[0].StartsWith("http://") -or $args[0].StartsWith("https://")) {
    $arr = ([System.Uri]$args[0]).Host -split "\."
    $domain = $arr[-2..-1] -join "."
} else {
    $arr = $args[0] -split "\."
    $domain = $arr[-2..-1] -join "."
}

$newRule = "  - DOMAIN-SUFFIX," + $domain
Write-Output $newRule
Add-Content -Path "C:\Users\hanzi\.config\clash\ruleset\myproxy.yaml" -Value $newRule
Start-Process -RedirectStandardOutput nul "C:\Users\hanzi\AppData\Local\Programs\Clash for Windows\Clash for Windows.exe"
