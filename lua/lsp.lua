local on_attach = require'keybindings'.on_attach
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- SERVERS
-- rust_analyzer
vim.g.rustfmt_autosave = 1
lspconfig.rust_analyzer.setup{
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			procMacro = {
				enable = true,
			},
			checkOnSave = {
				command = 'clippy',
				extraArgs = { "--", "-W", "clippy::pedantic" }
			},
		}
	}
}

lspconfig.gopls.setup {
	on_attach = on_attach,
	capabilities=capabilities,
}

-- clangd
lspconfig.clangd.setup{
	on_attach = on_attach,
	capabilities = capabilities,
}
