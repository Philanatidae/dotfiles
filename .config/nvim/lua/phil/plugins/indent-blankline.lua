return {
    "lukas-reineke/indent-blankline.nvim",
    enabled = true,
    lazy = true,
    event = {
        'BufReadPost',
        'BufNewFile',
        'BufWritePre',
    },
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
        scope = {
            enabled = false,
        },
    },
}
