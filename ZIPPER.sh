#!/bin/sh

WORKDIR="/home/admin/devops-stack"
ZIPFILE="/home/admin/devops-stack-clean.zip"

cd "$WORKDIR" || { echo "Erreur : répertoire $WORKDIR introuvable"; exit 1; }

[ -f "$ZIPFILE" ] && rm -f "$ZIPFILE"

echo "Création de $ZIPFILE en cours (exclusions appliquées)..."

sudo zip -r "$ZIPFILE" . \
    -x 'jenkins/jenkins_home/*' \
       'jenkins/data/*' \
       'minecraft/*' \
       'employee-api/target/*' \
       > /dev/null

if [ $? -eq 0 ]; then
    SIZE=$(du -h "$ZIPFILE" | cut -f1)
    echo "Zip créé avec succès : $ZIPFILE ($SIZE)"
    echo "Contenu sensible correctement exclu."
else
    echo "Erreur lors de la création du zip"
    exit 1
fi
