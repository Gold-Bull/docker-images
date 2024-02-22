FROM ubuntu:22.04

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
