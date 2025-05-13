return {
    "nvim-telescope/telescope-fzf-native.nvim",
    enabled = true,
    build = "make",
    dependencies = { "nvim-telescope/telescope.nvim" },
    lazy = true,
    event = "User TelescopeLoaded",
    config = function()
        require("telescope").load_extension("fzf")
    end,
}
