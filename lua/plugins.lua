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
		commit = '80cdb00b221f69348afc4fb4b701f51eb8dd3120', -- for neovim 0.5.0 compatibility
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

	-- UltiSnips
	use 'SirVer/ultisnips'
	use 'quangnguyen30192/cmp-nvim-ultisnips'


  if packer_bootstrap then
    require('packer').sync()
  end
end)

return plugins
