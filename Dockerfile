# syntax=docker/dockerfile:1
FROM alpine:3.21

ARG AGYND_VERSION
ARG AGN_VERSION
ARG TARGETARCH

RUN mkdir -p /tools

RUN apk add --no-cache curl && \
    curl -fsSL "https://github.com/agynio/agynd-cli/releases/download/v${AGYND_VERSION}/agynd-linux-${TARGETARCH}" \
      -o /tools/agynd && \
    chmod +x /tools/agynd

RUN curl -fsSL "https://github.com/agynio/agn-cli/releases/download/v${AGN_VERSION}/agn-linux-${TARGETARCH}" \
      -o /tools/agn && \
    chmod +x /tools/agn

COPY config.json /tools/config.json

ENTRYPOINT ["cp", "-a", "/tools/.", "/agyn-bin/"]
