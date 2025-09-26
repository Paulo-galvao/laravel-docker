# Etapa 1: PHP + dependências
FROM php:8.2-fpm

# Instalar extensões necessárias
RUN apt-get update && apt-get install -y \
    git unzip libpq-dev libzip-dev libonig-dev libxml2-dev nginx \
    && docker-php-ext-install pdo pdo_mysql zip mbstring exif pcntl bcmath opcache

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Definir pasta de trabalho
WORKDIR /var/www

# Copiar o projeto Laravel
COPY . .

# Instalar dependências do Laravel
RUN composer install --no-dev --optimize-autoloader

# Permissões
RUN chown -R www-data:www-data storage bootstrap/cache

# Copiar configuração do Nginx
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Expor porta 80 (HTTP)
EXPOSE 80

# Iniciar PHP-FPM em primeiro plano e Nginx em foreground
CMD php-fpm -F & nginx -g "daemon off;"
