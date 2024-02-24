local merge = vim.tbl_deep_extend
local whichmap = {}

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local which_key_setup = {
	plugins = {
		-- shows a list of your marks on ' and `
		marks = true,

		-- shows your registers on " in NORMAL or <C-r> in INSERT mode
		registers = true,

		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		spelling = {
	  		enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
	  		suggestions = 20, -- how many suggestions should be shown in the list?
		},

		presets = {
			operators = true, -- adds help for operators like d, y, ...
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},

	-- enable this to hide mappings for which you didn't specify a label
	ignore_missing = false,

	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	operators = { gc = "Comments" },

	-- override the label used to display some keys. It doesn't effect WK in any other way.
	key_labels = {
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},

	motions = {
		count = true,
	},

	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},

	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},

	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 5, 10, 5, 10 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
		padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
		zindex = 1000, -- positive value to position WhichKey above other floating windows.
	},

	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},

	-- hide mapping boilerplate
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " },

	-- show a help message in the command line for using WhichKey
	show_help = true,

	-- show the currently pressed key and its label as a message in the command line
	show_keys = true,

	-- automatically setup triggers with "auto" or specifiy a list manually
	triggers = "auto",
	-- triggers = { "<leader>", '"' }, 

	-- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
	triggers_nowait = {
		-- marks
		"`",
		"'",
		"g`",
		"g'",
		-- registers
		'"',
		"<c-r>",
		-- spelling
		"z=",
	},
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for keymaps that start with a native binding
		i = { "j", "k" },
		v = { "j", "k" },
	},
	-- disable the WhichKey popup for certain buf types and file types.
	-- Disabled by default for Telescope
	disable = {
		buftypes = {},
		filetypes = {},
	},
}

local which_key_opts = {
    mode = "n", -- NORMAL mode
    prefix = "",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

which_key.setup(which_key_setup);

-- whichmap.example = {
--   opts = {
--     name = 'Example',
--     prefix = '<leader>e',
--     mode = 'n',
--   },
--   bindings = {
--     e = { 'Just a label' }
--   }
-- }

-- Register complete groups of bindings
local register = function (group, pre, mode)
  local opts = { prefix = pre, mode = mode }
  which_key.register(group, merge("force", which_key_opts, opts))
end

-- Add single bindings to a group (work-in-progress)
local add = function (groupName, lsa, rsa)
  if whichmap[groupName] ~= nil then
    whichmap[groupName].bindings[lsa] = rsa
  end
end


local setup = function ()
  for _, v in pairs(whichmap) do
    register(v.bindings, v.opts.prefix, v.opts.mode)
  end
end

return {
  register = register,
  setup = setup,
}

