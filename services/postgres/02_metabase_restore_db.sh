#!/bin/bash
set -e # exit immediately if a command exits with a non-zero status.

##
# Note that this script specifically imports postgres binary dumps
# Any .sql or .sql.gz files will be imported automatically by the docker script
# See: https://github.com/docker-library/postgres/blob/master/docker-entrypoint.sh#L164
##

BACKUP_FILE_DUMP="/docker-entrypoint-initdb.d/backup.bak"

# check if backup file exists
if [[ -e $BACKUP_FILE_DUMP ]]; then
    echo "Restoring dump backup to database"
    pg_restore --username=postgres -c --if-exists --dbname=metabase $BACKUP_FILE_DUMP > /dev/null
else
    echo "No backup dump found"
fi
