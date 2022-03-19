local on_attach = require'keybindings'.on_attach
local capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
local cmp = require'nvim-cmp-cfg'.cmp

-- SERVERS
-- rust_analyzer
vim.g.rustfmt_autosave = 1
require'lspconfig'.rust_analyzer.setup{
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
