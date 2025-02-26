return {
    "dstein64/vim-startuptime",
    lazy = true,
    cmd = "StartupTime",
    init = function()
        vim.g.startuptime_tries = 10
    end,
}
