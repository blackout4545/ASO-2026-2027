$nomEquip = $env:COMPUTERNAME
$usuariActual = $env:USERNAME
$versioPowerShell = $PSVersionTable.PSVersion
$dataHora = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
$directoriActual = (Get-Location).Path

Write-Host "===== INFORMACIO DEL SISTEMA ====="
Write-Host ""
Write-Host "Equip: $nomEquip"
Write-Host "Usuari: $usuariActual"
Write-Host "PowerShell: $versioPowerShell"
Write-Host "Data: $dataHora"
Write-Host "Directori actual: $directoriActual"
