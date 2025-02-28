// RUN: %clang_cc1 -no-opaque-pointers -triple riscv32-unknown-unknown -target-cpu ventus-gpgpu -S -emit-llvm -o - %s | FileCheck %s

kernel void test_kernel(global int *out)
{
  out[0] = 4;
}

// CHECK: define{{.*}} ventus_kernel void @test_call_kernel(i32 addrspace(1)* nocapture noundef writeonly align 4 %out)
// CHECK: store i32 4, i32 addrspace(1)* %out, align 4
__kernel void test_call_kernel(__global int *out)
{
  test_kernel(out);
}
