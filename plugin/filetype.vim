augroup checktex
	autocmd!
		au BufRead,BufNewFile *.tex		if &ft == 'plaintext' | set ft=tex
								       | endif
augroup END
