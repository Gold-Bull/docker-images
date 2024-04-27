# syntax=docker/dockerfile:labs
FROM ghcr.io/gold-bull/dotnet-runtime-base:ubuntu-20.04-latest

ARG TARGETARCH
ARG TARGETOS
ARG NODEJS_VERSION=v14.21.3
ARG BUILD_DEPS_SCRIPT=https://gist.githubusercontent.com/SaileshBellamkonda/7a0fe00e2b999b56e9a77891df0cae84/raw/dotnet-build-s390x-ubt-2004.sh

ENV DEBIAN_FRONTEND=noninteractive \
    PATH="/opt/nodejs/bin:${PATH}"

RUN --security=insecure <<EOT bash
set -ex
apt-get update
apt-get install -y curl bash
curl -L -o - $BUILD_DEPS_SCRIPT | bash -
EOT

RUN <<EOT bash
set -ex
apt-get update
apt-get install -y ca-certificates curl wget tar xz-utils
export node_js_versions=("v14.21.3" "v16.20.2" "v18.20.2" "v20.12.2")
for node_js_version in "${node_js_versions[@]}"; do
    export node_js_version_major=${node_js_version:0:3}
    export node_js_dir="/opt/nodejs_$node_js_version_major"
    mkdir -p $node_js_dir
    chown -R root:root $node_js_dir
    chmod 0755 $node_js_dir
    wget -O - "https://nodejs.org/dist/$node_js_version/node-$node_js_version-linux-\${TARGETARCH/amd64/x64}.tar.xz" | tar --strip-components 1 -C $node_js_dir -Jx --no-same-owner
    $node_js_dir/bin/node -v
done
EOT