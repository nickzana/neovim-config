-- Highlight on yank
vim.cmd('au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'  )-- disabled in visual mode

-- Trim Whitespace
vim.api.nvim_exec([[
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
augroup AUTOCOMMANDGROUP
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
	autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END
]], false)
