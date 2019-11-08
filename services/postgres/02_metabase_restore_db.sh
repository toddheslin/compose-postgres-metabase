#!/bin/bash
set -e # exit immediately if a command exits with a non-zero status.

BACKUP_FILE="/docker-entrypoint-initdb.d/backup.sql"
BACKUP_TYPE="sql"

# check if backup file exists
if [[ -e $BACKUP_FILE ]]; then
    echo "Found a backup of type $BACKUP_TYPE, restoring database"
    if [[ $BACKUP_TYPE == "sql" ]]; then
        echo "Restoring via psql"
        psql --username=postgres -c --if-exists --dbname=metabase -f $BACKUP_FILE > /dev/null
    else
        echo "Restoring via pg_restore"
        pg_restore --username=postgres -c --if-exists --dbname=metabase $BACKUP_FILE > /dev/null
    fi
else
    echo "No Backup found"
fi
