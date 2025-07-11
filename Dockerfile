FROM golang:1.23-alpine AS builder
ADD . /app
RUN cd /app && \
    go build -v -trimpath -ldflags "-s -w -buildid=" -o gruploader && \
    ./gruploader --help

FROM ubuntu:24.10
COPY --from=builder /app/gruploader /usr/local/bin/gruploader
RUN chmod +x /usr/local/bin/gruploader
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl wget jq zip unzip git \
    && rm -rf /var/lib/apt/lists/*