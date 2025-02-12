#!/bin/bash

# Espera até que o PostgreSQL esteja pronto
echo "Aguardando o PostgreSQL iniciar..."
until pg_isready -h sidabi -U postgres; do
  echo "Esperando PostgreSQL..."
  sleep 2
done

# Restauração do banco de dados
echo "Restaurando o backup do banco de dados..."
pg_restore -h sidabi -U postgres -d postgres /var/backups/carga-inicial.backup

# Iniciar o Apache depois de restaurar o banco de dados
echo "Iniciando Apache..."
exec apache2-foreground
