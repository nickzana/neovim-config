local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = false,
  manage_nvim_cmp = false,
  suggest_lsp_servers = false,
})

local keybindings = require('keybindings')
local on_attach = keybindings.on_attach
local cmp_mapping = keybindings.cmp_mappings

lsp.on_attach(on_attach)

local cmp = require('cmp')
local cmp_config = lsp.defaults.cmp_config({
	preselect = 'none',
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert(cmp_mappings),
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
})
cmp.setup(cmp_config)

-- Configure lua language server for neovim
lsp.nvim_workspace()

lsp.configure('rust_analyzer', {
	settings = {
		["rust-analyzer"] = {
			cargo = {
				features = "all",
			},
			procMacro = {
				enable = true,
			},
			checkOnSave = {
				command = 'clippy',
				extraArgs = { "--", "-W", "clippy::pedantic" }
			},
		},
	}
})

lsp.configure('tsserver', {
	cmd = { "npx", "typescript-language-server", "--stdio" },
})

lsp.configure('html', {
	cmd = { "npx", "vscode-html-language-server", "--stdio" },
})

lsp.setup_servers({'tsserver', 'rust_analyzer', 'html'})

lsp.setup()
