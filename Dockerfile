# Etapa 1: PHP + dependências
FROM php:8.2-fpm

# Instalar extensões do PHP necessárias pro Laravel
RUN apt-get update && apt-get install -y \
    git unzip libpq-dev libzip-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql zip mbstring exif pcntl bcmath opcache

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Definir pasta de trabalho
WORKDIR /var/www

# Copiar os arquivos do projeto
COPY . .

# Instalar dependências do Laravel
RUN composer install --no-dev --optimize-autoloader

# Dar permissão pras pastas
RUN chown -R www-data:www-data storage bootstrap/cache

# Expor a porta que o PHP-FPM vai rodar
EXPOSE 9000

CMD ["php-fpm"]
