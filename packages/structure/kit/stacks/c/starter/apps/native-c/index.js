'use strict';
// Placeholder tot een echte N-API-addon gebouwd is (node-gyp / cmake-js).
// Nest: laad de .node achter een seam; zie docs/architecture/polyglot.md.
// NATIVE_STRICT=1: geen JS-fallback (CI / check-full).

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
