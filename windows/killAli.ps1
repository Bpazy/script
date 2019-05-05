If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {   
    Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" `"$args`"" -Verb RunAs
    Break
}

Write-Output 'Stop the services' 
wmic process where "name='AlibabaProtect.exe'" delete
wmic process where "name='EntSafeSvr.exe'" delete

Write-Output 'Kill the processes'
$processes = @("AliLang.exe", "AliLangDaemon.exe", "AliLangClient.exe" <# FIXME: permission denided#>, 
    "AliGuardImplementModule.exe", "AlibabaprotectUI.exe", "EntSafeUI.exe", "kvoop.exe", "RiskMon.exe")
foreach ($process in $processes) {
    taskkill /t /f /im $process
}

Write-Output 'Clean the autorun registry'
$run = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run\'
Remove-ItemProperty $run AliLang # FIXME: permission denided
Remove-ItemProperty $run AliLangClient

$run2 = 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run'
Remove-ItemProperty $run2 CloudshellUI

If ($args[0] -eq 'pause') {
    # FIXME: protect process will resume these services
    $service = 'HKLM:\SYSTEM\CurrentControlSet\Services'
    Set-ItemProperty "$service\AlibabaProtect" -name Start -value 4
    Set-ItemProperty "$service\alilangprot" -name Start -value 4
    Set-ItemProperty "$service\AliPaladin" -name Start -value 4
    Set-ItemProperty "$service\AliSystemSrv" -name Start -value 4
    Set-ItemProperty "$service\DsFs" -name Start -value 4
    Set-ItemProperty "$service\Dsns" -name Start -value 4
    Set-ItemProperty "$service\EntSafeSvr" -name Start -value 4
}

If ($args[0] -eq 'uninstall') {
    $service = 'HKLM:\SYSTEM\CurrentControlSet\Services'
    Remove-Item -Force -recurse $service\AlibabaProtect
    Remove-Item -Force -recurse $service\alilangprot
    Remove-Item -Force -recurse $service\AliPaladin
    Remove-Item -Force -recurse $service\AliSystemSrv
    Remove-Item -Force -recurse $service\DsFs
    Remove-Item -Force -recurse $service\Dsns
    Remove-Item -Force -recurse $service\EntSafeSvr

    $outlook = 'HKEY_CURRENT_USER\Software\Microsoft\Office\Outlook\Addins\'
    Remove-Item -Force -recurse $outlook\DlpOutlookAddin.DlpOutlookSensor
    
    $aliLangOverIcon = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\      AliLangOverIcon\'
    $aliLangOverIconId = $aliLangOverIcon.'(default)'
    Remove-ItemProperty HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellExecuteHooks\ $aliLangOverIconId
}

Write-Output 'Done'
pause
