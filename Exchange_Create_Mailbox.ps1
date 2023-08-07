# Remplacez les valeurs suivantes par les informations appropriées

$NomUtilisateur = "Nom de l'utilisateur" # Nom de l'utilisateur auquel ajouter la boîte aux lettres
$AliasUtilisateur = "Alias de l'utilisateur" # Alias de l'utilisateur (peut être identique au nom)
$NomBoiteAuxLettres = "Nom de la boîte aux lettres" # Nom de la nouvelle boîte aux lettres
$BaseDN = "DC=mondomaine,DC=com" # Distinguished Name de votre domaine Active Directory
$ConnectionUri = "http://serveurexchange/PowerShell/"

# Connexion à Microsoft Exchange

if (!(Get-PSSession | Where-Object { $_.ConfigurationName -eq "Microsoft.Exchange" })) {
    $Credential = Get-Credential
    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $ConnectionUri -Authentication Kerberos -Credential $Credential
    Import-PSSession $Session -AllowClobber
}

# Recherche de l'utilisateur dans Active Directory

$Utilisateur = Get-ADUser -Filter { SamAccountName -eq $AliasUtilisateur } -SearchBase $BaseDN

if ($Utilisateur) {
    # Création de la boîte aux lettres
    New-Mailbox -Name $NomBoiteAuxLettres -Alias $AliasUtilisateur -UserPrincipalName "$AliasUtilisateur@mondomaine.com" -PrimarySmtpAddress "$AliasUtilisateur@mondomaine.com" -Database "NomBaseDeDonnees" -OrganizationalUnit $Utilisateur.DistinguishedName
    Write-Host "Boîte aux lettres ajoutée avec succès pour l'utilisateur $NomUtilisateur ($AliasUtilisateur)."
} else {
    Write-Host "Utilisateur $AliasUtilisateur introuvable dans Active Directory."
}

# Fermeture de la session Exchange
if ($Session) {
    Remove-PSSession $Session
}