return {
    "zbirenbaum/copilot.lua",
    enabled = true,
    lazy = true,
    cond = not vim.g.vscode,
    cmd = "Copilot",
    keys = {
        { "<C-c>",     mode = { "i", "s" }, desc = "Copilot" },
        { "<C-c><CR>", mode = { "i", "s" }, desc = "Copilot Accept" },
        { "<C-c>n",    mode = { "i", "s" }, desc = "Copilot Next" },
        { "<C-c>p",    mode = { "i", "s" }, desc = "Copilot Prev" },
        { "<C-c>q",    mode = { "i", "s" }, desc = "Copilot Dismiss" },
        { "<leader>gc", command = "Copilot panel", desc = "Copilot Panel" },
    },
    config = function()
        require("copilot").setup({
            panel = {
                enabled = true,
                auto_refresh = false,
                keymap = {
                    jump_prev = "[[",
                    jump_next = "]]",
                    accept = "<CR>",
                    refresh = "r",
                    open = false,
                },
                layout = {
                    position = "bottom",
                    ratio = 0.4,
                },
            },
            suggestion = {
                enabled = true,
                auto_trigger = false,
                hide_during_completion = true,
                debounce = 75,
                trigger_on_accept = true,
                keymap = {
                    accept = "<C-c><CR>",
                    accept_word = "<C-c>w",
                    accept_line = "<C-c>l",
                    next = "<C-c>n",
                    prev = "<C-c>p",
                    dismiss = "<C-c>q",
                },
            },
            filetypes = {
                yaml = false,
                markdown = false,
                help = false,
                gitcommit = false,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
                ["."] = false,
            },
            logger = {
                file = vim.fn.stdpath("log") .. "/copilot-lua.log",
                file_log_level = vim.log.levels.OFF,
                print_log_level = vim.log.levels.WARN,
                trace_lsp = "off",
                trace_lsp_progress = false,
                log_lsp_messages = false,
            },
            copilot_model = "",
        })
    end
}
