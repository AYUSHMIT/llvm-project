#include <stdio.h>

static inline int add3(int x) { return x + 3; }

int sum_loop(int n) {
  int s = 0;
  for (int i = 0; i < n; ++i) s += add3(i);
  return s;
}

int main() {
  int s = sum_loop(10);
  printf("sum=%d\n", s);
  return 0;
}
