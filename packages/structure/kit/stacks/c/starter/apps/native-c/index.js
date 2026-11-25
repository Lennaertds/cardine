'use strict';
// Placeholder until a real N-API addon is built (node-gyp / cmake-js).
// Nest: load the .node behind a seam; see docs/architecture/polyglot.md.
// NATIVE_STRICT=1: no JS fallback (CI / check-full).

function add(left, right) {
  if (process.env.NATIVE_STRICT === '1') {
    // eslint-disable-next-line import/no-unresolved
    return require('./native_c.node').add(left, right);
  }
  try {
    // eslint-disable-next-line import/no-unresolved
    return require('./native_c.node').add(left, right);
  } catch {
    return left + right;
  }
}

module.exports = { add };
