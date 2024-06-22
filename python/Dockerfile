# hadolint global ignore=DL3018
FROM python:alpine

# Additional Metadata
LABEL org.opencontainers.image.title="Python Base Image."
LABEL org.opencontainers.image.description="A lightweight Docker image for running your rootless Python application."
LABEL org.opencontainers.image.authors="Josh Santos <josh@santos.cloud>"

# Set working directory
WORKDIR /app

# Install dependencies with tools usable by non-root user
RUN apk update && \
    apk add \
        python3-dev

# Define environment variables
ENV PYTHONUNBUFFERED=1

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Create the ctn user and group
# TODO: Make user/group/UID/GID configurable if needed.
RUN addgroup --system ctn && adduser --ingroup ctn --system ctn && \
    chown ctn:ctn /usr/local/bin/entrypoint.sh && \
    chmod +x /usr/local/bin/entrypoint.sh

# Set the user for the process
USER ctn

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
