#!/bin/sh
set -e

# Copy vendored files for NGINX to have access to.
cp -rf /elgg/* /opt/static

exec "$@"
