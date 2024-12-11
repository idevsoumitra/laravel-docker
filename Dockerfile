# Base image for PHP
FROM php:8.2-fpm-alpine

# Update and install dependencies
RUN apk update && apk add --no-cache \
    curl \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    libxpm-dev \
    freetype-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    bash \
    mysql-client \
    libxml2-dev \
    nginx # Install Nginx

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd mysqli pdo pdo_mysql zip

# Copy Composer from official image
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set the working directory
WORKDIR /var/www/html

# Copy application files
COPY . .

# Install Laravel dependencies
RUN composer install --optimize-autoloader --no-dev

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 8080 (used by Google Cloud Run)
EXPOSE 8080

# Start Nginx and PHP-FPM
CMD ["sh", "-c", "php-fpm & nginx -g 'daemon off;'"]
