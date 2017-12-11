# Cross compilation environment for Rust targeting Musl running on ARMv7

**Docker Hub: https://hub.docker.com/r/sensorfu/rust-musl-arm/**

This image uses [rust](https://hub.docker.com/_/rust/) Docker image and
[musl-cross-make](https://github.com/richfelker/musl-cross-make) tool to build
the C/C++ cross compilation environment.

## Cross compiling Rust

Everything should be set to automatically get cross compiled binaries. However,
some Rust crates depend on external libraries which you have to cross compile
yourself. See below for how to cross compile C/C++ libraries.

Mandatory Hello World example:

```console
# export USER=root
# cargo new --bin helloworld
     Created binary (application) `helloworld` project
# cd helloworld
# cargo build --release
   Compiling helloworld v0.1.0 (file:///helloworld)
    Finished release [optimized] target(s) in 0.41 secs
# file ./target/armv7-unknown-linux-musleabihf/release/helloworld
./target/armv7-unknown-linux-musleabihf/release/helloworld: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked, not stripped
```

## Cross compiling C/C++ libraries

It's possible to use this image to cross compile C/C++ libraries targeting ARMv7
Musl. For [autoconf](https://www.gnu.org/software/autoconf/autoconf.html) based
projects it should be enough to call `./configure` script with
`--host=armv7-linux-musleabihf` parameter.

Some environment variables are already set to help with cross compiling C/C++
libraries. See section "Environment variables" below.

For example compiling [LibreSSL](http://libressl.org/):

```console
# export LIBRESSL="libressl-2.5.5"
# mkdir work && cd work
# curl -fo- https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/${LIBRESSL}.tar.gz | tar zxf -
# cd ${LIBRESSL}
# ./configure --host=armv7-linux-musleabihf --enable-shared=no && make -j$(nproc)
# file apps/openssl/openssl
apps/openssl/openssl: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-musl-armhf.so.1, not stripped
```

## Environment variables

Inside the image there are various environment variables set:

* `CC`: Points to ARMv7 GCC C compiler
* `CXX`: Points to ARMv7 GCC C++ compiler
* `LD`: Points to ARMv7 GCC linker

# Building and uploading the Docker image

1. Fetch musl-cross-make sources into tree: `git submodule update --init`
2. Build the docker image: `docker build -t sensorfu/rust-musl-arm .`
3. Push to Docker Hub: `docker push sensorfu/rust-musl-arm`

# Licenses

## Rust

Excerpt from https://www.rust-lang.org/en-US/legal.html:

  Rust’s code is primarily distributed under the terms of both the MIT license
  and the Apache License (Version 2.0), with portions covered by various
  BSD-like licenses. See [LICENSE-APACHE](https://github.com/rust-lang/rust/blob/master/LICENSE-APACHE), [LICENSE-MIT](https://github.com/rust-lang/rust/blob/master/LICENSE-MIT), and [COPYRIGHT](https://github.com/rust-lang/rust/blob/master/COPYRIGHT) for details.

## musl-cross-make

musl-cross-make doesn't specify license. Individual components installed by
musl-cross-make have their own licenses.
