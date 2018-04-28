#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

if [ $# -eq 0 ]
then
    echo "usage: 4 paramètres: (1) icon (image) (2) fanart (image)"
    echo "(3) Titre de la chaîne Youtube (4) mot d'accès Youtube du type"
    echo "(5) -channel pour obtenir www.youtube.com/channel/... plutôt que"
    echo "    www.youtube.com/user/..."
    echo "L'URL sera soit: https://www.youtube.com/user/<ACCES>"
    echo "ou https://www.youtube.com/channel/<ACCES>"
	exit 0
fi

nom=$4
rep="plugin.video.${nom,,}"
minuscule="${nom,,}"

type="user"
if [ ! -z "$5" ]
then
    if [ "$5" == "-channel" ]
    then
        type="channel"
    fi
fi

echo "Voici les paramètres entrés:"
echo "  icon = $1"
echo "  fanart = $2"
echo "  titre = $3"
echo "  $type = $4"
echo "  Le nom du plugin sera: $rep"
read -n1 -r -p "Est-ce correct? Tapez o pour oui." key
echo ""
if [ "$key" != "o" ]
then
    echo "Arrêt."
    exit 1
fi

echo "Clone du Github Fulgurogo..."
git clone -q https://github.com/demers/plugin.video.fulgurogo.git "$rep"

rm -f "$rep/icon.jpg"
rm -f "$rep/fanart.png"
cp -f "$1" "$rep"
cp -f "$2" "$rep"
rm -f "$rep/README.md"
rm -f "$rep/create_new_plugin.bash"
rm -f -r "$rep/.git"

printf "$RED Remplacement du icon par $1 $NC \n"
sed -i -e "s/icon.jpg/$1/g" "$rep/addon.xml"

printf "$RED Remplacement du fanart par $2 $NC \n"
sed -i -e "s/fanart.png/$2/g" "$rep/addon.xml"

printf "$RED Remplacement du titre par $3 $NC \n"
sed -i -e "s/Fulguro Go/$3/g" "$rep/addon.xml"
sed -i -e "s/Fulguro Go/$3/g" "$rep/default.py"

printf "$RED Remplacement du mot d'accès (FulguroGo) par $4 $NC \n"
sed -i -e "s/fulgurogo/$minuscule/g" "$rep/addon.xml"
sed -i -e "s/fulgurogo/$minuscule/g" "$rep/default.py"
sed -i -e "s/FulguroGo/$nom/g" "$rep/default.py"

if [ "$type" == "channel" ]
then
    printf "$RED Remplacement du user par channel. $NC \n"
    sed -i -e "s/user/channel/g" "$rep/default.py"
fi

zip -r "${rep}.zip" "$rep"

rm -f -r "$rep"


