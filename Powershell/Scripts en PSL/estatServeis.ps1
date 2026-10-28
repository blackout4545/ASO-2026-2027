# Estat dels serveis del sistema
$serveis = Get-Service
$totalServeis = $serveis.Count
$serveisEnExecucio = ($serveis | Where-Object { $_.Status -eq 'Running' }).Count
$serveisNoEnExecucio = ($serveis | Where-Object { $_.Status -ne 'Running' }).Count

# Els resultats es mostren al final
Write-Host "===== ESTAT DELS SERVEIS ====="
Write-Host ""
Write-Host "Total: $totalServeis"
Write-Host "Running: $serveisEnExecucio"
Write-Host "Not running: $serveisNoEnExecucio"