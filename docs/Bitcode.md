# Bitcode Analysis

Use `llvm-bcanalyzer` to inspect LLVM bitcode structure:

```bash
# Analyze bitcode structure
llvm-bcanalyzer -dump out/sample.bc > out/sample.bc.dump.txt

# Compare O0 vs O3 bitcode
clang -c -emit-llvm -O0 samples/sample.c -o out/sample.O0.bc
clang -c -emit-llvm -O3 samples/sample.c -o out/sample.O3.bc

llvm-bcanalyzer -dump out/sample.O0.bc > out/sample.O0.bc.dump.txt
llvm-bcanalyzer -dump out/sample.O3.bc > out/sample.O3.bc.dump.txt

# Compare the sizes and structure
diff -u out/sample.O0.bc.dump.txt out/sample.O3.bc.dump.txt
```

The analyzer shows:
- Block structure and record counts
- Module statistics
- Size metrics for different optimization levels
- Symbol table information

This helps understand how optimizer transformations affect bitcode representation.
