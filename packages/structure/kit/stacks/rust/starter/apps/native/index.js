'use strict';
// Placeholder tot `pnpm build` (napi) de native binding genereert.
// Nest/Node: laad de gebouwde addon achter een seam; zie docs/architecture/polyglot.md.
// NATIVE_STRICT=1: geen JS-fallback (CI / check-full).

function add(left, right) {
  if (process.env.NATIVE_STRICT === '1') {
    // eslint-disable-next-line import/no-unresolved -- gegenereerd door napi build
    return require('./native.node').add(left, right);
  }
  try {
    // eslint-disable-next-line import/no-unresolved -- gegenereerd door napi build
    return require('./native.node').add(left, right);
  } catch {
    return left + right;
  }
}

module.exports = { add };
