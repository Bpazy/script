foreach ($port in $args) {
    $process = Get-Process -Id (Get-NetTCPConnection -LocalPort $port).OwningProcess
    $processId = $process.Id
    $processName = $process.Name
    Write-Output "port: ${port}, processName: ${processName}, processId: ${processId}"
}
