local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local plugins = require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'gruvbox-community/gruvbox'

	-- file management
    use {
	    'nvim-telescope/telescope.nvim', -- search and select tool
	    requires = { {'nvim-lua/plenary.nvim'} }
    }
	use 'preservim/nerdtree'

	-- git
	use 'tpope/vim-fugitive'

	-- LSP
	use 'neovim/nvim-lspconfig' -- Common lsp server configurations
	use 'tjdevries/lsp_extensions.nvim' -- Provides type inlay hint support
	use 'hrsh7th/cmp-nvim-lsp'	-- Completion LSP integeration
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'		-- Autocompletion

	-- Snippets (Required for nvim-cmp)
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'

	-- Language Specfic
	use 'rust-lang/rust.vim'
	use 'cespare/vim-toml'
	use 'stephpy/vim-yaml'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Required for rust.vim
-- TODO: Convert to lua
vim.cmd([[filetype plugin indent on]])

return plugins
