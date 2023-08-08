# pip install pywin32


import wmi

def is_sep_up_to_date():
    try:
        # Se connecter à l'API WMI de Windows
        wmi_conn = wmi.WMI()

        # Requête WMI pour obtenir l'état de Symantec Endpoint Protection
        query = "SELECT * FROM AntiVirusProduct WHERE displayName LIKE '%Symantec Endpoint Protection%'"
        result = wmi_conn.query(query)

        if len(result) == 0:
            print("Symantec Endpoint Protection n'est pas installé.")
            return False

        # Vérifier si SEP est à jour
        for product in result:
            if product.productState == 393472 or product.productState == 397584:
                print("Symantec Endpoint Protection est à jour.")
                return True
            else:
                print("Symantec Endpoint Protection n'est pas à jour.")
                return False

    except wmi.x_wmi as ex:
        print("Erreur lors de la requête WMI :", ex)
        return False

if __name__ == "__main__":
    is_sep_up_to_date()
