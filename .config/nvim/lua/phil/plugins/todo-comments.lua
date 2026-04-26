return {
    'folke/todo-comments.nvim',
    enabled = true,
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    keys = {
        {
            '<leader>St',
            '<cmd>TodoTelescope<cr>',
            desc = 'Todo'
        },
    },
    config = function()
        local default_keywords = {
            FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, },
            TODO = { icon = " ", color = "info" },
            HACK = { icon = " ", color = "warning" },
            WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
            PERF = { icon = "󰓅 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = "󰎛 ", color = "hint", alt = { "INFO" } },
            TEST = { icon = "󰙨 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        }

        local custom_keywords = {}

        -- Add lowercase versions of each keyword
        custom_keywords = vim.tbl_deep_extend("force", {}, default_keywords, custom_keywords)
        for key, val in pairs(custom_keywords) do
            custom_keywords[key:lower()] = val
        end

        require("todo-comments").setup({
            keywords = custom_keywords,
            highlight = {
                -- pattern = [[(.*\@*<(KEYWORDS)]],
                pattern = [[(\@<(KEYWORDS))]],
            },
            search = {
                pattern = [[@\b(KEYWORDS)]],
            }
        })
    end
}
