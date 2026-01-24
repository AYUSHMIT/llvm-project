# LLVM DemoKit

An amazing demo showcasing the complete LLVM IR-to-object pipeline with assembler, disassembler, bitcode analyzer, and optimizer—plus optional MLIR and WebAssembly targets.

## 🎯 What This Demonstrates

This DemoKit shows the full LLVM compilation pipeline:

```
C Source → LLVM IR → Bitcode → Optimized IR → Assembly → Object → Binary → Disassembly
```

### Key Features

- **Complete Pipeline**: From source code to executable, touching every major LLVM tool
- **Bitcode Analysis**: Deep dive into LLVM's intermediate representation format
- **Optimization Playground**: Compare different optimization levels and passes
- **Cross-Target Codegen**: Generate code for X86_64, AArch64, and WebAssembly
- **CI-Driven**: Automated builds with caching for fast iteration
- **Optional MLIR**: Demonstrate MLIR lowering to LLVM IR
- **Dockerized**: Run locally in a consistent environment

## 🚀 Quick Start

### Prerequisites

Build the minimal set of LLVM tools (or use the CI artifacts):

```bash
cmake -S llvm -B build \
  -G Ninja \
  -DLLVM_ENABLE_PROJECTS="clang;lld" \
  -DLLVM_TARGETS_TO_BUILD="X86;AArch64;WebAssembly" \
  -DLLVM_INCLUDE_TESTS=OFF \
  -DLLVM_INCLUDE_EXAMPLES=OFF \
  -DCMAKE_BUILD_TYPE=Release

cmake --build build --target \
  clang llvm-as llvm-dis opt llc llvm-mc llvm-objdump llvm-bcanalyzer lld
```

Add tools to your PATH:
```bash
export PATH="${PWD}/build/bin:${PATH}"
```

### Run the Demo

```bash
# Main pipeline demo
bash scripts/demo.sh

# Bitcode analysis
bash scripts/analyze.sh

# Optimization experiments
bash scripts/opt-playground.sh

# Cross-target code generation
bash scripts/codegen-matrix.sh

# Optional: MLIR demo (requires MLIR build)
bash scripts/mlir-demo.sh
```

All artifacts are generated in the `out/` directory.

## 📚 Documentation

Detailed guides for each component:

- **[docs/Demo.md](docs/Demo.md)** - Main pipeline walkthrough
- **[docs/Bitcode.md](docs/Bitcode.md)** - Bitcode analysis and comparison
- **[docs/Optimization.md](docs/Optimization.md)** - Optimization passes and techniques
- **[docs/Targets.md](docs/Targets.md)** - Cross-target code generation
- **[docs/MLIR.md](docs/MLIR.md)** - Optional MLIR lowering demo
- **[docs/Docker.md](docs/Docker.md)** - Dockerized environment setup

## 🔧 CI/CD

The GitHub Actions workflow (`.github/workflows/demo.yml`) automatically:

1. Builds minimal LLVM tools with caching
2. Runs the complete demo pipeline
3. Uploads all artifacts for inspection

Artifacts include:
- LLVM IR (`.ll` files)
- Bitcode (`.bc` files)
- Assembly (`.s` files)
- Object files (`.o` files)
- Disassembly output
- Optimization logs

## 🎨 Sample Code

The demo uses a simple C program (`samples/sample.c`) that demonstrates:
- Function inlining opportunities
- Loop optimization
- Constant propagation
- Dead code elimination

Perfect for visualizing optimization effects!

## 🐳 Docker Support

Run the demo in a containerized environment:

```bash
docker build -t llvm-demokit .
docker run --rm -it -v $(pwd):/workspace llvm-demokit bash -lc 'bash scripts/demo.sh'
```

See [docs/Docker.md](docs/Docker.md) for more details.

## 📦 Artifacts Generated

After running `demo.sh`, you'll find in `out/`:

| File | Description |
|------|-------------|
| `sample.ll` | LLVM IR from C source |
| `sample.bc` | Bitcode representation |
| `sample.bc.dump.txt` | Bitcode structure analysis |
| `sample.opt.ll` | Optimized LLVM IR |
| `sample.s` | Assembly code |
| `sample.o` | Object file |
| `sample` | Linked executable |
| `sample.disasm.txt` | Disassembled object code |

Additional scripts generate more artifacts for comparison and analysis.

## 🎓 Learning Path

1. **Start with the basics**: Run `demo.sh` and examine the generated files in `out/`
2. **Compare optimizations**: Run `analyze.sh` to see O0 vs O3 differences
3. **Experiment with passes**: Use `opt-playground.sh` to try specific optimizations
4. **Explore targets**: Run `codegen-matrix.sh` to see architecture differences
5. **Advanced**: Try `mlir-demo.sh` if MLIR is enabled

## 🏗️ Repository Structure

```
.
├── docs/                    # Documentation
│   ├── Demo.md
│   ├── Bitcode.md
│   ├── Optimization.md
│   ├── Targets.md
│   ├── MLIR.md
│   └── Docker.md
├── scripts/                 # Demo scripts
│   ├── demo.sh              # Main pipeline
│   ├── analyze.sh           # Bitcode analysis
│   ├── opt-playground.sh    # Optimization experiments
│   ├── codegen-matrix.sh    # Cross-target codegen
│   └── mlir-demo.sh         # MLIR demo
├── samples/                 # Sample code
│   ├── sample.c             # Demo C program
│   └── mlir/
│       └── simple_affine.mlir
├── .github/workflows/
│   └── demo.yml             # CI workflow
└── Dockerfile               # Container environment
```

## 🎯 Success Criteria

This demo is successful when:
- ✅ CI completes reliably with caching
- ✅ All pipeline stages produce valid artifacts
- ✅ Documentation enables easy reproduction
- ✅ Cross-target outputs show architectural differences
- ✅ Optimization comparisons are clear and educational

## 🤝 Contributing

This is a demonstration project in a fork of llvm/llvm-project. Feel free to:
- Experiment with different sample programs
- Add more optimization scenarios
- Extend the cross-target matrix
- Improve documentation

## 📄 License

This demo inherits the LLVM license. See [LICENSE.TXT](LICENSE.TXT) for details.

---

**Happy LLVM exploring! 🚀**
