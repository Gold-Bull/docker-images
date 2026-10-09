# syntax=docker/dockerfile:1
# The rootfs tarball is produced by build.sh (vyos-build scripts/iso-to-oci)
FROM scratch

ARG VYOS_TARBALL

ADD ${VYOS_TARBALL} /

HEALTHCHECK --start-period=10s CMD systemctl is-system-running

CMD ["/sbin/init"]
