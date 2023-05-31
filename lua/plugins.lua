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
	use 'https://github.com/airblade/vim-gitgutter'

	use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

	use {
		'https://github.com/github/copilot.vim',
		keys = "<C-P>",
	}

	-- lsp
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'}, 
	
			-- Autocompletion
			{'hrsh7th/nvim-cmp'}, 
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-buffer'},       -- Optional

			-- Snippets
			{'L3MON4D3/LuaSnip'},
		},
	}

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Required for rust.vim
-- TODO: Convert to lua
vim.cmd([[filetype plugin indent on]])

return plugins
