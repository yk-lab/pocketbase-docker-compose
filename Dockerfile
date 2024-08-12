# syntax=docker/dockerfile:1
FROM --platform=$BUILDPLATFORM ubuntu:24.04 AS builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG VERSION

WORKDIR /pocketbase

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

RUN rm -f /etc/apt/apt.conf.d/docker-clean

# hadolint ignore=DL3008
RUN \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    --mount=type=cache,target=/var/cache/apt,sharing=locked \
    apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates\
    wget \
    unzip

RUN set -e \
    && wget --no-verbose --show-progress --progress=dot:mega -O pocketbase.zip https://github.com/pocketbase/pocketbase/releases/download/v${VERSION}/pocketbase_${VERSION}_linux_arm64.zip \
    && unzip pocketbase.zip \
    && rm pocketbase.zip

FROM gcr.io/distroless/static:nonroot

WORKDIR /pocketbase
COPY --from=builder --chown=nonroot:nonroot /pocketbase /pocketbase

USER nonroot:nonroot

ARG PORT=8090
ENV PORT ${PORT}
EXPOSE ${PORT}
ENTRYPOINT [ "./pocketbase" ]
CMD [ "--help" ]
