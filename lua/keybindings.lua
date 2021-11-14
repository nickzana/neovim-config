local map = vim.api.nvim_set_keymap

-- Avoid infinitely recursive definitions
options = { noremap = true }

-- Copy/paste
map('n', '<leader>y', '"+y', options)
map('v', '<leader>y', '"+y', options)

-- WINDOW MANAGEMENT

-- Navigate windows
map('n', '<C-h>', '<C-w>h', options)
map('n', '<C-j>', '<C-w>j', options)
map('n', '<C-k>', '<C-w>k', options)
map('n', '<C-l>', '<C-w>l', options)

-- Move windows TODO

-- Terminal
map('t', '<C-e>', '<C-\\><C-n>', options) -- Exit Terminal mode enter Normal

-- FILE NAVIGATION
map('n', '<C-p>', '<cmd>Telescope git_files<CR>', options)
map('n', '<C-f>', '<cmd>Telescope find_files<CR>', options)
-- Grep for prompted str project wide
map('n', '<leader>ps',  "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep For > \")})<CR>", options)
-- Telescope fuzzy search for buffers
map('n', '<leader>pb', "<cmd>lua require('telescope.builtin').buffers()<CR>", options)

-- CODE NAVIGATOIN

-- Quick Fix Lists
-- global -- using control
map('n', 'J', '<cmd>cnext<CR>zz', options) -- Go to next item in global qfixlist
map('n', 'K', '<cmd>cprev<CR>zz', options) -- Go to previous item in global qfixlist
-- Toggle the window if there are items in the qfixlist; allow recursive
map('n', 'Q', '<cmd>call ToggleQFList(1)<CR>', {}) -- see plugin/navigation.vim for ToggleQFList definition
-- local -- using leader
map('n', '<leader>j', '<cmd>lnext<CR>zz', options) -- Go to next item in local qfixlist
map('n', '<leader>k', '<cmd>lprev<CR>zz', options) -- Go to previous item in global qfixlist
-- Toggle the window if there are items in the qfixlist; allow recursive
map('n', '<leader>q', '<cmd>call ToggleQFList(0)<CR>', {}) -- see plugin/navigation.vim for ToggleQFList definition

-- git
map('n', '<leader>gs', '<cmd>G<CR>', options)

-- LSP
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }


	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', options)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.hover()<CR>', options)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', options)
	buf_set_keymap('n', 's', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options)
	buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', options)
	buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true })
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', options)
	buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', options)
	-- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', options)
	-- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diaoNostic.goto_next()<CR>', options)
	buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.set_qflist()<CR>', options)
	buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', options)

end

-- Code actions
map('n', '<leader>t', '<cmd>CargoTest<CR>', options) -- Run test under cursor

return { on_attach = on_attach }
