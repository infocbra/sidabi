#!/bin/bash

source .env

if [[ -z "$POSTGRES_USER" || -z "$POSTGRES_DB" ]]; then
    echo "Required environment variables are not set. Please check your .env file."
    exit 1
fi

CONTAINER_ID=$(docker ps --format='{{.ID}}' --filter name=^sidabi_database$)

if [[ -z "$CONTAINER_ID" ]]; then
    echo "No container found with the name'sidabi_database'"
    exit 1
fi

echo "Container found: $CONTAINER_ID"

echo "Starting database backup..."
docker exec -it $CONTAINER_ID bash -c 'pg_dump -U $POSTGRES_USER -d $POSTGRES_DB -F c -b -v -f /var/backups/backup.dump'

if [[ $? -eq 0 ]]; then
    echo "Database backup completed successfully."
else
    echo "Error occurred during the database backup."
    exit 1
fi
