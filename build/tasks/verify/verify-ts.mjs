import { createRequire } from 'node:module';
const require = createRequire(import.meta.url);
const util = require('node:util');
const exec = util.promisify(require('node:child_process').exec);

import { echoTaskRunning } from '../util.mjs';

echoTaskRunning('verify-ts', import.meta.url);

const TypeScriptObject =
  await $`bundle exec github-linguist --breakdown --json | jq '.TypeScript.files'`;
const TypeScriptFiles = JSON.parse(TypeScriptObject.stdout);

let exitCode = 0;
const scripts = [
  `eslint ${TypeScriptFiles.join(' ')}`, // validate & style-check
];

for await (const element of scripts) {
  try {
    exitCode = await exec(`pnpm exec ${element}`);
  } catch (p) {
    exitCode = p.exitCode;
  }
  process.exitCode = exitCode > 0 ? exitCode : 0;
}
