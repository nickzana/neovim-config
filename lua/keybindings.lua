local map = vim.api.nvim_set_keymap

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
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }


	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', options)
	buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>', options)
	buf_set_keymap('n', '<leader>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options)
	buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', options)
	buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true })
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', options)
	buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', options)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', options)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', options)
	buf_set_keymap('n', '<leader>Q', '<cmd>lua vim.diagnostic.set_qflist()<CR>', options)
	buf_set_keymap('n', '<leader>F', '<cmd>lua vim.lsp.buf.formatting()<CR>', options)

end

-- Code actions
-- TODO: Generalize to LSP or only attach on Rust buffers
map('n', '<leader>t', '<cmd>RustTest<CR>', options) -- Run test under cursor

return { on_attach = on_attach }
