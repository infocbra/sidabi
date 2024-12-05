FROM php:7.4-apache

WORKDIR /var/www/

RUN apt-get clean && apt-get update && apt-get install -y \
    apt-utils \
    libpq-dev \
    postgresql-client \
    dos2unix \
    && docker-php-ext-install pdo pdo_pgsql pgsql \
    && a2enmod rewrite

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

COPY dist .
RUN chown -R www-data:www-data /var/www

COPY start-apache /usr/local/bin/start-apache

RUN dos2unix /usr/local/bin/start-apache

RUN apt-get update && \
    apt-get install -y libpng-dev libpq-dev && \
    docker-php-ext-install pdo pdo_pgsql && \
    apt-get install -y --no-install-recommends git

RUN useradd -s /bin/bash -m vscode && \
    groupadd docker && \
    usermod -aG docker vscode

RUN a2enmod rewrite

COPY --from=gloursdocker/docker / /

EXPOSE 80

RUN chmod +x /usr/local/bin/start-apache

CMD ["start-apache"]

