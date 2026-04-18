return {
    "zefei/vim-wintabs",
    enabled = true,
    lazy = false,
    dependencies = {
        "zefei/vim-wintabs",
    },
    config = function()
        local lualine = require('lualine')
        if lualine then
            function _G.wintabs_statusline()
                return lualine.statusline(lualine.get_config().sections, true)
            end

            vim.g.wintabs_statusline = '%!v:lua.wintabs_statusline()'
        end

        vim.g.wintabs_display =
        "statusline" -- Put wintabs on the status line, move statusline to the tabline (WinTabs is already configured for this)
        --vim.g.wintabs_ignored_filetypes = ["gitcommit", "vundle", "qf", "vimfiler"]
        vim.cmd('WintabsRefresh')

        vim.keymap.set("n", "<leader>]", "<cmd>WintabsNext<CR>", { desc = "Switch to next window tab" })
        vim.keymap.set("n", "<leader>[", "<cmd>WintabsPrevious<CR>", { desc = "Switch to previous window tab" })

        vim.keymap.set("n", "<leader>q", "<cmd>WintabsClose<CR>", { desc = "Close window tab" })
        vim.keymap.set("n", "<leader>Q", "<cmd>WintabsCloseWindow<CR>", { desc = "Close window" })

        vim.keymap.set('n', '<leader>O', '<cmd>WintabsOnly<CR>', { desc = "Close all tabs except the active tab" })

        vim.keymap.set("n", "<leader><C-l>", function()
            vim.cmd("silent vnew | wincmd p | WintabsMoveToWindow l")
        end, { desc = "Move tab to new window on the right" })
        vim.keymap.set("n", "<leader><C-h>", function()
            vim.cmd("silent leftabove vnew | wincmd p | WintabsMoveToWindow h")
        end, { desc = "Move tab to new window on the left" })
        vim.keymap.set("n", "<leader><C-k>", function()
            vim.cmd("silent leftabove new | wincmd p | WintabsMoveToWindow k")
        end, { desc = "Move tab to new window on the top" })
        vim.keymap.set("n", "<leader><C-j>", function()
            vim.cmd("silent new | wincmd p | WintabsMoveToWindow j")
        end, { desc = "Move tab to new window on the bottom" })

        vim.keymap.set("n", "<leader>L", "<cmd>WintabsMoveToWindow l<CR>",
            { desc = "Move tab to the window to the right" })
        vim.keymap.set("n", "<leader>H", "<cmd>WintabsMoveToWindow h<CR>",
            { desc = "Move tab to the window to the left" })
        vim.keymap.set("n", "<leader>K", "<cmd>WintabsMoveToWindow k<CR>", { desc = "Move tab to the window above" })
        vim.keymap.set("n", "<leader>J", "<cmd>WintabsMoveToWindow j<CR>", { desc = "Move tab to the window below" })

        vim.cmd([[
                function! UpdateStatusLine()
lua <<EOF
                    local lualine = require('lualine')
                    if lualine then
                        lualine.refresh()
                    end
EOF
                    execute 'WintabsRefresh'
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
                augroup WintabsModeChangeEvent
                    autocmd!
                    autocmd ModeChanged *:* call UpdateStatusLine()
                augroup END
            ]])
    end
}
