FROM rust:trixie AS builder
ARG CARGO_TERM_COLOR=always
COPY rustdesk-server/ /rustdesk-server/
WORKDIR /rustdesk-server
RUN cargo build --release

FROM debian:trixie-slim
COPY --from=builder /rustdesk-server/target/release/hbbs /usr/bin/hbbs
COPY --from=builder /rustdesk-server/target/release/hbbr /usr/bin/hbbr
WORKDIR /root
