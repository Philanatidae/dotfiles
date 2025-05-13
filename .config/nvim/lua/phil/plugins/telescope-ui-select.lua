return {
    "nvim-telescope/telescope-ui-select.nvim",
    enabled = true,
    dependencies = { "nvim-telescope/telescope.nvim" },
    lazy = false,
    event = "User TelescopeLoaded",
    config = function()
        require("telescope").load_extension("ui-select")
    end,
}
