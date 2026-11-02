# =====================
# PROCESSOS
# =====================
$processos = Get-Process

Write-Host "===== PROCESSOS ====="
Write-Host "Els cinc processos amb mes CPU:"
$processos |
    Sort-Object CPU -Descending |
    Select-Object -First 5 Name, Id, CPU |
    Format-Table -AutoSize |
    Out-Host


# =====================
# SERVEIS
# =====================
$serveis = Get-Service
$totalServeis = $serveis.Count
$serveisEnExecucio = ($serveis | Where-Object { $_.Status -eq 'Running' }).Count
$serveisNoExecutats = $totalServeis - $serveisEnExecucio

Write-Host "===== SERVEIS ====="
Write-Host "Total de serveis: $totalServeis"
Write-Host "Serveis en execucio: $serveisEnExecucio"
Write-Host "Serveis no executats: $serveisNoExecutats"
Write-Host ""


# =====================
# FITXERS
# =====================
$fitxers = Get-ChildItem -File

Write-Host "===== FITXERS ====="
Write-Host "Els tres fitxers mes grans de la carpeta actual:"
$fitxers |
    Sort-Object Length -Descending |
    Select-Object -First 3 Name, Length |
    Format-Table -AutoSize |
    Out-Host


# =====================
# RESUM
# =====================
Write-Host "===== RESUM ====="
Write-Host ""
Write-Host "Processos analitzats: $($processos.Count)"
Write-Host "Serveis analitzats: $totalServeis"
Write-Host "Fitxers analitzats: $($fitxers.Count)"
