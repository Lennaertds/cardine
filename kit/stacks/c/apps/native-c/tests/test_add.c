#include <stdio.h>
#include <stdlib.h>

#include "add.h"

int main(void) {
  if (native_c_add(2, 2) != 4) {
    fprintf(stderr, "test_add: expected 4\n");
    return 1;
  }
  if (native_c_add(-1, 1) != 0) {
    fprintf(stderr, "test_add: expected 0\n");
    return 1;
  }
  puts("test_add: ok");
  return 0;
}
