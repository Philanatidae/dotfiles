return {
    'nvimtools/hydra.nvim',
    enabled = true,
    lazy = true,
    keys = {
        { '<C-w>', desc = 'Window hydra' }
    },
    config = function()
        local Hydra = require("hydra")

        Hydra({
            name = "WINDOW",
            mode = "n",
            body = "<C-w>",
            config = {
                on_enter = function()
                    vim.api.nvim_exec_autocmds("User", { pattern = "HydraEnter", modeline = false, })
                end,
                on_exit = function()
                    vim.api.nvim_exec_autocmds("User", { pattern = "HydraExit", modeline = false, })
                end,
            },
            heads = {
                -- Arrow keys or hjkl to resize effortlessly
                { "=",     "5<C-w>>", { desc = "Increase width" } },
                { "-",     "5<C-w><", { desc = "Decrease width" } },
                { "_",     "3<C-w>-", { desc = "Decrease height" } },
                { "+",     "3<C-w>+", { desc = "Increase height" } },

                -- Quick equalization
                { "e",     "<C-w>=",  { desc = "Equalize" } },

                -- Exit keys
                { "q",     nil,       { exit = true, desc = "Exit Hydra" } },
                { "<Esc>", nil,       { exit = true, desc = "Exit Hydra" } },
            }
        })
    end,
}
