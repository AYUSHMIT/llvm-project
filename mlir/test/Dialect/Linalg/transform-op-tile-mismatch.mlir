// RUN: mlir-opt --transform-interpreter --split-input-file --verify-diagnostics %s

// Test case for issue #93693: tile_using_for should emit a clear error when
// the number of loop results doesn't match the number of loops produced

module attributes {transform.with_named_sequence} {
  transform.named_sequence @__transform_main(%arg1: !transform.any_op {transform.readonly}) {
    %0 = transform.structured.match ops{["linalg.generic"]} in %arg1 : (!transform.any_op) -> !transform.any_op
    // expected-error @below {{expected 2 loop results but tiling produced 3 loops}}
    %1, %loops:2 = transform.structured.tile_using_for %0 tile_sizes [2, 3, 4] : (!transform.any_op) -> (!transform.any_op, !transform.any_op, !transform.any_op)
    transform.yield
  }
}

func.func @fold_extract_slice(
  %arg0 : tensor<?x128xf32>, %arg1 : tensor<?x42xf32>, %arg2 : tensor<?x42x?xf32>) -> tensor<?x42xf32> {

  %c0 = arith.constant 0 : index

  %0 = tensor.dim %arg1, %c0 : tensor<?x42xf32>
  %1 = tensor.extract_slice %arg0[3, 4] [%0, 42] [1, 1] : tensor<?x128xf32> to tensor<?x42xf32>

  // expected-note @below {{target op}}
  %2 = linalg.generic
    {indexing_maps = [affine_map<(d0, d1, d2) -> (d0, d1)>,
                      affine_map<(d0, d1, d2) -> (d0, d1, d2)>,
                      affine_map<(d0, d1, d2) -> (d0, d1)>],
     iterator_types = ["parallel", "parallel", "parallel"]}
    ins(%1, %arg2 : tensor<?x42xf32>, tensor<?x42x?xf32>)
    outs(%arg1 : tensor<?x42xf32>) {
    ^bb0(%arg3 : f32, %arg4: f32, %arg5: f32):
      %5 = arith.addf %arg3, %arg5 : f32
      linalg.yield %5 : f32
    } -> tensor<?x42xf32>
  return %2 : tensor<?x42xf32>
}
