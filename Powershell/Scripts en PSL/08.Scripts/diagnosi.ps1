# =====================
# PROCESSOS
# =====================
# Els 5 processos amb mes CPU
$processos = Get-Process
$topProcessos = $processos | Sort-Object CPU -Descending | Select-Object -First 5 Name, Id, CPU

Write-Host "===== PROCESSOS ====="
foreach ($proces in $topProcessos) {
    Write-Host "Name: $($proces.Name)"
    Write-Host "Id: $($proces.Id)"
    Write-Host "CPU: $($proces.CPU)"
    Write-Host "---------------"
}
Write-Host ""

# =====================
# SERVEIS
# =====================
$serveis = Get-Service
$serveisEnExecucio = ($serveis | Where-Object { $_.Status -eq 'Running' }).Count
$serveisNoExecutats = ($serveis | Where-Object { $_.Status -ne 'Running' }).Count

Write-Host "===== SERVEIS ====="
Write-Host "Total de serveis: $($serveis.Count)"
Write-Host "Serveis en execucio: $serveisEnExecucio"
Write-Host "Serveis no executats: $serveisNoExecutats"
Write-Host ""

# =====================
# FITXERS
# =====================
# Nomes fitxers (les carpetes no tenen mida)
$fitxers = Get-ChildItem | Where-Object { -not $_.PSIsContainer }
$fitxersGrans = $fitxers | Sort-Object Length -Descending | Select-Object -First 3 Name, Length

Write-Host "===== FITXERS ====="
foreach ($fitxer in $fitxersGrans) {
    Write-Host "Name: $($fitxer.Name)"  
    Write-Host "Length: $($fitxer.Length)"
    Write-Host "-------------------------"
}
Write-Host ""

# =====================
# RESUM
# =====================
Write-Host "===== RESUM ====="
Write-Host ""
Write-Host "Processos analitzats: $($processos.Count)"
Write-Host "Serveis analitzats: $($serveis.Count)"
Write-Host "Fitxers analitzats: $($fitxers.Count)"
