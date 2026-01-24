# MLIR to LLVM IR Demo (Optional)

Lower MLIR to LLVM dialect, then to LLVM IR:

```bash
mlir-opt samples/mlir/simple_affine.mlir -convert-affine-to-standard \
  | mlir-opt -convert-scf-to-cf -convert-math-to-llvm -convert-func-to-llvm \
  | mlir-translate -mlir-to-llvmir > out/mlir.ll

# Continue pipeline as in demo.sh
opt -S -O3 out/mlir.ll -o out/mlir.opt.ll
llc -filetype=obj -mtriple=x86_64-pc-linux-gnu out/mlir.opt.ll -o out/mlir.o
llvm-objdump -d out/mlir.o > out/mlir.disasm.txt
```

## MLIR Benefits

MLIR (Multi-Level Intermediate Representation) provides:
- Progressive lowering through multiple abstraction levels
- Domain-specific dialects (affine, linalg, tensor, etc.)
- Structured transformations before reaching LLVM IR
- Better optimization opportunities at higher abstraction levels

This demo shows how MLIR integrates with the standard LLVM pipeline.
