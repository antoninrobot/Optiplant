import cv2
import time
import os
from datetime import datetime
from ftplib import FTP_TLS

# Configuration flux video camera RSTP
TAPO_USER = "votre_utilisateur_camera"  
TAPO_PASS = "votre_mot_de_passe"       
TAPO_IP = "192.168.1.100"               
RTSP_URL = f"rtsp://{TAPO_USER}:{TAPO_PASS}@{TAPO_IP}/stream1"

# Configuration Optiplant FTP
FTP_HOST = "185.31.41.72"
FTP_USER = "optiplant_admin"
FTP_PASS = "admin"
REMOTE_DIR = "www/site-light/public/assets/images" 

print("Tentative de connexion au flux RTSP de la caméra...")
cap = cv2.VideoCapture(RTSP_URL)

if not cap.isOpened():
    print("Erreur : Impossible de se connecter à la caméra Tapo. Vérifiez l'IP et les identifiants.")
    exit()

print("Connexion à la caméra réussie. Démarrage de la chaîne d'acquisition...")

try:
    while True:
        ret, frame = cap.read()
        if not ret:
            print("Erreur de lecture du flux. Nouvelle tentative...")
            time.sleep(1)
            continue

        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        
        hauteur, largeur, _ = frame.shape
        milieu_h, milieu_l = hauteur // 2, largeur // 2

        parties = {
            1: frame[0:milieu_h, 0:milieu_l],
            2: frame[0:milieu_h, milieu_l:largeur],
            3: frame[milieu_h:hauteur, 0:milieu_l],
            4: frame[milieu_h:hauteur, milieu_l:largeur]
        }

        try:
            ftp = FTP_TLS(FTP_HOST)
            ftp.login(user=FTP_USER, passwd=FTP_PASS)
            ftp.prot_p() 
            ftp.set_pasv(True)
            
            ftp.cwd(REMOTE_DIR)

            fichiers_presents = ftp.nlst() 
            for f in fichiers_presents:
                if f.endswith(".jpg") or f.endswith(".txt"):
                    try:
                        ftp.delete(f)
                        print(f"Supprimé du serveur : {f}")
                    except:
                        pass

            for numero, morceau in parties.items():
                filename = f"bac{numero}.jpg"
                cv2.imwrite(filename, morceau)

                with open(filename, 'rb') as f:
                    ftp.storbinary(f'STOR {filename}', f)
                
                os.remove(filename)
                print(f"Nouveau fichier : {filename} envoyé.")

            filename = f"{timestamp}.txt"

            with open(filename, 'w') as f:
                f.write(timestamp)

            with open(filename, 'rb') as f:
                ftp.storbinary(f'STOR {filename}', f)
                
            os.remove(filename)
            print(f"Fichier de synchronisation : {filename} envoyé.")

            ftp.quit()

        except Exception as e:
            print(f"Erreur lors du transfert FTP : {e}")

        print("--- Cycle terminé. Prochain envoi dans 10 secondes ---")
        time.sleep(10)

except KeyboardInterrupt:
    print("\nScript arrêté manuellement par l'utilisateur.")
finally:
    cap.release()
    print("Connexion à la caméra fermée proprement.")
