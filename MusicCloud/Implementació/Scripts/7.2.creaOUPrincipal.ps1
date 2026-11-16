$domini = "DC=musiccloud,DC=local"

New-ADOrganizationalUnit -Name "MusicCloud" -Path $domini
Write-Host "Creada: MusicCloud"