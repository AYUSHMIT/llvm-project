#!/usr/bin/env bash
set -euo pipefail

# Configuration
OUT_DIR="${OUT_DIR:-out}"
TARGET="${TARGET:-x86_64}"
TRIPLE="${TRIPLE:-x86_64-pc-linux-gnu}"
CFLAGS="${CFLAGS:-}"
OPT_LEVEL="${OPT_LEVEL:-O3}"

mkdir -p "${OUT_DIR}"

# 1) C -> LLVM IR
clang -S -emit-llvm samples/sample.c -o "${OUT_DIR}/sample.ll" ${CFLAGS}

# 2) IR -> Bitcode
llvm-as "${OUT_DIR}/sample.ll" -o "${OUT_DIR}/sample.bc"

# 3) Bitcode analyzer
llvm-bcanalyzer -dump "${OUT_DIR}/sample.bc" > "${OUT_DIR}/sample.bc.dump.txt"

# 4) Optimize IR
opt -S -${OPT_LEVEL} "${OUT_DIR}/sample.ll" -o "${OUT_DIR}/sample.opt.ll"

# 5) IR -> ASM
llc -filetype=asm -mtriple="${TRIPLE}" "${OUT_DIR}/sample.opt.ll" -o "${OUT_DIR}/sample.s"

# 6) ASM -> OBJ (assembler)
llvm-mc -filetype=obj -triple="${TRIPLE}" "${OUT_DIR}/sample.s" -o "${OUT_DIR}/sample.o"

# 7) Link to executable
ld.lld "${OUT_DIR}/sample.o" -o "${OUT_DIR}/sample"

# 8) Disassemble object
llvm-objdump -d "${OUT_DIR}/sample.o" > "${OUT_DIR}/sample.disasm.txt"

echo "Demo completed. Artifacts in ${OUT_DIR}"
