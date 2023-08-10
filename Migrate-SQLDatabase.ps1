# Définir les informations de connexion aux serveurs SQL
$sourceServer = "SourceServerName"
$sourceDatabase = "SourceDatabaseName"
$sourceCredential = Get-Credential -UserName "SourceUsername" -Message "Entrez le mot de passe pour le serveur source"

$targetServer = "TargetServerName"
$targetDatabase = "TargetDatabaseName"
$targetCredential = Get-Credential -UserName "TargetUsername" -Message "Entrez le mot de passe pour le serveur cible"

# Chemin de sauvegarde local pour le fichier de sauvegarde
$backupFilePath = "C:\Backup\backup.bak"

# Chemin de sauvegarde sur le serveur cible
$targetBackupPath = "\\TargetServer\BackupShare\backup.bak"

# Effectuer la sauvegarde de la base de données sur le serveur source
Backup-SqlDatabase -ServerInstance $sourceServer -Database $sourceDatabase -BackupFile $backupFilePath -Credential $sourceCredential

# Copier le fichier de sauvegarde vers le serveur cible
Copy-Item -Path $backupFilePath -Destination $targetBackupPath -ToSession (New-PSSession -ComputerName $targetServer -Credential $targetCredential)

# Restaurer la base de données sur le serveur cible
Restore-SqlDatabase -ServerInstance $targetServer -Database $targetDatabase -BackupFile $targetBackupPath -Credential $targetCredential -ReplaceDatabase
