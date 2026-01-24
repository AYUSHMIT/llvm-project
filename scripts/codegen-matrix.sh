#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="${OUT_DIR:-out}"
mkdir -p "${OUT_DIR}"

# Ensure we have optimized IR
if [ ! -f "${OUT_DIR}/sample.opt.ll" ]; then
  echo "Error: ${OUT_DIR}/sample.opt.ll not found. Run demo.sh first."
  exit 1
fi

echo "Generating code for multiple targets..."

# X86_64
echo "1) X86_64 target..."
llc -filetype=obj -mtriple=x86_64-pc-linux-gnu "${OUT_DIR}/sample.opt.ll" -o "${OUT_DIR}/sample.x86_64.o"
llvm-objdump -d "${OUT_DIR}/sample.x86_64.o" > "${OUT_DIR}/sample.x86_64.disasm.txt"

# AArch64
echo "2) AArch64 target..."
llc -filetype=obj -mtriple=aarch64-unknown-linux-gnu "${OUT_DIR}/sample.opt.ll" -o "${OUT_DIR}/sample.aarch64.o"
llvm-objdump -d "${OUT_DIR}/sample.aarch64.o" > "${OUT_DIR}/sample.aarch64.disasm.txt"

# WebAssembly
echo "3) WebAssembly target..."
llc -filetype=obj -mtriple=wasm32-unknown-unknown "${OUT_DIR}/sample.opt.ll" -o "${OUT_DIR}/sample.wasm.o"
llvm-objdump -d "${OUT_DIR}/sample.wasm.o" > "${OUT_DIR}/sample.wasm.disasm.txt"

echo ""
echo "Cross-target codegen complete. See ${OUT_DIR}/ for results."
echo "Disassembly files:"
echo "  - ${OUT_DIR}/sample.x86_64.disasm.txt"
echo "  - ${OUT_DIR}/sample.aarch64.disasm.txt"
echo "  - ${OUT_DIR}/sample.wasm.disasm.txt"
