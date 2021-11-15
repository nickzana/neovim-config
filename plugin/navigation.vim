" SOURCE:
" https://github.com/ThePrimeagen/.dotfiles/blob/1e300671439e156cb2f86452bed2ea9a7c6d64ad/nvim/.config/nvim/plugin/navigation.vim
" Function to toggle QuickFix List (Both Local and Global)
" No built in function for doing so
let g:the_qf_l = 0
let g:the_qf_g = 0

fun! ToggleQFList(global)
    if a:global
        if g:the_qf_g == 1
            let g:the_qf_g = 0
            cclose
        else
            let g:the_qf_g = 1
            copen
        end
    else
        if g:the_qf_l == 1
            let g:the_qf_l = 0
            lclose
        else
            let g:the_qf_l = 1
            lopen
        end
    endif
endfun
