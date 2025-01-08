# Base
FROM golang:1.20.7-alpine AS builder
RUN apk add --no-cache build-base
WORKDIR /app
COPY . /app
RUN go mod download
RUN go build ./cmd/cvemap

# Release
FROM alpine:3.21.1
RUN apk -U upgrade --no-cache \
    && apk add --no-cache bind-tools ca-certificates
COPY --from=builder /app/cvemap /usr/local/bin/

ENTRYPOINT ["cvemap"]
