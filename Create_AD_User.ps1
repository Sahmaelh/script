# Assurez-vous d'avoir installé le module Active Directory PowerShell (nécessite les droits d'administrateur)
# Installation du module à partir des fonctionnalités RSAT (Remote Server Administration Tools) pour Windows
Add-WindowsFeature RSAT-AD-PowerShell

# Importation du module Active Directory PowerShell
Import-Module ActiveDirectory

# Remplacez les valeurs suivantes par les informations appropriées

$NomUtilisateur = "Nouvel Utilisateur" # Nom complet du nouvel utilisateur
$AliasUtilisateur = "NouvelUtilisateur" # Alias du nouvel utilisateur (nom d'utilisateur)
$MotDePasse = ConvertTo-SecureString "MotDePasseSecure123!" -AsPlainText -Force # Mot de passe du nouvel utilisateur
$OU = "OU=Utilisateurs,DC=mondomaine,DC=com" # Distinguished Name de l'unité organisationnelle où vous souhaitez créer l'utilisateur

# Création du nouvel utilisateur
New-ADUser -Name $NomUtilisateur -SamAccountName $AliasUtilisateur -UserPrincipalName "$AliasUtilisateur@mondomaine.com" -GivenName "Prénom" -Surname "Nom" -AccountPassword $MotDePasse -Enabled $true -Path $OU

Write-Host "Nouvel utilisateur $NomUtilisateur ($AliasUtilisateur) créé avec succès dans Active Directory."