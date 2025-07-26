return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    enabled = true,
    lazy = false, -- Neotree lazy loads itself apparently
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    cond = not vim.g.vscode,
    cmd = "Neotree",
    keys = {
        { "<C-t>",      "<cmd>Neotree toggle<CR>", "Neotree open" },
        { "<leader>t",  "<cmd>Neotree reveal<CR>", "Neotree reveal" },
    },
    config = true,
    opts = {
        event_handlers = {
            {
                event = "neo_tree_buffer_enter",
                handler = function(arg)
                    vim.cmd([[
                    setlocal number
                  setlocal relativenumber
            ]])
                end,
            },
        },
    },
}
