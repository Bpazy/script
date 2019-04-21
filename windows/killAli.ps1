If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

wmic process where "name='AlibabaProtect.exe'" delete
wmic process where "name='EntSafeSvr.exe'" delete
taskkill /t /f /im AliLangClient.exe
taskkill /t /f /im AliGuardImplementModule.exe
taskkill /t /f /im AliLang.exe
taskkill /t /f /im AlibabaprotectUI.exe
