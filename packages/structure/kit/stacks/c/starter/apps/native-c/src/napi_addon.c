/*
 * N-API stub (niet gecompileerd in v1-check).
 * Bouw later met node-gyp/cmake-js volgens https://nodejs.org/api/n-api.html
 * Exporteer native_c_add als JS `add`. Pure logica blijft in add.c.
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
