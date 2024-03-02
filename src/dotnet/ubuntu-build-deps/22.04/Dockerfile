# syntax=docker/dockerfile:labs
FROM ghcr.io/gold-bull/dotnet-runtime-base:ubuntu-22.04-latest

ARG TARGETARCH
ARG TARGETOS
ARG NODEJS_VERSION=v14.21.3
ARG BUILD_DEPS_SCRIPT=https://gist.githubusercontent.com/SaileshBellamkonda/e050c6f8283c07b99329a405c837b22d/raw/dotnet-build-s390x-ubt-2204.sh

ENV DEBIAN_FRONTEND=noninteractive \
    PATH="/opt/nodejs/bin:${PATH}"

RUN --security=insecure <<EOT bash
set -ex
apt-get update
apt-get install -y curl bash
curl -L -o - $BUILD_DEPS_SCRIPT | bash -
EOT

RUN <<EOT bash
set -ex
apt-get update
apt-get install -y ca-certificates curl wget tar xz-utils
mkdir -p /opt/nodejs
chown -R root:root /opt/nodejs
chmod 0755 /opt/nodejs
wget -O - "https://nodejs.org/dist/$NODEJS_VERSION/node-$NODEJS_VERSION-linux-\${TARGETARCH/amd64/x64}.tar.xz" | tar --strip-components 1 -C /opt/nodejs -Jx --no-same-owner
node -v
EOT