/*
 * N-API stub (not compiled in the v1 check).
 * Bouw later met node-gyp/cmake-js volgens https://nodejs.org/api/n-api.html
 * Exports native_c_add as JS `add`. Pure logic stays in add.c.
 *
 * #include <node_api.h>
 * #include "add.h"
 * ... napi_create_function ...
 */
#include "add.h"

/* Quiet unused-include when someone compiles this file by mistake without N-API. */
int32_t native_c_napi_add_bridge(int32_t left, int32_t right) {
  return native_c_add(left, right);
}
