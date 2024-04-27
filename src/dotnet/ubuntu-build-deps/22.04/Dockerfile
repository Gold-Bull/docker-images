# syntax=docker/dockerfile:labs
FROM ghcr.io/gold-bull/dotnet-runtime-base:ubuntu-22.04-latest

ARG TARGETARCH
ARG TARGETOS
ARG NODEJS_VERSIONS

ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=type=bind,target=/tmp/context --security=insecure <<EOT bash
echo $NODEJS_VERSIONS

bash /tmp/context/build.sh
EOT
