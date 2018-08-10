FROM rust:1.28.0

COPY musl-cross-make/ /work/
RUN cd /work && \
    make -j"$(nproc)" TARGET="armv7-linux-musleabihf" && \
    make -j"$(nproc)" TARGET="armv7-linux-musleabihf" OUTPUT="/opt/armv7-linux-musleabihf" install && \
    cd / && rm -rf /work

RUN rustup target add armv7-unknown-linux-musleabihf
COPY cargo.config "${CARGO_HOME}/config"

ENV PATH=/opt/armv7-linux-musleabihf/bin:$PATH

ENV CC=armv7-linux-musleabihf-gcc
ENV CXX=armv7-linux-musleabihf-g++
ENV LD=armv7-linux-musleabihf-ld
