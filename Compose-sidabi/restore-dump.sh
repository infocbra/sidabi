#!/bin/bash


echo "Procurando pelo container Docker..."
CONTAINER_ID=$(docker ps --format='{{.ID}}' --filter name=^sidabi_database$)
if [[ -z "$CONTAINER_ID" ]]; then
    echo "Nenhum container encontrado com o nome 'sidabi_database'"
    exit 1
else
    echo "Container encontrado: $CONTAINER_ID"
fi

echo "Iniciando a restauração do banco de dados..."
docker exec -it $CONTAINER_ID bash -c 'pg_restore -c -U ${POSTGRES_USER} -d ${POSTGRES_DB} /var/backups/carga-inicial.backup'
if [[ $? -eq 0 ]]; then
    echo "Restauração do banco de dados concluída com sucesso."
else
    echo "Erro ao restaurar o banco de dados."
    exit 1
fi
