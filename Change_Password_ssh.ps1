# Install-Package -Name SSH.Net -Source nuget.org

# Charger le module SSH.Net
Import-Module SSH.Net

# Définir les informations de connexion
$hostname = "adresse_IP_ou_nom_de_domaine"
$username = "votre_nom_d_utilisateur"
$password = "votre_mot_de_passe_actuel"
$newPassword = "nouveau_mot_de_passe"
$targetUser = "utilisateur_a_modifier"

# Créer une session SSH
$session = New-SshSession -ComputerName $hostname -Credential (Get-Credential -UserName $username -Password $password)

# Construire la commande pour modifier le mot de passe (pour Ubuntu)
$changePasswordCommand = "echo -e '$newPassword\n$newPassword' | sudo passwd $targetUser"

# Exécuter la commande sur le serveur
Invoke-SshCommand -SessionId $session.SessionId -Command $changePasswordCommand

# Fermer la session SSH
Remove-SshSession -SessionId $session.SessionId
