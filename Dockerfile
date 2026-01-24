FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential cmake ninja-build python3 clang lld \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
ENV PATH=/workspace/build/bin:$PATH
