# Dockerized Demo

Build and run the demo in a containerized environment:

```bash
# Build the Docker image
docker build -t llvm-demokit .

# Run the demo
docker run --rm -it -v $(pwd):/workspace llvm-demokit bash -lc 'bash scripts/demo.sh'

# Run with custom optimization level
docker run --rm -it -e OPT_LEVEL=O2 -v $(pwd):/workspace llvm-demokit bash -lc 'bash scripts/demo.sh'

# Interactive shell for exploration
docker run --rm -it -v $(pwd):/workspace llvm-demokit bash
```

## Benefits

- Consistent build environment across different host systems
- Pre-built LLVM tools for faster local iteration
- Isolation from host system dependencies
- Easy sharing and reproduction of demo results
