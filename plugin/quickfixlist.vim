let g:qf_l = 0
let g:qf_g = 0

fun! ToggleQFList(global)
    if a:global
        if g:qf_g == 1
            let g:qf_g = 0
            cclose
        else
            let g:qf_g = 1
            copen
        end
    else
        if g:qf_l == 1
            let g:qf_l = 0
            lclose
        else
            let g:qf_l = 1
            lopen
        end
    endif
endfun
