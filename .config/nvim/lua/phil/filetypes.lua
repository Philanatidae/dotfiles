vim.cmd([[
    autocmd BufRead,BufNewFile *.hm set filetype=objc
    autocmd BufRead,BufNewFile *.m set filetype=objc
    autocmd BufRead,BufNewFile *.hmm set filetype=objcpp
    autocmd BufRead,BufNewFile *.mm set filetype=objcpp

    autocmd BufRead,BufNewFile *.vert set filetype=glsl
    autocmd BufRead,BufNewFile *.frag set filetype=glsl
]])
