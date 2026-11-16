$domini = "DC=musiccloud,DC=local"
$ouPrincipal = "OU=MusicCloud,$domini"

New-ADOrganizationalUnit -Name "MusicCloud" -Path $domini
Write-Host "Creada: MusicCloud"

foreach ($nom in "Usuaris", "Equips", "Grups") {
    New-ADOrganizationalUnit -Name $nom -Path $ouPrincipal
    Write-Host "Creada: $nom"
}
