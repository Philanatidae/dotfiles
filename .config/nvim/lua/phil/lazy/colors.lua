return {
    {
        "bignimbus/pop-punk.vim",
        cond = not vim.g.vscode,
        priority = 1000,
        lazy = false,
        config = function()
            -- @todo Remove this hard-coded color change (lightline.lua also has a hard-coded value)
            vim.cmd("colorscheme pop-punk")
        end
    }
}
