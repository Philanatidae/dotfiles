return {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    cmd = "Telescope",
    keys = {
        {
            "<leader>SS",
            "<cmd>Telescope live_grep<cr>",
            "Search content in files"
        },
        {
            "<leader>Sh",
            "<cmd>Telescope help_tags<cr>",
            "Search help tags"
        },
        {
            "<leader>Sc",
            "<cmd>Telescope commands<cr>",
            "Search commands"
        },
        {
            "<leader>Sk",
            "<cmd>Telescope keymaps<cr>",
            "Search keymaps"
        },
    },
    config = function()
        require("telescope").setup({})
        vim.api.nvim_exec_autocmds("User", { pattern = "TelescopeLoaded" })
    end
}
