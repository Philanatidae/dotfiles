return {
    "windwp/nvim-autopairs",
    enabled = true,
    lazy = true,
    event = { "InsertEnter" },
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
        },
        -- Set default options
        default_format_opts = {
            lsp_format = "fallback",
        },
        -- Set up format-on-save
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
        -- Customize formatters
        formatters = {
            shfmt = {
                prepend_args = { "-i", "4" },
            },
        },
    },
}
