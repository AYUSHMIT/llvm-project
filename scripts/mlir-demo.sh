#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="${OUT_DIR:-out}"
mkdir -p "${OUT_DIR}"

# Check for MLIR tools
if ! command -v mlir-opt &> /dev/null; then
  echo "Error: mlir-opt not found. Build LLVM with MLIR enabled."
  exit 1
fi

if ! command -v mlir-translate &> /dev/null; then
  echo "Error: mlir-translate not found. Build LLVM with MLIR enabled."
  exit 1
fi

echo "Running MLIR to LLVM IR demo..."

# Lower MLIR to LLVM IR
echo "1) Lowering MLIR to LLVM IR..."
mlir-opt samples/mlir/simple_affine.mlir \
  -convert-affine-to-standard \
  | mlir-opt \
    -convert-scf-to-cf \
    -convert-math-to-llvm \
    -convert-func-to-llvm \
  | mlir-translate -mlir-to-llvmir > "${OUT_DIR}/mlir.ll"

# Continue with standard LLVM pipeline
echo "2) Optimizing LLVM IR..."
opt -S -O3 "${OUT_DIR}/mlir.ll" -o "${OUT_DIR}/mlir.opt.ll"

echo "3) Generating object file..."
llc -filetype=obj -mtriple=x86_64-pc-linux-gnu "${OUT_DIR}/mlir.opt.ll" -o "${OUT_DIR}/mlir.o"

echo "4) Disassembling..."
llvm-objdump -d "${OUT_DIR}/mlir.o" > "${OUT_DIR}/mlir.disasm.txt"

echo ""
echo "MLIR demo complete. See ${OUT_DIR}/ for results:"
echo "  - ${OUT_DIR}/mlir.ll (lowered LLVM IR)"
echo "  - ${OUT_DIR}/mlir.opt.ll (optimized)"
echo "  - ${OUT_DIR}/mlir.o (object file)"
echo "  - ${OUT_DIR}/mlir.disasm.txt (disassembly)"
