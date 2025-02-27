return {
    "ms-jpq/chadtree",
    lazy = true,
    branch = "chad",
    cond = not vim.g.vscode,
    build = "python3 -m chadtree deps",
    cmd = "CHADopen",
    keys = {
        { "<C-t>", "<cmd>CHADopen<CR>", "CHADtree open" },
    },
    init = function()
        vim.g.chadtree_settings = {
            view = {
                window_options = {
                    number = true,
                    relativenumber = true
                }
            }
        }
    end
}
