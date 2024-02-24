local wk = require('user.which-key')
local keys = require('user.keys')
local builtin = require('telescope.builtin')

local wkGroup = {}

keys.nmapkey(wkGroup, "Telescope - find files", '<leader>ff', ':Telescope find_files<cr>')
keys.nmapkey(wkGroup, "Telescope - live grep", '<leader>fg', ':Telescope live_grep<cr>')
keys.nmapkey(wkGroup, "Telescope - list current buffers", '<leader>fb', ':Telescope buffers<cr>')
keys.nmapkey(wkGroup, "Telescope - help tags", '<leader>fh', ':Telescope help_tags<cr>')
keys.nmapkey(wkGroup, "Telescope - search current buffer", '<leader>fc', ':Telescope current_buffer_fuzzy_find<cr>')

keys.nmapkey(wkGroup, "Telescope - planets", "<leader>pp", builtin.planets)

wk.register(wkGroup, '', 'n')


