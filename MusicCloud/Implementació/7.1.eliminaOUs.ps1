$domini = "DC=musiccloud,DC=local"
$ouPrincipal = "OU=MusicCloud,$domini"

try {
    $OU = Get-ADOrganizationalUnit -Identity $ouPrincipal -ErrorAction Stop
}
catch {
    $OU = $null
}

if ($OU) {
    # Pas 1: Treure la proteccio de MusicCloud i de tot el que conte
    Get-ADOrganizationalUnit -Filter * -SearchBase $ouPrincipal | Set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion $false

    # Pas 2: Eliminar MusicCloud amb tot el que conte
    Remove-ADOrganizationalUnit -Identity $ouPrincipal -Recursive
    Write-Host "Eliminat: MusicCloud"
    
} else {
    Write-Host "No existeix MusicCloud"
}