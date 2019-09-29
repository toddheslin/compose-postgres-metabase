#!/bin/bash
set -e # exit immediately if a command exits with a non-zero status.

BACKUP_FILE="/docker-entrypoint-initdb.d/backup.bak"

# check if backup file exists
if [[ -e $BACKUP_FILE ]]; then
    echo "Restoring backup to database"
    pg_restore --username=postgres -c --if-exists --dbname=metabase $BACKUP_FILE > /dev/null
else
    echo "No Backup found"
fi
