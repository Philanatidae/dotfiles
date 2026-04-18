return {
    "folke/todo-comments.nvim",
    enabled = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
    keys = {
        { "<leader>St", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    },
    opts = {}
}
