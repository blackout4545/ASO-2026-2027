# Per cada proces mostra els seus threads i el temps de processador de cadascun
$processos = Get-Process

foreach ($proces in $processos) {
    Write-Host ("=" * 30) "$($proces.ProcessName) $($proces.Id)" ("=" * 30)
    Write-Host ""
    Write-Host "Total threads: $($proces.Threads.Count)"
    Write-Host ""

    foreach ($thread in $proces.Threads) {
        # TotalProcessorTime pot no estar informat llavors surt buit (avagadas axo es depent de cada processos)
        Write-Host "ID: $($thread.Id) CPU TIME: $($thread.TotalProcessorTime)"
    }

    Write-Host ""
}