// -----------------------------------------------------------------------------
// Requirements
// -----------------------------------------------------------------------------

import { createRequire } from 'module';
import {
  dirname as pathDirname,
  extname as pathExtname,
  join as pathJoin,
} from 'path';
import { fileURLToPath as pathFromFileUrl } from 'url';
import { readdirSync } from 'fs';
import noAssignMutatedArray from './no-assign-mutated-array.mjs';

const __filename = pathFromFileUrl(import.meta.url);
const __dirname = pathDirname(__filename);
const require = createRequire(import.meta.url);

// -----------------------------------------------------------------------------
// Main
// -----------------------------------------------------------------------------

const rules = { 'no-assign-mutated-array': noAssignMutatedArray };
const ruleFiles = readdirSync(__dirname).filter(
  (ruleFile) =>
    ![
      'index.js',
      'index.mjs',
      '.gitignore',
      'node_modules',
      'rules-utils.js',
      'html-template.js',
      'no-assign-mutated-array.mjs',
      'no-log-array.js',
      'no-mixed-interpolation.js',
      'documented-errors.js',
    ].includes(ruleFile)
);

ruleFiles.forEach(function (ruleFile) {
  const rule = ruleFile.replace(pathExtname(ruleFile), '');
  rules[rule] = require(pathJoin(__dirname, rule));
});

export default { rules };
