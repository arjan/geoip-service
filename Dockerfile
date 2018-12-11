FROM golang:alpine AS builder
# Install git.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git
COPY . $GOPATH/src/mypackage/myapp/
WORKDIR $GOPATH/src/mypackage/myapp/

# Fetch dependencies.
# Using go get.
RUN go get -d -v
# Build the binary.
RUN go build -o /app


FROM alpine:latest
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

COPY geodb.mmdb /
COPY --from=builder /app /

EXPOSE 5000

CMD ["/app", "-db=/geodb.mmdb"]
