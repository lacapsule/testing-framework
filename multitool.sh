#!/bin/bash

rc=1
 
while [ $rc -eq 1 ]; do
  ans=$(zenity --info --width=250 --title 'Maintenance' \
      --text "<span font-family=\"Verdana\">Cliquez pour effectuer les actions</span>" \
      --ok-label QUITTER \
      --extra-button MAINTENANCE \
      --extra-button TESTS \
      --extra-button INFORMATIONS \
      --extra-button NETTOYER \
      --extra-button WIPENVME \
      --extra-button SHREDHDD \
       )
  rc=$?
  echo "${rc}-${ans}"
  echo $ans
  if [[ $ans = "MAINTENANCE" ]]
  then
        echo "Effectuer la maintenance"
        gnome-terminal --title="Maintenance" --working-directory=Maintenance -- "MULTITOOL/Maintenance/./logiciel.sh";
  fi
  if [[ $ans = "TESTS" ]]
  then
	echo "Effectuer les tests"
        gnome-terminal --title="Test" --working-directory=Maintenance --working-directory=Test -- "MULTITOOL/Test/./ruff.sh";
  fi
  if [[ $ans = "INFORMATIONS" ]]
  then
        echo "Vérifier les informations"
        gnome-terminal --geometry=90x70+0+0 --title="Informations" --working-directory=Gathering -- "MULTITOOL/Gathering/./gathering.sh";
  fi
  if [[ $ans = "NETTOYER" ]]
  then
        echo "Vider la mémoire RAM"
        PASSWD="$(zenity --password --title=Authentication)\n"
        echo -e $PASSWD | "sudo -S sync sysctl vm.drop_caches=3";
        echo "Nettoyer les fichiers inutiles"
        (
        PASSWD="$(zenity --password --title=Authentication)\n"
        echo -e $PASSWD | "sudo -S apt autoclean -y" ; sleep 1 
        echo "10" ; sleep 20
        echo "20" ; sleep 10
        echo "30" ; sleep 20
        echo "40" ; sleep 10
        echo "50" ; sleep 40 
        echo -e $PASSWD | "sudo -S apt autoremove -y" ; sleep 1 
        echo "60" ; sleep 20
        echo "70" ; sleep 20
        echo "80" ; sleep 20
        echo "90" ; sleep 30 
        echo "100" ; sleep 1 
        ) | zenity --progress \
        --title="Nettoyage des fichiers" \
        --text="Nettoyage en cours" \
        --percentage=0 
  fi 
  if [[ $ans = "WIPENVME" ]]
  then
 echo "Détruire les données d'un disque dur"
        gnome-terminal --title="WIPENVME" --working-directory=Shred -- "MULTITOOL/Shred/./SHREDSSD.sh";
  fi 
  if [[ $ans = "SHREDHDD" ]]
  then
 	echo "Détruire les données d'un disque dur"
        gnome-terminal --title="SHREDHDD" --working-directory=Shred -- "MULTITOOL/Shred/./SHREDHDD.sh";
 fi 
done
