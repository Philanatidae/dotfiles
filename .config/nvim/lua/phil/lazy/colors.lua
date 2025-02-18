return {
    {
        "Philanatidae/night-owl.nvim",
        cond = not vim.g.vscode,
        priority = 1000,
        lazy = false,
        config = function()
            -- @todo Remove this hard-coded color change (lightline.lua also has a hard-coded value)
            require("night-owl").setup()
            vim.cmd("colorscheme night-owl")
        end
    }
}
