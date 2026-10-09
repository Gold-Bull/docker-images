# syntax=docker/dockerfile:1
FROM debian:bookworm-slim AS extract

ARG VYOS_RELEASE
# Public key published on https://vyos.net/get/stream/
ARG VYOS_MINISIGN_PUBKEY=RWTR1ty93Oyontk6caB9WqmiQC4fgeyd/ejgRxCRGd2MQej7nqebHneP
ARG VYOS_DOWNLOAD_URL=https://community-downloads.vyos.dev/stream

ENV DEBIAN_FRONTEND=noninteractive

RUN <<'EOT' bash
set -ex
test -n "$VYOS_RELEASE"
apt-get update
apt-get install -y --no-install-recommends ca-certificates curl minisign xorriso squashfs-tools
rm -rf /var/lib/apt/lists/*

iso="vyos-${VYOS_RELEASE}-generic-amd64.iso"
curl -fsSL -o "/tmp/$iso" "$VYOS_DOWNLOAD_URL/$VYOS_RELEASE/$iso"
curl -fsSL -o "/tmp/$iso.minisig" "$VYOS_DOWNLOAD_URL/$VYOS_RELEASE/$iso.minisig"
minisign -Vm "/tmp/$iso" -P "$VYOS_MINISIGN_PUBKEY"

xorriso -osirrox on -indev "/tmp/$iso" -extract /live/filesystem.squashfs /tmp/filesystem.squashfs
unsquashfs -f -d /rootfs /tmp/filesystem.squashfs
rm -f /tmp/"$iso" /tmp/"$iso.minisig" /tmp/filesystem.squashfs
EOT

FROM scratch

ARG VYOS_RELEASE
ENV VYOS_RELEASE=${VYOS_RELEASE}

COPY --from=extract /rootfs/ /

CMD ["/sbin/init"]
