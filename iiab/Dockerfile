# hadolint global ignore=DL3018
FROM debian

ARG LATEST_VERSION
ARG LATEST_REVISION
ARG USER=ctn
ARG GROUP=ctn

LABEL org.opencontainers.image.title="Internet in a Box"
LABEL org.opencontainers.image.description="A comprehensive suite of offline educational resources and applications, enabling access to a wealth of knowledge without an active internet connection."
LABEL org.opencontainers.image.authors="Kenneth Wyrick, Josh Santos"
LABEL org.opencontainers.image.vendor="CalTekNet"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.url="https://caltek.net"
LABEL org.opencontainers.image.source="https://github.com/CalTekNet/docker-images/tree/main/iiab"
LABEL org.opencontainers.image.version="$LATEST_VERSION"
LABEL org.opencontainers.image.revision="$LATEST_REVISION"

# Set the shell to /bin/ash and enable pipefail
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Create a non-root user and group and install deps
RUN addgroup --system "$USER" && \
    adduser --system "$USER" --ingroup "$GROUP" && \
    apt -y update && \
    apt -y install \
        sudo \
        curl \
        bash && \
    curl https://iiab.io/install.txt | bash

# Switch to the non-root user
USER "$USER"

# Set the working directory
WORKDIR /iiab

# Set the entrypoint and command
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD []
