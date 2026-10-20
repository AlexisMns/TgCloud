
FROM golang:1.27.3-alpine3.24 AS builder


WORKDIR /app

# copy module 
COPY go.mod go.sum ./

RUN go mod download

# copy du source code
COPY . .
# build
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

EXPOSE 8100
