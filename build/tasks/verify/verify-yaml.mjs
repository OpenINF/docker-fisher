import { createRequire } from 'node:module';
const require = createRequire(import.meta.url);
const util = require('node:util');
const exec = util.promisify(require('node:child_process').exec);

import { echoTaskRunning } from '../util.mjs';

echoTaskRunning('verify-yaml', import.meta.url);

const YAMLObject =
  await $`bundle exec github-linguist --breakdown --json | jq '.YAML.files'`;
const YAMLFiles = JSON.parse(YAMLObject.stdout);

let exitCode = 0;
const scripts = [
  `eslint ${YAMLFiles.join(' ')}`, // validate & style-check
];

for await (const element of scripts) {
  try {
    exitCode = await exec(`pnpm exec ${element}`);
  } catch (p) {
    exitCode = p.exitCode;
  }
  process.exitCode = exitCode > 0 ? exitCode : 0;
}

// eslint-disable-next-line unicorn/no-process-exit
process.exit(exitCode);
