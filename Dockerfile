FROM golang:1.7.3 as builder
WORKDIR /go/src/github.com/oltur/awesome
RUN go get -d -v golang.org/x/net/html
RUN go get -d -v github.com/gorilla/mux
COPY app.go    .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/oltur/awesome/app .
CMD ["./app"]