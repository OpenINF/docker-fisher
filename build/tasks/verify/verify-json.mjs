import { exec } from 'node:child_process/promises';

import { echoTaskRunning } from '../util.mjs';

echoTaskRunning('verify-json', import.meta.url);

const JSONObject =
  await $`bundle exec github-linguist --breakdown --json | jq '.JSON.files'`;
const JSONFiles = JSON.parse(JSONObject.stdout);

let exitCode = 0;
const scripts = [`dprint check ${JSONFiles.join(' ')}`];

for await (const element of scripts) {
  try {
    exitCode = await exec(`pnpm exec ${element}`);
  } catch (p) {
    exitCode = p.exitCode;
  }
  process.exitCode = exitCode > 0 ? exitCode : 0;
}
