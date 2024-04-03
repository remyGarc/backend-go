FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY . .

RUN go build -o ./server .

# FROM busybox:1.36.1 AS runner

# WORKDIR /app

# COPY --from=builder /app/server .

# CMD ["./server"]
