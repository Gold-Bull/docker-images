# syntax=docker/dockerfile:1 
FROM ubuntu:22.04

ARG TARGETPLATFORM
ARG BUILDPLATFORM

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#dependencies
RUN <<EOT bash
set -ex
apt-get update
apt-get install -y libc6 libgcc-s1 libgssapi-krb5-2 libicu70 liblttng-ust1 libssl3 libstdc++6 zlib1g libgdiplus
if [ "$TARGETPLATFORM" == "$BUILDPLATFORM" ]; then
  apt-get install -y libunwind8
fi
EOT
