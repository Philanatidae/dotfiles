return {
    "mason-org/mason.nvim",
    enabled = true,
    lazy = false,
    cond = not vim.g.vscode,
    config = function()
        require("mason").setup({})
    end
}
