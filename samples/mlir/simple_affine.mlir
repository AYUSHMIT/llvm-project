func.func @sum_affine(%arg0: index) -> i32 {
  %c0_i32 = arith.constant 0 : i32
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c3_i32 = arith.constant 3 : i32
  
  %result = scf.for %i = %c0 to %arg0 step %c1 iter_args(%sum = %c0_i32) -> (i32) {
    %i_i32 = arith.index_cast %i : index to i32
    %added = arith.addi %i_i32, %c3_i32 : i32
    %new_sum = arith.addi %sum, %added : i32
    scf.yield %new_sum : i32
  }
  
  return %result : i32
}
