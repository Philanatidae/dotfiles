return {
    "folke/todo-comments.nvim",
    enabled = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
    keys = {
        { "<leader>St", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    }
}
