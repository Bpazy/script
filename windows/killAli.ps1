If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

Write-Output 'Stop the services' 
wmic process where "name='AlibabaProtect.exe'" delete
wmic process where "name='EntSafeSvr.exe'" delete

Write-Output 'Kill the processes'
taskkill /t /f /im AliLang.exe
taskkill /t /f /im AliLangDaemon.exe
taskkill /t /f /im AliLangClient.exe # TODO permission denided
taskkill /t /f /im AliGuardImplementModule.exe
taskkill /t /f /im AlibabaprotectUI.exe
taskkill /t /f /im EntSafeUI.exe

Write-Output 'Clean the registry'
$run = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run\'
Remove-ItemProperty $run AliLang # TODO permission denided
Remove-ItemProperty $run AliLangClient

$run2 = 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run'
Remove-ItemProperty $run2 CloudshellUI

$service = 'HKLM:\SYSTEM\CurrentControlSet\Services'
Remove-Item -Force -recurse $service\AlibabaProtect
Remove-Item -Force -recurse $service\alilangprot
Remove-Item -Force -recurse $service\AliPaladin
Remove-Item -Force -recurse $service\AliSystemSrv
Remove-Item -Force -recurse $service\DsFs
Remove-Item -Force -recurse $service\Dsns

$outlook = 'HKEY_CURRENT_USER\Software\Microsoft\Office\Outlook\Addins\'
Remove-Item -Force -recurse $outlook\DlpOutlookAddin.DlpOutlookSensor

$aliLangOverIcon = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers\      AliLangOverIcon\'
$aliLangOverIconId = $aliLangOverIcon.'(default)'
Remove-ItemProperty HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellExecuteHooks\ $aliLangOverIconId
Write-Output 'Done'

pause
