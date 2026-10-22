FROM rust:1-bookworm AS builder
WORKDIR /app
COPY . .
RUN cargo install mdbook --locked
RUN mdbook build

FROM alpine:3.22
COPY --from=builder /app/book /site
ENV PORT=3000
EXPOSE 3000
CMD ["sh", "-c", "busybox httpd -f -p \"\$PORT\" -h /site"]