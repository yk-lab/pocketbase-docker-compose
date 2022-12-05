# FROM --platform=arm64 ubuntu
FROM ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates\
    wget \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ARG VERSION=0.8.0
RUN set -e \
    && wget --no-verbose --show-progress --progress=dot:mega -O pocketbase.zip https://github.com/pocketbase/pocketbase/releases/download/v${VERSION}/pocketbase_${VERSION}_linux_arm64.zip \
    && unzip pocketbase.zip \
    && rm pocketbase.zip

ARG PORT=8090
ENV PORT ${PORT}
EXPOSE ${PORT}
CMD ./pocketbase serve --http 0.0.0.0:${PORT}
