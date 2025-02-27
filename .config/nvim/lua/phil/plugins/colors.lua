return {
    "Philanatidae/night-owl.nvim",
    lazy = false,
    cond = not vim.g.vscode,
    priority = 1000,
    config = function()
        -- @todo Remove this hard-coded color change (lightline.lua also has a hard-coded value)
        require("night-owl").setup()
        vim.cmd("colorscheme night-owl")
    end
}
