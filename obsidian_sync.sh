#!/bin/bash

# Setze das Obsidian Vault-Verzeichnis (angepasst auf NOTES_PATH=Privat)
VAULT_DIR="/var/www/perlite/Privat"

# Name der Perlite-Container
PERLITE_CONTAINER="perlite"
PERLITE_WEB_CONTAINER="perlite_web"

# Überwache Änderungen im Vault
echo "Überwache Änderungen in $VAULT_DIR ..."

sync_notes() {
    echo "Änderungen erkannt, synchronisiere mit Git..."

    # Git-Änderungen committen und pushen
    cd "$VAULT_DIR" || exit
    git add .
    git commit -m "Automatische Synchronisation durch Obsidian Sync Script"
    git push origin main

    # Perlite-Container neustarten
    echo "Neustarten von Perlite-Services..."
    docker-compose restart "$PERLITE_CONTAINER"
    docker-compose restart "$PERLITE_WEB_CONTAINER"
}

# Warte auf Dateiänderungen und reagiere darauf
inotifywait -m -r -e modify,create,delete,move "$VAULT_DIR" | while read -r event; do
    sync_notes
done
