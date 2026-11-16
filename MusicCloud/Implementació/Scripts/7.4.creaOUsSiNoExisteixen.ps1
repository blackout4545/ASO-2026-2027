$domini = "DC=musiccloud,DC=local"
$rutaMusicCloud = "OU=MusicCloud,$domini"
$nomsOUs = "Usuaris", "Equips", "Grups"

$musicCloud = Get-ADOrganizationalUnit -Filter "Name -eq 'MusicCloud'"

if ($musicCloud -eq $null) {
    New-ADOrganizationalUnit -Name "MusicCloud" -Path $domini
    Write-Host "Creada: MusicCloud"
}
else {
    Write-Host "Ja existeix: MusicCloud"
}

foreach ($nomOU in $nomsOUs) {
    $ou = Get-ADOrganizationalUnit -Filter "Name -eq '$nomOU'"

    if ($ou -eq $null) {
        New-ADOrganizationalUnit -Name $nomOU -Path $rutaMusicCloud
        Write-Host "Creada: $nomOU"
    }
    else {
        Write-Host "Ja existeix: $nomOU"
    }
}