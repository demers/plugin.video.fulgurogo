#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

if [ $# -eq 0 ]
then
    echo "usage: 4 paramètres: (1) icon (image) (2) fanart (image)"
    echo "(3) Titre de la chaîne Youtube (4) mot d'accès Youtube du type"
    echo "https://www.youtube.com/user/<ACCES>"
	exit 0
fi

echo "Voici les paramètres entrés:"
echo "  icon = $1"
echo "  fanart = $2"
echo "  titre = $3"
echo "  user = $4"
read -n1 -r -p "Est-ce correct? Tapez o pour oui." key
if [ "$key" != "o" ]
then
    echo "Arrêt."
    echo 1
fi

git clone https://github.com/demers/plugin.video.fulgurogo.git

nom=$4
rep="plugin.video.${nom,,}"
mv -f plugin.video.fulgurogo $rep
mkdir -v $rep

cp -f "$1" "$rep"
cp -f "$2" "$rep"
rm -f "$rep/icon.jpg"
rm -f "$rep/fanart.png"
rm -f "$rep/README.md"
rm -f "$rep/create_new_plugin.bash"

printf "$RED Remplacement du icon par $1 $NC \n"
sed -i -e 's/icon.jpg/$1/g' "$rep/addon.xml"

printf "$RED Remplacement du fanart par $2 $NC \n"
sed -i -e 's/fanart.png/$2/g' "$rep/addon.xml"

printf "$RED Remplacement du titre par $3 $NC \n"
sed -i -e 's/Fulguro Go/$3/g' "$rep/addon.xml"
sed -i -e 's/Fulguro Go/$3/g' "$rep/default.py"

printf "$RED Remplacement du mot d'accès (FulguroGo) par $4 $NC \n"
sed -i -e 's/FulguroGo/$4/g' "$rep/addon.xml"

zip "$nom" "$nom/*"

rm -f -r "$nom"


