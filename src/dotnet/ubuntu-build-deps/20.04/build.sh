#!/bin/bash

set -ex

__Arch=s390x
__RootFsDir=/crossfs/$__Arch
__CodeName=focal
__PackagesToInstall="build-essential symlinks libicu-dev liblttng-ust-dev libnuma-dev libcurl4-openssl-dev libkrb5-dev libssl-dev openjdk-11-jdk zlib1g-dev"
__RepoUrl=http://ports.ubuntu.com/ubuntu-ports/

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    gnupg \
    locales \
    software-properties-common \
    vim \
    wget

if [[ ! -f /etc/apt/trusted.gpg.d/apt.kitware.com.asc ]]; then
    wget -qO- https://apt.kitware.com/keys/kitware-archive-latest.asc | tee /etc/apt/trusted.gpg.d/apt.kitware.com.asc
fi
apt-add-repository -y "deb https://apt.kitware.com/ubuntu/ ${__CodeName} main"

apt-get update
apt-get install -y \
    autoconf \
    automake \
    binfmt-support \
    binutils-arm-linux-gnueabihf \
    binutils-multiarch \
    binutils-s390x-linux-gnu \
    bison \
    bisonc++ \
    build-essential \
    cmake \
    cpio \
    curl \
    debootstrap \
    elfutils \
    flex \
    file \
    gdb \
    gettext \
    git \
    jq \
    libarchive-dev \
    libbsd-dev \
    libbz2-dev \
    libc6-dev-s390x-cross \
    libc6-s390x-cross \
    libcurl4-openssl-dev \
    libgdiplus \
    libicu-dev \
    libkrb5-dev \
    liblttng-ust-dev \
    liblzma-dev \
    libmpc-dev \
    libnuma-dev \
    libssl-dev \
    libtool \
    libunwind8 \
    libunwind8-dev \
    libxml2-utils \
    libz-dev \
    libzstd-dev \
    make \
    nasm \
    openjdk-11-jdk \
    python3 \
    python3-pip \
    qemu \
    qemu-user-static \
    rpm2cpio \
    tar \
    texinfo \
    uuid-dev \
    xz-utils \
    zip \
    zlib1g-dev

# .NET 6 requires clang 11
apt-get install -y \
    clang-11 \
    clang-tools-11 \
    lld-11 \
    llvm-11

# .NET 7 & 8 works with clang 15
wget -O - https://apt.llvm.org/llvm.sh | bash -s -- 15 \
    clang \
    clang-tools \
    liblldb-dev \
    lld \
    lldb \
    llvm \
    python3-lldb

locale-gen en_US.UTF-8

IFS=';' read -ra node_js_versions <<< "${NODEJS_VERSIONS}"
for node_js_version in "${node_js_versions[@]}"; do
    node_js_version_major=${node_js_version:0:3}
    node_js_dir="/opt/nodejs_$node_js_version_major"
    mkdir -p $node_js_dir
    chown -R root:root $node_js_dir
    chmod 0755 $node_js_dir
    wget -O - "https://nodejs.org/dist/$node_js_version/node-$node_js_version-linux-${TARGETARCH/amd64/x64}.tar.xz" | tar --strip-components 1 -C $node_js_dir -Jx --no-same-owner
    ls -l $node_js_dir
    $node_js_dir/bin/node -v
done

apt-get autoremove --purge -y
rm -rf /var/lib/apt/lists/*

mkdir -p $__RootFsDir
debootstrap "--variant=minbase" --arch "$__Arch" "$__CodeName" "$__RootFsDir" "$__RepoUrl"

cat <<EOF > "$__RootFsDir/etc/apt/sources.list"
deb $__RepoUrl ${__CodeName} main restricted universe
deb-src $__RepoUrl ${__CodeName} main restricted universe

deb $__RepoUrl ${__CodeName}-updates main restricted universe
deb-src $__RepoUrl ${__CodeName}-updates main restricted universe

deb $__RepoUrl ${__CodeName}-backports main restricted
deb-src $__RepoUrl ${__CodeName}-backports main restricted

deb $__RepoUrl ${__CodeName}-security main restricted universe multiverse
deb-src $__RepoUrl ${__CodeName}-security main restricted universe multiverse
EOF

mount -t proc /proc $__RootFsDir/proc/
mount --rbind /sys $__RootFsDir/sys/
mount --rbind /dev $__RootFsDir/dev/

chroot "$__RootFsDir" apt-get update
chroot "$__RootFsDir" apt-get -f -y install
chroot "$__RootFsDir" apt-get -y install $__PackagesToInstall
chroot "$__RootFsDir" symlinks -cr /usr
chroot "$__RootFsDir" apt-get clean
chroot "$__RootFsDir" rm -rf /var/lib/apt/lists/*
