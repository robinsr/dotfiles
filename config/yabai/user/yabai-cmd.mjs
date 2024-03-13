#!/usr/bin/env zx

import 'zx/globals';
import { Command, Argument, Option } from 'commander';

const logger = $.log;
$.log = () => {}
$.shell = '/bin/zsh';


const yabaiExec = async (q, json = false) => {
	const args = [ 
		'-m',
		...(Array.isArray(q) ? q : [q]),
	];

	const execd = await $`yabai ${args}`;

	if (execd.exitCode > 0) {
		throw Error(execd.stderr)
	}

	if (!json) {
		return execd.stdout;
	}
	
	try {
		return JSON.parse(execd.stdout)
	} catch (e) {
		console.error('JSON Parsing Error:', e);
		$`exit 1`
	}
}

const stub = (...args) => {
	console.log('STUB function; args:', ...args.toSpliced(-1))
}

const _mapAppToID = (yabaiApp) => yabaiApp.replaceAll(/[^\w]/g, '').toLowerCase();

const _getIgnoredApps = async () => {
	const rules = await yabaiExec(['rule', '--list'], true)

	if (!Array.isArray(rules) || !rules.length) {
		throw Error('No rules to show')
	}

	return rules.map(({ app, label, index }) => ({
		app, label, index, ID: _mapAppToID(app),
	}))
}

const listIgnoredAppsCmd = async (op, opts) => {
	console.log(await _getIgnoredApps());
}

const addIgnoredAppsCmd = async (app, { label }) => {
	const id = _mapAppToID(app);

	const args = [
		'rule',
		'--add',
		`app=${app}`,
		'manage=off',
		`label=${label ? label : id}`
	];

	try {
		await yabaiExec(args);
		console.log(`Added rule ${id} with args: ${args.join(' ')}`)
	} catch (e) {
		console.error('Error while adding rule', e)
	}
}

const removeIgnoredAppsCmd = async ({ id, index, label }) => {
	const rules = await _getIgnoredApps();

	const matchers = [
		(r) => !id || r.ID === id,
		(r) => !index || r.index === index,
		(r) => !label || !r.label || r.label === label,
	];

	let rule = rules.find(r => matchers.every(m => m(r)))

	console.log('Match params:', { id, index, label })
	console.log('Matched rule:', rule)

	if (!rule) {
		throw Error(`No rule found for input: ${JSON.stringify({ id, index, label })}`);
	}

	try {
		const args = [ 'rule', '--remove', rule.index ];
		//await yabaiExec(args);
		console.log(`Removed rule ${rule.ID} with args: ${args.join(' ')}`)
	} catch (e) {
		console.error('Error while adding rule', e)
	}

}


// ========= program ==========

const stringArg = (name, description, options) => {
	const { defaultVal, required = false } = options;

	const arg = new Argument(name, description);

	if (defaultVal) {
		arg.default(defaultVal, `Default for ${name}`);
	}

	if (required) {
		arg.argRequired();
	} else {
		arg.argOptional();
	}

	return arg;
}


const listArg = (name, description, options) => {
	return stringArg(name, description, options).choices(options.list);
}

const subCommand = (parent, { name, desc, handler, args = [], opts = [], isDefault = false }) => {
	const cmd = parent
		.command(name, { isDefault })
		.summary(desc);
	
	for (let arg of args) {
		cmd.addArgument(arg)
	}

	for (let [ name, desc ] of opts) {
		// console.log([name, desc])
		cmd.option(name, desc)
	}

	cmd.action(handler);

	return parent;
}

const isRequired = { required: true };

const program = new Command();

program
	.name('yabai-cmd')
	.description('Utility to help configure Yabai, a tiling window manager for macOS')
	.option('-l, --log', 'Emits more logging', (val, ...opts) => {
		$.log = log;
		return true;
	})
	.version('0.0.1');

const ignoreList = new Command('ignored')
	.description('Add, remove, and list apps whose windows are ignored by Yabai');

const labelOpt = [ '-b, --label <label>', 'Label identifying a rule' ];
const indexOpt = [ '-i, --id <id>', 'ID of rule' ];
const identOpt = [ '-n, --index <num>', 'Index of rule' ];

subCommand(ignoreList, {
	name: 'list',
	desc: 'List apps being ignored by Yabai',
	handler: listIgnoredAppsCmd,
	isDefault: true,
})
subCommand(ignoreList, {
	name: 'add <pattern>',
	desc: 'Add an app to be ignored by Yabai',
	handler: addIgnoredAppsCmd,
	opts: [ labelOpt ],
})
subCommand(ignoreList, {
	name: 'remove',
	desc: 'Remove an app from being ignored by Yabai',
	handler: removeIgnoredAppsCmd,
	opts: [ identOpt, indexOpt, labelOpt ],
})

program.addCommand(ignoreList)

try {
	console.log(chalk.blue('Args:'), process.argv.slice(3))
	const args = program.parse(process.argv.slice(3), { from: 'user' });
	console.log(args.args)
} catch (e) {
	console.error('arg parse threw error', e)
	$`exit 1`
}




