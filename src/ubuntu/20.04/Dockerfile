# syntax=docker/dockerfile:1
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#dependencies
RUN <<EOT bash
set -ex
apt-get update
apt-get install -y libc6 libgcc-s1 libgssapi-krb5-2 libicu66 libssl1.1 libstdc++6 zlib1g libgdiplus
EOT
