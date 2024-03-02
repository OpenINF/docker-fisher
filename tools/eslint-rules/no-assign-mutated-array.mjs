/**
 **Derivative work of `no-assign-mutated-array.ts` by Nicholas Jamieson.
 * @file Ban direct assignment of arrays mutated by impure array mehods.
 * @author Derek Lewis <dereklewis@inf.is>
 * @license MIT
 * Use of this source code is governed by an MIT-style license that can be
 * found in the LICENSE file at https://github.com/cartant/eslint-plugin-etc.
 * @see https://github.com/cartant/eslint-plugin-etc/blob/master/source/rules/no-assign-mutated-array.ts
 */

//------------------------------------------------------------------------------
// Requirements
//------------------------------------------------------------------------------

import * as tsutils from 'tsutils';
import { default as ts } from 'typescript';

const mutatorRegExp = /^(fill|reverse|sort|splice)$/;
const creatorRegExp = /^(concat|entries|filter|keys|map|slice|values)$/;

//------------------------------------------------------------------------------
// Typedefs
//------------------------------------------------------------------------------

/**
 * @typedef {Object} es
 * @property {Object} Node Something!
 * @property {Object} MemberExpression Something!
 */
const es = {};
es.Node = {};
es.MemberExpression = {};

/** @typedef {import('eslint').Rule} Rule */
const Rule = {};
Rule.RuleContext = {};
Rule.RuleModule = {};

//------------------------------------------------------------------------------
// Helpers
//------------------------------------------------------------------------------

/**
 * @param {ts.Type} type
 * @return {boolean}
 */
function isUnionType(type) {
  return tsutils.isTypeFlagSet(type, ts.TypeFlags.Union);
}

/**
 * @param {ts.Type} type
 * @param {string | RegExp} name
 * @param {{name: RegExp, typeChecker: ts.TypeChecker}=} qualified
 * @return {boolean}
 */
function isType(type, name, qualified = undefined) {
  if (!type.symbol) {
    return false;
  }
  if (
    qualified &&
    !qualified.name.test(
      qualified.typeChecker.getFullyQualifiedName(type.symbol)
    )
  ) {
    return false;
  }
  if (typeof name === 'string') {
    return type.symbol.name === name;
  } else {
    return Boolean(type.symbol.name.match(name));
  }
}

/**
 * @param {ts.Type} type
 * @return {boolean}
 */
function isReferenceType(type) {
  return (
    tsutils.isTypeFlagSet(type, ts.TypeFlags.Object) &&
    tsutils.isObjectFlagSet(type, ts.ObjectFlags.Reference)
  );
}

/**
 * @param {ts.Type} type
 * @return {boolean}
 */
function isIntersectionType(type) {
  return tsutils.isTypeFlagSet(type, ts.TypeFlags.Intersection);
}

/**
 * @param {ts.Type} type
 * @param {string | RegExp} name
 * @param {{name: RegExp, typeChecker: ts.TypeChecker}=} qualified
 * @return {boolean}
 */
function couldBeType(type, name, qualified = undefined) {
  if (isReferenceType(type)) {
    type = type.target;
  }

  if (isType(type, name, qualified)) {
    return true;
  }

  if (isIntersectionType(type) || isUnionType(type)) {
    return type.types.some((t) => couldBeType(t, name, qualified));
  }

  const baseTypes = type.getBaseTypes();
  if (!baseTypes) {
    return false;
  }
  return baseTypes.some((t) => couldBeType(t, name, qualified));
}

/**
 * @param {es.Node} node
 * @return {es.Node | undefined}
 */
function getParent(node) {
  return node.parent;
}

/**
 * @param {Rule.RuleContext} context
 * @return {{
 *     esTreeNodeToTSNodeMap: Map<es.Node, ts.Node>,
 *     program: ts.Program
 * }}
 */
function getParserServices(context) {
  if (
    !context.parserServices ||
    !context.parserServices.program ||
    !context.parserServices.esTreeNodeToTSNodeMap
  ) {
    throw new Error(
      'This rule requires `@typescript-eslint/parser` and specifying a' +
        '`project` in `parserOptions`.'
    );
  }

  return context.parserServices;
}

/**
 * @param {es.Node} node
 * @return {boolean}
 */
function isExpressionStatement(node) {
  return node && node.type === 'ExpressionStatement';
}

//------------------------------------------------------------------------------
// Rule Definition
//------------------------------------------------------------------------------

/** @type {Rule.RuleModule} */
const rule = {
  meta: {
    docs: {
      category: 'General',
      description: 'Forbids the assignment of returned, mutated arrays.',
      recommended: false,
    },
    fixable: null,
    messages: {
      forbidden: 'Assignment of mutated arrays is forbidden.',
    },
  },
  create: (context) => {
    const { esTreeNodeToTSNodeMap, program } = getParserServices(context);
    const typeChecker = program.getTypeChecker();

    /**
     * @param {ts.CallExpression} callExpression
     * @return {boolean}
     */
    function mutatesReferencedArray(callExpression) {
      if (ts.isPropertyAccessExpression(callExpression.expression)) {
        const propertyAccessExpression = callExpression.expression;
        const { expression, name } = propertyAccessExpression;
        if (creatorRegExp.test(name.getText())) {
          return false;
        }
        if (ts.isCallExpression(expression)) {
          return mutatesReferencedArray(expression);
        }
        if (ts.isArrayLiteralExpression(expression)) {
          return false;
        }
      }
      return true;
    }

    //--------------------------------------------------------------------------
    // Public API
    //--------------------------------------------------------------------------

    return {
      [`CallExpression > MemberExpression[property.name=${mutatorRegExp}]`]: (
        /** @type {es.MemberExpression} */ memberExpression
      ) => {
        const callExpression = getParent(memberExpression);
        const parent = getParent(callExpression);
        if (!isExpressionStatement(parent)) {
          const propertyAccessExpression = esTreeNodeToTSNodeMap.get(
            memberExpression
          );
          const type = typeChecker.getTypeAtLocation(
            propertyAccessExpression.expression
          );
          if (
            couldBeType(type, 'Array') &&
            mutatesReferencedArray(esTreeNodeToTSNodeMap.get(callExpression))
          ) {
            context.report({
              messageId: 'forbidden',
              node: memberExpression.property,
            });
          }
        }
      },
    };
  },
};

export default rule;
