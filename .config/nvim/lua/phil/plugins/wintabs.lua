return {
    "zefei/vim-wintabs",
    enabled = true,
    lazy = false,
    cond = not vim.g.vscode,
    priority = 99,
    dependencies = {
        "zefei/vim-wintabs-powerline",
    },
    config = function()
        vim.g.wintabs_display =
        "statusline"                             -- Put wintabs on the status line, move statusline to the tabline (WinTabs is already configured for this)
        --vim.g.wintabs_ignored_filetypes = ["gitcommit", "vundle", "qf", "vimfiler"]
        vim.cmd('WintabsRefresh')

        vim.keymap.set("n", "<leader>]", "<cmd>WintabsNext<CR>")
        vim.keymap.set("n", "<leader>[", "<cmd>WintabsPrevious<CR>")

        vim.keymap.set("n", "<leader>q", "<cmd>WintabsClose<CR>")
        vim.keymap.set("n", "<leader>Q", "<cmd>WintabsCloseWindow<CR>")

        vim.keymap.set("n", "<leader><C-l>", function()
            vim.cmd("vnew")
            vim.cmd("wincmd h")
            vim.cmd("WintabsMoveToWindow l")
        end)
        vim.keymap.set("n", "<leader><C-j>", function()
            vim.cmd("new")
            vim.cmd("wincmd k")
            vim.cmd("WintabsMoveToWindow j")
        end)

        vim.keymap.set("n", "<leader>L", "<cmd>WintabsMoveToWindow l<CR>")
        vim.keymap.set("n", "<leader>H", "<cmd>WintabsMoveToWindow h<CR>")
        vim.keymap.set("n", "<leader>K", "<cmd>WintabsMoveToWindow k<CR>")
        vim.keymap.set("n", "<leader>J", "<cmd>WintabsMoveToWindow j<CR>")

        vim.cmd([[
                function! UpdateStatusLine()
                    if exists('g:lightline')
                        call lightline#update()
                        execute 'WintabsRefresh'
                    else
lua <<EOF
                        local lualine = require('lualine')
                        if lualine then
                            lualine.refresh()
                        end
EOF
                    endif
                endfunction

                " Update status line once per second, for updating the clock if there is no
                " user interation
                function! UpdateStatusLinePeriodically(timer)
                    call UpdateStatusLine()
                endfunction

                " @todo Only needed for clock, but we could move the clock to tmux?
                " Set the timer to call the UpdateStatusLine function once per second
                let g:statusline_update_timer = timer_start(1000, 'UpdateStatusLinePeriodically', {'repeat': -1})

                " Extra updates that are stubborn
                augroup VisualEvent
                    autocmd!
                    autocmd ModeChanged *:[vV\x16]* call UpdateStatusLine()
                    autocmd Modechanged [vV\x16]*:* call UpdateStatusLine()
                augroup END
            ]])
    end
}
