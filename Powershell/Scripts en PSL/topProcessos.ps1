# els 10 processos amb mes consum de CPU
$processos = Get-Process
$totalProcessos = $processos.Count

Write-Host "===== TOP 10 PROCESSOS PER CPU ====="
Write-Host ""


$processos |
    Sort-Object CPU -Descending |
    Select-Object -First 10 Name, Id, CPU |
    Format-Table -AutoSize |
    Out-Host # mostra la taula just aqui, abans del missatge final de la consola

Write-Host "Nombre total de processos: $totalProcessos"