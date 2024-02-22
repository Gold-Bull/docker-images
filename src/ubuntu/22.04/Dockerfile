FROM ubuntu:22.04

RUN cat /etc/apt/sources.list \
    && sed -i.bak "s/# deb-src/deb-src/g" /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y dpkg dpkg-cross dpkg-dev \
    && cat /etc/apt/sources.list \
    && mkdir -p /tmp/libunwind \
    && chown -R _apt:root /tmp/libunwind \
    && chmod -R 0755 /tmp/libunwind \
    && cd /tmp/libunwind \
    && apt-get source libunwind8 \
    && apt-get build-dep -y libunwind8 \
    && ls -l /tmp/libunwind \
    &&  dpkg-buildpackage -rfakeroot -uc -b \
    && ls -l /tmp/libunwind

# Install dependencies https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#dependencies
RUN apt-get update && apt-get install -y \
    libc6 \
    libgcc-s1 \
    libgssapi-krb5-2 \
    libicu70 \
    liblttng-ust1 \
    libssl3 \
    libstdc++6 \
#    libunwind8 \ # libunwind8 is not available in Ubuntu 22.04 (s390x architecture)
    zlib1g \
    libgdiplus
