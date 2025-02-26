return {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    cond = not vim.g.vscode,
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    keys = {
        {
            "<leader>s",
            function()
                require("telescope.builtin").find_files()
            end,
            "Search project files"
        },
        {
            "<leader>Ss",
            function()
                local builtin = require("telescope.builtin")
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end,
            "Search content in files"
        },
        {
            "<leader>Sh",
            function()
                require("telescope.builtin").help_tags()
            end,
            "Search help tags"
        },
    },
}
