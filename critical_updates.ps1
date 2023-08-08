# Configuration du serveur WSUS
$WSUSServer = "your_wsus_server"
$WSUSPort = "8530" # Port par défaut de WSUS
$WSUSScope = "All Computers" # Remplacez par le groupe de systèmes sur lequel vous souhaitez déployer les correctifs

# Connexion au serveur WSUS
$WSUSConnectionOptions = New-Object Microsoft.UpdateServices.Administration.AdminProxyConnectionOptions
$WSUSConnectionOptions.BypassProxyServerForLocal = $true
$WSUSConnectionOptions.ProxyScheme = [Microsoft.UpdateServices.Administration.ProxyScheme]::None
$WSUSConnectionOptions.ServerName = $WSUSServer
$WSUSConnectionOptions.PortNumber = $WSUSPort
$WSUSAdminProxy = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer($WSUSConnectionOptions)

# Recherche des mises à jour disponibles
$Searcher = $WSUSAdminProxy.GetUpdateSearcher()
$Criteria = "IsInstalled=0 and IsHidden=0 and Type='Software' and IsDownloaded=0 and IsPresent=0"
$SearchResult = $Searcher.Search($Criteria)

# Sélection des mises à jour critiques uniquement
$CriticalUpdates = $SearchResult.Updates | Where-Object { $_.Categories -match "Critical Updates" }

# Affichage des mises à jour trouvées
$CriticalUpdates | ForEach-Object {
    Write-Host "Mise à jour critique trouvée : $($_.Title)"
}

# Déploiement des mises à jour critiques sur le groupe spécifié
$UpdateSession = New-Object -ComObject Microsoft.Update.Session
$UpdateDownloader = $UpdateSession.CreateUpdateDownloader()
$UpdateDownloader.Updates = $CriticalUpdates
$UpdateDownloader.Download()

$UpdateInstaller = $UpdateSession.CreateUpdateInstaller()
$UpdateInstaller.Updates = $CriticalUpdates

# Filtrez les mises à jour pour le groupe spécifié (WSUSScope)
$UpdateScope = $UpdateInstaller.Updates | Where-Object { $_.Categories -match $WSUSScope }

if ($UpdateScope.Count -gt 0) {
    $InstallationResult = $UpdateInstaller.Install()
    
    # Vérification du succès de l'installation
    if ($InstallationResult.ResultCode -eq "2") {
        Write-Host "Mises à jour critiques installées avec succès sur le groupe $WSUSScope."
    } else {
        Write-Host "Erreur lors de l'installation des mises à jour sur le groupe $WSUSScope : $($InstallationResult.ResultCode)"
    }
} else {
    Write-Host "Aucune mise à jour critique trouvée pour le groupe $WSUSScope."
}
