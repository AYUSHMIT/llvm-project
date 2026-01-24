# Cross-target Codegen and Disassembly

Demonstrate code generation to multiple targets:

```bash
# X86_64
llc -filetype=obj -mtriple=x86_64-pc-linux-gnu out/sample.opt.ll -o out/sample.x86_64.o
llvm-objdump -d out/sample.x86_64.o > out/sample.x86_64.disasm.txt

# AArch64
llc -filetype=obj -mtriple=aarch64-unknown-linux-gnu out/sample.opt.ll -o out/sample.aarch64.o
llvm-objdump -d out/sample.aarch64.o > out/sample.aarch64.disasm.txt

# WebAssembly (object only; link via wasm-ld)
llc -filetype=obj -mtriple=wasm32-unknown-unknown out/sample.opt.ll -o out/sample.wasm.o
llvm-objdump -d out/sample.wasm.o > out/sample.wasm.disasm.txt
```

## Comparing Target Outputs

Each target will produce different assembly code:
- **X86_64**: Traditional x86 instructions with complex addressing modes
- **AArch64**: ARM 64-bit RISC instructions with load/store architecture
- **WebAssembly**: Stack-based virtual ISA designed for web execution

Use the disassembly outputs to study how the same IR compiles to different architectures.
