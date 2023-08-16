FROM golang:1.21-bullseye as builder


WORKDIR $GOPATH/src/smallest-golang/app/

COPY . .
RUN go mod init
RUN go mod download 
RUN go mod verify

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /fullcycle .

FROM scratch

COPY --from=builder /fullcycle .

CMD ["./fullcycle"]