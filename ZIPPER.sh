#!/bin/sh
# Script pour créer un devops-stack.zip propre – fonctionne à tous les coups

WORKDIR="/home/admin/devops-stack"
ZIPFILE="/home/admin/devops-stack-clean.zip"   # zip créé à l'extérieur → jamais inclus par erreur

# Vérifie qu’on est dans le bon dossier
cd "$WORKDIR" || { echo "Erreur : répertoire $WORKDIR introuvable"; exit 1; }

# Supprime l’ancien zip s’il existe
[ -f "$ZIPFILE" ] && rm -f "$ZIPFILE"

echo "Création de $ZIPFILE en cours (exclusions appliquées)..."

# LA LIGNE QUI MARCHE VRAIMENT (tout est dans l’ordre et les motifs sont corrects)
sudo zip -r "$ZIPFILE" . \
    -x 'jenkins/jenkins_home/*' \
       'jenkins/data/*' \
       'minecraft/*' \
       'employee-api/target/*' \
       > /dev/null

# Message de succès + taille finale
if [ $? -eq 0 ]; then
    SIZE=$(du -h "$ZIPFILE" | cut -f1)
    echo "Zip créé avec succès : $ZIPFILE ($SIZE)"
    echo "Contenu sensible correctement exclu."
else
    echo "Erreur lors de la création du zip"
    exit 1
fi
