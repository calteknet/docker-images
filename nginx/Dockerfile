FROM nginx:alpine

ARG LATEST_VERSION
ARG LATEST_REVISION
ARG USER=ctn
ARG GROUP=ctn

LABEL org.opencontainers.image.title="Nginx Server with PHP-FPM Backend"
LABEL org.opencontainers.image.description="A generic Nginx server configured to work with a PHP-FPM backend."
LABEL org.opencontainers.image.authors="Kenneth Wyrick, Josh Santos"
LABEL org.opencontainers.image.vendor="CalTekNet"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.url="https://caltek.net"
LABEL org.opencontainers.image.source="https://github.com/CalTekNet/docker-images/tree/main/nginx"
LABEL org.opencontainers.image.version="$LATEST_VERSION"
LABEL org.opencontainers.image.revision="$LATEST_REVISION"

# Create a non-root user and group
RUN addgroup -g 1000 "$GROUP" && \
    adduser -D -u 1000 -G "$GROUP" "$USER" && \
    apk update && \
    apk --no-cache add ngrep

# Create necessary directories
RUN mkdir -p "/home/$USER/nginx_run" && \
    mkdir -p /var/cache/nginx/client_temp && \
    chown -R "$USER:$GROUP" /var/cache/nginx "/home/$USER/nginx_run"

# Copy custom Nginx configuration files
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 for Nginx
EXPOSE 8000

# Switch to non-root user
USER "$USER"

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
