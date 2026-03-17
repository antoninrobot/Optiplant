import cv2
print ( " \n - - - AUTHENTIFICATION TAPO ---" )
user_rtsp = input ( " Utilisateur ( Compte Camera ) : " )
pass_rtsp = input ( " Mot de passe ( Compte Camera ) : " )
rtsp_url = f" rtsp ://{ user_rtsp }:{ pass_rtsp } @192 .168.1.100/ stream1"
cap = cv2 . VideoCapture ( rtsp_url )
if cap . isOpened () :
    ret , frame = cap . read ()
    if ret :
        cv2 . imwrite ( " screenshot_optiplant . jpg " , frame )
        print ( " Capture sauvegardee avec succes ! " )
    else :
        print ( " Impossible de lire l ’ image . " )
    cap . release ()
else :
    print ( " Erreur : Impossible de se connecter a la camera . " )
