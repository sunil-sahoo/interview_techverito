FROM golang:1.19

WORKDIR /usr/src/app

COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY . .
RUN go get ./...

ENV DB_HOST=1.2.3.4
ENV DB_USER=postgres
ENV DB_PASSWORD=secret
ENV DB_NAME=admin
ENV DB_PORT=5432
ENV ALLOWED_ORIGINS=0.0.0.0/0

RUN go build -v -o main .

EXPOSE 8080

CMD ["./main"]
