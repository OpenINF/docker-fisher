import { createRequire } from 'node:module';
const require = createRequire(import.meta.url);
const util = require('node:util');
const exec = util.promisify(require('node:child_process').exec);

import { echoTaskRunning } from '../util.mjs';

echoTaskRunning('verify-toml', import.meta.url);

const TOMLObject =
  await $`bundle exec github-linguist --breakdown --json | jq '.TOML.files'`;
const TOMLFiles = JSON.parse(TOMLObject.stdout);

let exitCode = 0;
const scripts = [
  `dprint check ${TOMLFiles.join(' ')}`, // validate & style-check
];

for await (const element of scripts) {
  try {
    exitCode = await exec(`pnpm exec ${element}`);
  } catch (p) {
    exitCode = p.exitCode;
  }
  process.exitCode = exitCode > 0 ? exitCode : 0;
}
