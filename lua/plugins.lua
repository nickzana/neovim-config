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

	-- git
	use 'tpope/vim-fugitive'

	-- LSP
	use 'neovim/nvim-lspconfig' -- Common lsp server configurations
	use {
		'hrsh7th/nvim-cmp',
	} -- Autocompletion plugin
	use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp

	-- LSP Extensions
	use 'nvim-lua/lsp_extensions.nvim'

	-- Snippets (required for nvim-cmp)
	use 'L3MON4D3/LuaSnip'
	use {
		'saadparwaiz1/cmp_luasnip',
		commit = 'b10829736542e7cc9291e60bab134df1273165c9',
	}

	use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

	-- Language Specfic
	use 'rust-lang/rust.vim'
	use 'https://git.sr.ht/~sircmpwn/hare.vim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Required for rust.vim
-- TODO: Convert to lua
vim.cmd([[filetype plugin indent on]])

return plugins
