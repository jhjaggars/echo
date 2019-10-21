FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git
WORKDIR $GOPATH/src/mypackage/myapp/
COPY . .
ENV GO111MODULE=on
RUN go get -d -v
RUN CGO_ENABLED=0 go build -o /go/bin/ws-test
FROM registry.access.redhat.com/ubi8/ubi:latest
COPY --from=builder /go/bin/ws-test /go/bin/ws-test
EXPOSE 8080/tcp
ENTRYPOINT ["/go/bin/ws-test"]
