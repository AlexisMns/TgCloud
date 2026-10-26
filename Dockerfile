
FROM golang:1.27.3-alpine3.24 AS builder


WORKDIR /app

# copy module 
COPY go.mod go.sum ./

RUN go mod download

# copy du source code
COPY . .
# build
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

FROM alpine:3.24
# Certif pour https
RUN apk add --no-cache ca-certificates

WORKDIR /app

COPY --from=builder /app/main .

EXPOSE 8100
# Pointe vers le binaire 
CMD ["./main"]