# syntax=docker/dockerfile:1 
FROM --platform=$BUILDPLATFORM ubuntu:22.04 AS build

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETARCH

ENV DEBIAN_FRONTEND=noninteractive

RUN <<EOT bash
set -ex
sed -i.bak "s/# deb-src/deb-src/g" /etc/apt/sources.list
apt-get update
apt-get install -y dpkg dpkg-cross dpkg-dev
mkdir -p /tmp/libunwind
chown -R _apt:root /tmp/libunwind
chmod -R 0755 /tmp/libunwind
cd /tmp/libunwind
if [ "$TARGETPLATFORM" != "$BUILDPLATFORM" ]; then
  apt-get install -y g++-12-$TARGETARCH-linux-gnu qemu-user-static
  export CC=$TARGETARCH-linux-gnu-gcc-12
  export CXX=$TARGETARCH-linux-gnu-g++-12
fi
apt-get build-dep -y libunwind8
apt-get source --compile libunwind8
ls -l /tmp/libunwind
EOT

#----------------------------------------------------------------------------------------------------

FROM ubuntu:22.04 AS final

ARG TARGETPLATFORM
ARG BUILDPLATFORM

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#dependencies
RUN --mount=type=bind,target=/tmp/libunwind,source=/tmp/libunwind,from=build <<EOT bash
set -ex
ls -l /tmp/libunwind
apt-get update
apt-get install -y libc6 libgcc-s1 libgssapi-krb5-2 libicu70 liblttng-ust1 libssl3 libstdc++6 zlib1g libgdiplus
if [ "$TARGETPLATFORM" == "$BUILDPLATFORM" ]; then
  apt-get install -y libunwind8
fi
EOT
