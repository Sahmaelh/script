# Installation du module Exchange Online PowerShell (nécessite les droits d'administrateur)
if (-Not (Get-Module -Name ExchangeOnlineManagement -ErrorAction SilentlyContinue)) {
    Install-Module -Name ExchangeOnlineManagement -Force -AllowClobber
}

# Importation du module Exchange Online PowerShell
Import-Module ExchangeOnlineManagement

# Assurez-vous d'avoir installé le module Exchange Online PowerShell
# Connectez-vous à Exchange Online
Connect-ExchangeOnline -UserPrincipalName "votre_compte_administrateur@votre_domaine.onmicrosoft.com"

# Remplacez les valeurs suivantes par les informations appropriées
$NomUtilisateur = "Nom de l'utilisateur" # Nom de l'utilisateur auquel ajouter la boîte aux lettres
$AliasUtilisateur = "Alias de l'utilisateur" # Alias de l'utilisateur (peut être identique au nom)
$NomBoiteAuxLettres = "Nom de la boîte aux lettres" # Nom de la nouvelle boîte aux lettres

# Recherche de l'utilisateur dans Exchange Online
$Utilisateur = Get-User -Filter { Get-Alias -eq $AliasUtilisateur }

if ($Utilisateur) {
    # Création de la boîte aux lettres
    Enable-Mailbox -Identity $Utilisateur.Identity -Alias $AliasUtilisateur -DisplayName $NomBoiteAuxLettres -PrimarySmtpAddress "$AliasUtilisateur@votre_domaine.onmicrosoft.com"
    Write-Host "Boîte aux lettres ajoutée avec succès pour l'utilisateur $NomUtilisateur ($AliasUtilisateur)."
} else {
    Write-Host "Utilisateur $AliasUtilisateur introuvable dans Exchange Online."
}

# Déconnectez-vous de Exchange Online
Disconnect-ExchangeOnline