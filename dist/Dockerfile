# Use the official PHP Apache base image

FROM php:8.0-apache

# Atualizar repositórios e instalar dependências essenciais
RUN apt-get clean && apt-get update && apt-get install -y \
    apt-utils \
    libpq-dev \
    postgresql-client \
    && docker-php-ext-install pdo pdo_pgsql pgsql \
    && a2enmod rewrite

# Copiar o código da aplicação para o diretório correto

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
#RUN chown -R www-data:www-data /var/www
COPY start-apache /usr/local/bin

# Habilita o módulo rewrite do Apache
RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www/

# Copy the project files to the container
COPY . /var/www/

# Install any necessary dependencies
    # Add your dependencies here, if needed

# Expose port 80 for Apache
EXPOSE 80

# Start the Apache server
CMD ["start-apache"]