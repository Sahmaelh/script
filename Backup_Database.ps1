# Définir les informations de connexion
$serverInstance = "ServerInstanceName"
$databaseName = "DatabaseName"
$backupPath = "C:\Backup"  # Chemin local où la sauvegarde sera enregistrée
$backupFileName = "$databaseName" + "_" + (Get-Date -Format "yyyyMMdd_HHmmss") + ".bak"

# Construire la commande SQL pour la sauvegarde
$backupCommand = "BACKUP DATABASE [$databaseName] TO DISK = '$backupPath\$backupFileName' WITH INIT"

# Définir les informations d'authentification
$credential = Get-Credential

# Exécuter la commande SQL pour la sauvegarde
Invoke-Sqlcmd -ServerInstance $serverInstance -Database master -Query $backupCommand -Credential $credential
