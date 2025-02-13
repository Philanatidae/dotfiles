return {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    cmd = "Telescope",
    keys = function()
        local telescope = require('telescope.builtin')

        local function smart_diagnostics(buf_only)
            local opts = {}
            if buf_only then
                opts.bufnr = 0
            end

            local diagnostics = vim.diagnostic.get(opts.bufnr)

            local has_errors = false
            for _, d in ipairs(diagnostics) do
                if d.severity == vim.diagnostic.severity.ERROR then
                    has_errors = true
                    break
                end
            end

            if has_errors then
                opts.severity = vim.diagnostic.severity.ERROR
            else
                opts.severity_limit = 3
            end

            opts.wrap_results = true
            telescope.diagnostics(opts)
        end
        return {
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
            {
                "<leader>Sd",
                function() smart_diagnostics(true) end,
                "Search LSP diagnostics"
            },
            {
                "<leader>SD",
                function() smart_diagnostics(false) end,
                "Search LSP diagnostics"
            },
        }
    end,
    config = function()
        require("telescope").setup({})
        vim.api.nvim_exec_autocmds("User", { pattern = "TelescopeLoaded" })
    end
}
