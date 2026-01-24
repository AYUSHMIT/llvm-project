# LLVM IR-to-Object Demo (DemoKit)

This demo shows a full pipeline using LLVM:
1. Compile C to LLVM IR with `clang -S -emit-llvm`
2. Assemble IR to bitcode with `llvm-as`
3. Analyze bitcode with `llvm-bcanalyzer`
4. Optimize IR with `opt` (O3 and custom passes)
5. Generate assembly/object with `llc` and `llvm-mc`
6. Link to executable with `ld.lld`
7. Disassemble object with `llvm-objdump`

## Quick start (local)
```bash
# From repo root after building LLVM tools
bash scripts/demo.sh
```

Artifacts produced under `out/`:
- `sample.ll` / `sample.bc` / `sample.opt.ll`
- `sample.s` / `sample.o` / `sample`
- `sample.disasm.txt` / `sample.bc.dump.txt`

## CI
The GitHub Actions workflow builds minimal LLVM tools with caching, runs the pipeline,
and uploads artifacts for inspection. See `.github/workflows/demo.yml`.

## Targets
By default, we build X86_64. The CI also demonstrates AArch64 and WebAssembly object generation and disassembly.
