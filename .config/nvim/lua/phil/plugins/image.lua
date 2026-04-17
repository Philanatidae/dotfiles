return {
    "3rd/image.nvim",
    lazy = true,
    optional = true,
    config = function()
        if vim.fn.executable("magick") == 0 then
           vim.notify("image.nvim: ImageMagick not found. Please install it to enable image previews.", vim.log.levels.ERROR)
            return
        end

        require("image").setup({})
    end
}

