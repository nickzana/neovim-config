-- Highlight on yank
vim.cmd('au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'  )-- disabled in visual mode
