local on_attach = require'keybindings'.on_attach
local capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
local cmp = require'nvim-cmp-cfg'.cmp

-- texlab with tectonic
require'lspconfig'.texlab.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "texlab" },
	filetypes = { "tex", "bib" },
	settings = {
		texlab = {
			auxDirectory = ".",
			bibtexFormatter = "texlab",
			build = {
				executable = 'tectonic',
				args = { "%f", "--synctex", "--keep-logs", "--keep-intermediates" },
				onSave = true,
				forwardSearchAfter = true,
			},
			forwardSearch = {
				executable = "zathura",
				-- Per https://github.com/latex-lsp/texlab/blob/master/docs/previewing.md
				args = {"--synctex-forward", "%l:1:%f", "%p"},
			},
			chktex = {
				onOpenAndSave = true,
				onEdit = true,
			},
		}
	},
	single_file_support = true
}
