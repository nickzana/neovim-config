-- Install packer
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

-- Check that packer is installed
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd [[packadd packer.nvim]]
vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
  augroup end
]], false)

local use = require('packer').use
local packer = require('packer')
packer.startup(function()
    use { 'wbthomason/packer.nvim', opt = true } -- Package manager

    -- visuals
    use 'gruvbox-community/gruvbox'

    -- file management
    use {
	    'nvim-telescope/telescope.nvim',
	    requires = {
		    {'nvim-lua/popup.nvim'},
		    {'nvim-lua/plenary.nvim'},
		    {'nvim-treesitter/nvim-treesitter'},
	    }
    }-- search and select tool
    use 'preservim/nerdtree'

    -- editing behaviour
    use 'jiangmiao/auto-pairs'
    use 'tpope/vim-commentary'  -- Easily comment/uncomment code
    use 'tpope/vim-surround'    -- surround text objects with delimiters

    -- git TODO: Learn how to use
    use 'airblade/vim-gitgutter'
    use 'tpope/vim-fugitive'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'nvim-lua/completion-nvim'

    -- Language specific
    use 'rust-lang/rust.vim'
end)

-- settings -- this is all of the basic vim settings
local o = vim.o  -- global
local g = vim.g  -- global 2?
local wo = vim.wo -- window local
local bo = vim.bo -- buffer local

-- basic UI
o.background = 'dark'
o.termguicolors = true -- enable 24 bit colors in TUI
vim.cmd('colorscheme gruvbox')
vim.cmd('syntax enable')
wo.number = true
wo.relativenumber = true
o.signcolumn = 'yes'
o.splitright = true
o.splitbelow = true

-- text
wo.wrap = false
wo.foldenable = false
o.mouse = 'a'

-- search
o.hlsearch = false
o.incsearch = true
o.ignorecase = true

-- temporary file configuration
o.swapfile = false
o.undofile = true
bo.undofile = true
o.dir = '/tmp'
o.hidden = true -- do not save when switching buffers

-- LSP
o.updatetime = 250
o.completeopt = 'menuone,noinsert,noselect'
o.inccommand = 'nosplit'

-- keybindings
local map = vim.api.nvim_set_keymap
g.mapleader = ' '
-- window navigation
map('n', '<C-j>', '<C-W>j', {noremap = true})
map('n', '<C-k>', '<C-W>k', {noremap = true})
map('n', '<C-l>', '<C-W>l', {noremap = true})
map('n', '<C-h>', '<C-W>h', {noremap = true})
-- terminal
map('t', '<C-e>', '<C-\\><C-n>', {noremap = true})
-- NERDTree
map('n', '<leader>nt', '<cmd>NERDTreeToggle<CR>', {noremap = true})
-- Telescope
map('n', '<C-p>', '<cmd>Telescope git_files<cr>', {noremap = true})

-- LSP TODO: make lua instead of vimscript
--
-- Use completion-nvim in every buffer
vim.api.nvim_exec([[
	autocmd BufEnter * lua require'completion'.on_attach()
]], false)

-- Avoid showing message extra message when using completion
--

-- Use <Tab> and <S-Tab> to navigate through popup menu
vim.api.nvim_exec([[
	inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
	inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
]], false)

-- use <Tab> as trigger keys
vim.api.nvim_exec([[
	imap <Tab> <Plug>(completion_smart_tab)
	imap <S-Tab> <Plug>(completion_smart_s_tab)
]], false)

-- code shortcuts
local opts = { noremap=true, silent=true }
map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
map('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
map('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
map('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

-- autocommands

-- Highlight on yank
vim.cmd('au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'  )-- disabled in visual mode

-- Trim Whitespace
vim.api.nvim_exec([[
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
augroup AUTOCOMMANDGROUP
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
]], false)

-- language server configs
-- LSP settings
local nvim_lsp = require('lspconfig')
local on_attach = function(_client, bufnr)
  require'completion'.on_attach(_client)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

-- Rust
vim.cmd([[let g:rustfmt_autosave = 1]])
nvim_lsp['rust_analyzer'].setup {
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true
			},
			checkOnSave = {
				command = "clippy",
				extraArgs = "["--", "-W", "clippy::pedantic"]"
			}
		}
	}
}

-- Python
require'lspconfig'.jedi_language_server.setup{}

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

-- Show diagnostic popup on cursor hold
vim.cmd([[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]])

-- Enable type inlay hints
vim.cmd([[autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }]])

