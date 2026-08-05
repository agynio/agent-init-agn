# syntax=docker/dockerfile:1
FROM alpine:3.21

ARG AGN_VERSION
ARG TARGETARCH

# agynd and the agyn CLI are not here: they ship with the platform and arrive
# in the same volume from their own init images, so this pins one agent CLI.
RUN mkdir -p /tools

RUN apk add --no-cache curl && \
    curl -fsSL "https://github.com/agynio/agn-cli/releases/download/v${AGN_VERSION}/agn-linux-${TARGETARCH}" \
      -o /tools/agn && \
    chmod +x /tools/agn

COPY config.json /tools/config.json

ENTRYPOINT ["cp", "-a", "/tools/.", "/agyn/bin/"]
