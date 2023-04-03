local map = vim.keymap.set

-- Avoid infinitely recursive definitions
options = { noremap = true }

-- Navigation
map('n', 'gh', '0', options) -- make gh go to beginning of line
map('n', 'gl', '$', options) -- make gl go to end of line
map('n', 'gk', 'gg', options) -- make gk go to top of document
map('n', 'gj', 'G', options) -- make gj go to bottom of document

-- WINDOW MANAGEMENT

-- Terminal
map('t', '<C-e>', '<C-\\><C-n>', options) -- Exit Terminal mode enter Normal

-- FILE NAVIGATION
map('n', '<leader>f', '<cmd>Telescope git_files<CR>', options)
map('n', '<leader>af', '<cmd>Telescope find_files<CR>', options)
-- Grep project file contents with live results, respecting .gitignore
map('n', '<leader>g',  "<cmd>lua require('telescope.builtin').live_grep()<CR>", options)
-- Telescope fuzzy search for buffers
map('n', '<leader>b', "<cmd>lua require('telescope.builtin').buffers()<CR>", options)

map('n', 'ga', '<C-^><CR>', options) -- ga to switch to last used buffer

-- CODE NAVIGATOIN

-- Quick Fix Lists
-- global -- using control
map('n', '<C-n>', '<cmd>cnext<CR>zz', options) -- Go to next item in global qfixlist
map('n', '<C-p>', '<cmd>cprev<CR>zz', options) -- Go to previous item in global qfixlist
-- Toggle the window if there are items in the qfixlist; allow recursive
map('n', 'Q', '<cmd>call ToggleQFList(1)<CR>', {}) -- see plugin/navigation.vim for ToggleQFList definition
-- local -- using leader
map('n', '<leader>j', '<cmd>lnext<CR>zz', options) -- Go to next item in local qfixlist
map('n', '<leader>k', '<cmd>lprev<CR>zz', options) -- Go to previous item in global qfixlist
-- Toggle the window if there are items in the qfixlist; allow recursive
map('n', '<leader>q', '<cmd>call ToggleQFList(0)<CR>', {}) -- see plugin/navigation.vim for ToggleQFList definition

-- GIT
-- top level commands
map('n', '<leader>gs', '<cmd>G<CR>', options) -- Show git status
map('n', '<leader>gc', '<cmd>G commit<CR>', options) -- git commit
map('n', '<leader>gp', '<cmd>G push<CR>', {}) -- git push

-- merge
map('n', '<leader>gh', '<cmd>diffget //2<CR>', options) -- merge from left pane
map('n', '<leader>gl', '<cmd>diffget //3<CR>', options) -- merge from right pane

-- LSP
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set('n', '<leader>k', function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set('n', '<leader>r', function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set('n', '<leader>a', function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
	vim.keymap.set('n', '<leader>d', function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set('n', '<leader>Q', function() vim.diagnostic.set_qflist() end, opts)
	vim.keymap.set('n', '<leader>F', function() vim.lsp.buf.format() end, opts)
end

local cmp_mappings = function ()
	local cmp = require('cmp')
	return {
		['<C-j>'] = cmp.mapping.scroll_docs(4),
		['<C-k>'] = cmp.mapping.scroll_docs(-4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
	}
end

return { on_attach = on_attach, cmp_mappings = cmp_mappings }
