foreach ($port in $args) {
    try {
        $process = Get-Process -Id (Get-NetTCPConnection -LocalPort $port).OwningProcess
        $processId = $process.Id
        $processName = $process.Name
        Write-Output "port: ${port}, processName: ${processName}, processId: ${processId}"
    } catch {
        Write-Output "No process bind ${port}"
    }
}
