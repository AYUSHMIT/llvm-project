#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="${OUT_DIR:-out}"
mkdir -p "${OUT_DIR}"

# Ensure we have the base IR file
if [ ! -f "${OUT_DIR}/sample.ll" ]; then
  echo "Error: ${OUT_DIR}/sample.ll not found. Run demo.sh first."
  exit 1
fi

echo "Running optimization experiments..."

# Full O3 optimization
echo "1) O3 optimization..."
opt -S -O3 "${OUT_DIR}/sample.ll" -o "${OUT_DIR}/sample.opt.ll"

# Fine-grained passes
echo "2) Fine-grained passes (mem2reg, sroa, constprop, inline)..."
opt -S -passes="mem2reg,sroa,constprop,inline" "${OUT_DIR}/sample.ll" -o "${OUT_DIR}/sample.tuned.ll"

# Print before/after for inspection
echo "3) Detailed pass tracking..."
opt -S -passes="default<O3>" -print-before-all -print-after-all "${OUT_DIR}/sample.ll" -o /dev/null 2> "${OUT_DIR}/opt_passes.log"

echo ""
echo "Optimization playground complete. See ${OUT_DIR}/ for results."
echo "Compare IR files:"
echo "  - ${OUT_DIR}/sample.ll (original)"
echo "  - ${OUT_DIR}/sample.opt.ll (O3)"
echo "  - ${OUT_DIR}/sample.tuned.ll (custom passes)"
echo "  - ${OUT_DIR}/opt_passes.log (detailed pass log)"
