# syntax=docker/dockerfile:1 
FROM ubuntu:22.04

#RUN export DEBIAN_FRONTEND=noninteractive \
#    && sed -i.bak "s/# deb-src/deb-src/g" /etc/apt/sources.list \
#    && apt-get update \
#    && apt-get install -y dpkg dpkg-cross dpkg-dev \
#    && mkdir -p /tmp/libunwind \
#    && chown -R _apt:root /tmp/libunwind \
#    && chmod -R 0755 /tmp/libunwind \
#    && cd /tmp/libunwind \
#    && apt-get build-dep -y libunwind8 \
#    && apt-get source --compile libunwind8 \
#    && ls -l /tmp/libunwind

# Install dependencies https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#dependencies
RUN <<EOT bash
  set -ex
  apt-get update
  apt-get install -y libc6 libgcc-s1 libgssapi-krb5-2 libicu70 liblttng-ust1 libssl3 libstdc++6 zlib1g libgdiplus
  if [[ "$(uname -m)" != "s390x" ]] ; then
    apt-get install -y libunwind8
  fi
EOT
