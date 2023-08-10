# pip install paramiko

import paramiko

# Définir les informations de connexion
hostname = "adresse_IP_ou_nom_de_domaine"
username = "votre_nom_d_utilisateur"
password = "votre_mot_de_passe_actuel"
new_password = "nouveau_mot_de_passe"
target_user = "utilisateur_a_modifier"

# Établir une connexion SSH
client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(hostname, username=username, password=password)

# Construire la commande pour modifier le mot de passe (pour Ubuntu)
change_password_command = f"echo -e '{new_password}\\n{new_password}' | sudo passwd {target_user}"

# Exécuter la commande sur le serveur
stdin, stdout, stderr = client.exec_command(change_password_command)

# Afficher les résultats de la commande
print(stdout.read().decode("utf-8"))
print(stderr.read().decode("utf-8"))

# Fermer la connexion SSH
client.close()
