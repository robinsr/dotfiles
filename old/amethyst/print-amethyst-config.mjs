#!/usr/bin/env node

import { exec } from 'node:child_process';
import { promisify } from 'node:util';
import ansi from '/opt/homebrew/lib/node_modules/ansi-colors/index.js';
import table from '/opt/homebrew/lib/node_modules/as-table/as-table.js';

const { unstyle, blue, red } = ansi;

const pexec = promisify(exec);

const ohas = (o, p) => Object.hasOwn(o, p);

const flag = str => process.argv.includes(str);

const bail = msg => {
  console.error(msg);
  process.exit(1);
}

const envHas = async (cmd) => {
  const { r, err } = await pexec(`echo "$+commands[${cmd}]"`);

  if (err) {
    return bail(err)
  }

  return r == "1"
}

if (!envHas('jq')) {
  bail("'jq' not found on system");
}

const { stdout, stderr } = await pexec('yq -oj . amethyst.yml');

if (stderr) {
  bail(stderr);
}

try {
  const config = JSON.parse(stdout);

  const mod1 = config['mod1'];
  const mod2 = config['mod2'];

  if (!mod1 || !mod2) {
    throw Error('Modifiers not defined:', `mod1: ${mod1}, mod2: ${mod2}`)
  }

  const mods = { mod1, mod2 }

  let keys = Object.entries(config)
    .filter(([k, v]) => ohas(v, 'key') && ohas(v, 'mod') && ohas(mods, v.mod)) 
    .map(([k, v]) => [ 
      k, red([ ...mods[v.mod], blue.bold(v.key) ].join(' '))
    ])

  let lines = [];

  lines = keys;

  if (flag('--key')) {
    lines = keys.map(([k, v]) => [v, k]); 
  }

  // lines = lines.map(([ k, v ]) => ([ unstyle(k), v ])) 

  console.log(table(lines))
} catch (e) {
  bail(e);
}


