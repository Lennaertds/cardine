'use strict';
const { describe, it } = require('node:test');
const assert = require('node:assert/strict');
const { add } = require('../index.js');

describe('native add (napi starter)', () => {
  it('adds two numbers', () => {
    assert.equal(add(2, 3), 5);
  });
});
