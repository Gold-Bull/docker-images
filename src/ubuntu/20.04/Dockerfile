# syntax=docker/dockerfile:1
FROM ubuntu:20.04

ARG TARGETARCH
ARG TARGETOS

ENV DEBIAN_FRONTEND=noninteractive \
    NODEJS_VERSION=v14.21.3 \
    PATH="/opt/nodejs/bin:${PATH}"

# Install dependencies https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#dependencies
RUN <<EOT bash
set -ex
apt-get update
apt-get install -y ca-certificates curl wget tar xz-utils
mkdir -p /opt/nodejs
wget -O - "https://nodejs.org/dist/\${NODEJS_VERSION}/node-\${NODEJS_VERSION}-linux-\${TARGETARCH/amd64/x64}.tar.xz" | tar --strip-components 1 -C /opt/nodejs -Jx
chown -R root:root /opt/nodejs
chmod -R 0755 /opt/nodejs
apt-get install -y libc6 libgcc-s1 libgssapi-krb5-2 libicu66 libssl1.1 libstdc++6 zlib1g libgdiplus
node -v
EOT
