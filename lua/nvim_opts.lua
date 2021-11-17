local o = vim.o  -- global
local g = vim.g  -- global 2?
local wo = vim.wo -- window local
local bo = vim.bo -- buffer local

g.mapleader = ' '

-- basic UI
o.background = 'dark'
o.termguicolors = true -- enable 24 bit colors in TUI
vim.cmd 'colorscheme gruvbox'
g.syntax = true
wo.number = true
wo.relativenumber = true
o.signcolumn = 'yes'
o.splitright = true
o.splitbelow = true
o.colorcolumn = '80'

-- text
wo.wrap = false
wo.foldenable = false
o.mouse = 'a' -- enable mouse in all modes
o.tabstop = 4 -- Display width of a <Tab>
o.softtabstop = 4 -- How large inserted tabs are
o.expandtab = false -- Insert <Tab> instead of spaces
o.shiftwidth = 4 -- "Number of spaces used for each step of an (auto)indent"
o.scrolloff = 8 -- Start scrolling when 8 away from top/bottom

-- Set diagnostic updatetime
vim.o.updatetime = 300

-- search
o.hlsearch = false
o.incsearch = true -- Incremental highlighting while typing a search query
o.ignorecase = true
o.smartcase = true -- Match case if a capital letter is used

-- temporary file configuration
o.swapfile = false
o.undofile = true
o.dir = '/tmp'

-- Buffers
o.hidden = true -- Allow hidden buffers without saving
