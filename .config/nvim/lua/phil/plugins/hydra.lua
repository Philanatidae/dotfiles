return {
    'nvimtools/hydra.nvim',
    enabled = true,
    lazy = false,
    config = function()
        local Hydra = require("hydra")

        Hydra({
            name = "WINDOW",
            mode = "n",
            body = "<C-w>",
            config = {
                -- This ensures that if you press a key not in the "heads" list,
                -- it falls back to native Neovim behavior (or exits gracefully).
                fallback = true,
            },
            heads = {
                -- Arrow keys or hjkl to resize effortlessly
                { "=",     "5<C-w>>", { desc = "Decrease width" } },
                { "-",     "5<C-w><", { desc = "Increase width" } },
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
