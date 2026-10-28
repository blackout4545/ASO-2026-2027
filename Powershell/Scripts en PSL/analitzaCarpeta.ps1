# Analisi de la carpeta des on s'executa el script
$elements = Get-ChildItem
$totalElements = $elements.Count

# "-File" deixa nomes els fitxers (les carpetes no tenen mida)
$fitxersMesGrans = Get-ChildItem -File |
    Sort-Object Length -Descending |
    Select-Object -First 5 Name, Length

Write-Host "===== ANÀLISI DE LA CARPETA ====="
Write-Host ""
Write-Host "Carpeta: $(Get-Location).Path"
Write-Host "Nombre total d'elements: $totalElements"
Write-Host ""
Write-Host "Els cinc fitxers mes grans (mida en bytes):"
$fitxersMesGrans | Format-Table -AutoSize | Out-Host