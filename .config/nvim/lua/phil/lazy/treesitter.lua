return {
    "nvim-treesitter/nvim-treesitter",
    cond = not vim.g.vscode,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c", "cmake", "cpp", "csv", "gitignore", "glsl",
                "hlsl", "html", "ini", "javascript", "json",
                "json5", "lua", "luadoc", "markdown", "objc",
                "rust", "vim", "vimdoc",
            },
            sync_install = false, -- No need for async installs
            auto_install = true,
            indent = {
                enable = true
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "markdown" },
            }
        })
    end
}
