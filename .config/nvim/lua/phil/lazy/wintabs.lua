return {
    {
        "zefei/vim-wintabs",
        cond = not vim.g.vscode,
        dependencies = {
            "zefei/vim-wintabs-powerline",
            "itchyny/lightline.vim",
        },
        config = function()
            vim.g.wintabs_display =
            "statusline"                         -- Put wintabs on the status line, move lightline to the tabline (WinTabs is already configured for this)
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
                function! UpdateLightline()
                    call lightline#update()
                    execute 'WintabsRefresh'
                endfunction

                " Update lightline once per second, for updating the clock if there is no
                " user interation
                function! UpdateLightlinePeriodically(timer)
                    call UpdateLightline()
                endfunction

                " Set the timer to call the UpdateLightline function once per second
                let g:lightline_update_timer = timer_start(1000, 'UpdateLightlinePeriodically', {'repeat': -1})

                " Extra updates that are stubborn
                augroup VisualEvent
                    autocmd!
                    autocmd ModeChanged *:[vV\x16]* call UpdateLightline()
                    autocmd Modechanged [vV\x16]*:* call UpdateLightline()
                augroup END
            ]])
        end
    }
}
