FROM rust:trixie as builder
ARG CARGO_TERM_COLOR=always
RUN git clone https://github.com/rustdesk/rustdesk-server.git --recursive \
    && cd rustdesk-server \
    && git rm -r libs/ && git submodule add https://github.com/rustdesk/hbb_common.git libs/hbb_common \
    && cargo build --release

FROM scratch
COPY --from=builder /rustdesk-server/target/release/hbbs /usr/bin/hbbs
COPY --from=builder /rustdesk-server/target/release/hbbr /usr/bin/hbbr
