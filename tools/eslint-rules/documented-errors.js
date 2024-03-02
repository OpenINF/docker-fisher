const fs = require('fs');
const path = require('path');
const { isDefiningError } = require('./rules-utils.js');

const doc = fs.readFileSync(
  path.resolve(__dirname, '../../docs/api/errors.md'),
  'utf8'
);

/**
 * @param code
 */
function isInDoc(code) {
  return doc.includes(`### \`${code}\``);
}

/**
 * @param code
 */
function includesAnchor(code) {
  return doc.includes(`<a id="${code}"></a>`);
}

/**
 * @param node
 */
function errorForNode(node) {
  return node.expression.arguments[0].value;
}

module.exports = {
  create: function (context) {
    return {
      ExpressionStatement: function (node) {
        if (!isDefiningError(node) || !errorForNode(node)) {
          return;
        }
        const code = errorForNode(node);
        if (!isInDoc(code)) {
          const message = `"${code}" is not documented in docs/api/errors.md`;
          context.report({ node, message });
        }
        if (!includesAnchor(code)) {
          const message = `docs/api/errors.md does not have an anchor for "${code}"`;
          context.report({ node, message });
        }
      },
    };
  },
};
