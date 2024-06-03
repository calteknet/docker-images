# hadolint global ignore=DL3018
FROM php:fpm-alpine3.20

ARG LATEST_VERSION
ARG LATEST_REVISION
ARG USER=ctn
ARG GROUP=ctn

LABEL org.opencontainers.image.title="Elgg"
LABEL org.opencontainers.image.description="Elgg is a highly customizable web framework and CMS for building social apps and networks. This image provides a lightweight, efficient environment for running Elgg with PHP-FPM and necessary extensions pre-configured."
LABEL org.opencontainers.image.authors="Kenneth Wyrick, Josh Santos"
LABEL org.opencontainers.image.vendor="CalTekNet"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.url="https://caltek.net"
LABEL org.opencontainers.image.source="https://github.com/CalTekNet/docker-images/tree/main/elgg"
LABEL org.opencontainers.image.version="$LATEST_VERSION"
LABEL org.opencontainers.image.revision="$LATEST_REVISION"

# Set the shell to /bin/ash and enable pipefail
SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# Create a non-root user and group and install deps
RUN addgroup -S "$USER" && \
    adduser -S "$USER" -G "$GROUP" && \
    set -xe && \
    apk update && \
    apk --no-cache add freetype-dev libjpeg-turbo-dev libpng-dev icu-dev \
        git unzip && \
    docker-php-ext-configure gd \
      --with-freetype \
      --with-jpeg && \
    docker-php-ext-install -j"$(nproc)" gd pdo_mysql intl && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy PHP-FPM configuration
COPY php-fpm.conf /usr/local/etc/php-fpm.d/www.conf

# Clone Elgg source code
RUN mkdir /elgg && \
    git clone https://github.com/Elgg/Elgg.git /elgg && \
    chown -R "$USER:$GROUP" /elgg && \
    find /elgg -type f -name "*.php" -exec chmod +x {} \;

# Copy entrypoint script and application files
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Set permissions for the entrypoint script and create logging dir
RUN chmod +x /usr/local/bin/entrypoint.sh && \
    mkdir -p /var/log && touch /var/log/php-fpm.log && \
    chown -R "$USER:$GROUP" /var/log

# Switch to the non-root user
USER "$USER"

# Set the working directory
WORKDIR /elgg

# Install dependencies
RUN composer install

EXPOSE 9000

# Set the entrypoint and command
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["php-fpm"]
