Write-Output 正在设置 Scoop 环境变量
$env:SCOOP='C:\MyProgram\ScoopPrograms'
[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')
$env:SCOOP_GLOBAL='C:\MyProgram\ScoopGlobalPrograms'
[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')

Write-Output 正在安装 Scoop 
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

Write-Output 正在设置 Scoop 代理
scoop config proxy 127.0.0.1:10809

Write-Output 正在安装 sudo 
scoop install -g sudo 
