return {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    lazy = false,
    cond = not vim.g.vscode,
    build = ":TSUpdate",
    config = function()
        -- Dart parser seems to be slow at starting:
        -- https://github.com/nvim-treesitter/nvim-treesitter/issues/5868
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c", "cmake", "cpp", "csv", "gitignore", "glsl",
                "hlsl", "html", "ini", "javascript", "json",
                "json5", "lua", "luadoc", "markdown", "objc",
                "rust", "vim", "vimdoc", "dart",
            },
            sync_install = false, -- No need for sync installs
            auto_install = true,
            indent = {
                enable = true
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "markdown" },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                    },
                },
            },
        })
    end
}
