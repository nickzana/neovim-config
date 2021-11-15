local on_attach = require'keybindings'.on_attach
local capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
local cmp = require'nvim-cmp-cfg'.cmp
