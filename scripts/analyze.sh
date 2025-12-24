#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="${OUT_DIR:-out}"
mkdir -p "${OUT_DIR}"

# Ensure we have the base IR file
if [ ! -f "${OUT_DIR}/sample.ll" ]; then
  echo "Error: ${OUT_DIR}/sample.ll not found. Run demo.sh first."
  exit 1
fi

# Analyze base bitcode
echo "Analyzing base bitcode..."
llvm-as "${OUT_DIR}/sample.ll" -o "${OUT_DIR}/sample.bc"
llvm-bcanalyzer -dump "${OUT_DIR}/sample.bc" > "${OUT_DIR}/sample.bc.dump.txt"

# Generate O0 bitcode for comparison
echo "Generating O0 bitcode..."
clang -c -emit-llvm -O0 samples/sample.c -o "${OUT_DIR}/sample.O0.bc"
llvm-bcanalyzer -dump "${OUT_DIR}/sample.O0.bc" > "${OUT_DIR}/sample.O0.bc.dump.txt"

# Generate O3 bitcode for comparison
echo "Generating O3 bitcode..."
clang -c -emit-llvm -O3 samples/sample.c -o "${OUT_DIR}/sample.O3.bc"
llvm-bcanalyzer -dump "${OUT_DIR}/sample.O3.bc" > "${OUT_DIR}/sample.O3.bc.dump.txt"

# Show size comparison
echo ""
echo "Bitcode size comparison:"
ls -lh "${OUT_DIR}"/sample.O*.bc

echo ""
echo "Bitcode analysis complete. See ${OUT_DIR}/ for results."
echo "Compare dumps with: diff -u ${OUT_DIR}/sample.O0.bc.dump.txt ${OUT_DIR}/sample.O3.bc.dump.txt"
