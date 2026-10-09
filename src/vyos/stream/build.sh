#!/bin/bash
# Usage: build.sh <release> <vyos-build-dir> <out-dir>
#
# Downloads the VyOS Stream ISO, verifies its minisign signature and converts
# it to an OCI rootfs tarball using scripts/iso-to-oci from vyos/vyos-build.
# The tarball (vyos-<version>-oci-<arch>.tar.xz) is written to <out-dir>.

set -ex

if [[ "$#" -ne 3 ]]; then
    echo "Usage: $0 <release> <vyos-build-dir> <out-dir>"
    exit 2
fi

__Release=$1
__VyosBuildDir=$(realpath "$2")
__OutDir=$(realpath "$3")

# Public key published on https://vyos.net/get/stream/
__MinisignPubKey=${VYOS_MINISIGN_PUBKEY:-RWTR1ty93Oyontk6caB9WqmiQC4fgeyd/ejgRxCRGd2MQej7nqebHneP}
__DownloadUrl=${VYOS_DOWNLOAD_URL:-https://community-downloads.vyos.dev/stream}

__Iso="vyos-${__Release}-generic-amd64.iso"
__WorkDir=$(mktemp -d)
trap 'rm -rf "$__WorkDir"' EXIT

curl -fsSL -o "$__WorkDir/$__Iso" "$__DownloadUrl/$__Release/$__Iso"
curl -fsSL -o "$__WorkDir/$__Iso.minisig" "$__DownloadUrl/$__Release/$__Iso.minisig"
minisign -Vm "$__WorkDir/$__Iso" -P "$__MinisignPubKey"

# iso-to-oci writes the tarball to the current directory and needs root to
# preserve file ownership and device nodes
mkdir -p "$__OutDir"
cd "$__OutDir"
sudo "$__VyosBuildDir/scripts/iso-to-oci" "$__WorkDir/$__Iso"
sudo chown "$(id -u):$(id -g)" "$__OutDir"/vyos-*-oci-*.tar.xz
