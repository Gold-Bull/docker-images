# syntax=docker/dockerfile:1
FROM ubuntu:20.04

ARG TARGETARCH
ARG TARGETOS

ENV DEBIAN_FRONTEND=noninteractive \
    NODEJS_VERSION=v14.21.3 \
    PATH="${PATH}:/opt/nodejs/bin"

# Install dependencies https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#dependencies
RUN <<EOT bash
set -ex
apt-get update
apt-get install -y ca-certificates curl wget tar
mkdir -p /opt/nodejs
wget -O - "https://nodejs.org/dist/\${NODEJS_VERSION}/node-\${NODEJS_VERSION}-linux-\${TARGETARCH/amd64/x64}.tar.xz" | tar -C /opt/nodejs -x -
mv /opt/nodejs/node-\${NODEJS_VERSION}-linux-\${TARGETARCH/amd64/x64}/* /opt/nodejs/
apt-get install -y libc6 libgcc-s1 libgssapi-krb5-2 libicu66 libssl1.1 libstdc++6 zlib1g libgdiplus
EOT
