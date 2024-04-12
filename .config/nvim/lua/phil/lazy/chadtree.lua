return {
    "ms-jpq/chadtree",
    branch = "chad",
    cond = not vim.g.vscode,
    build = "python3 -m chadtree deps",
    config = function()
        vim.g.chadtree_settings = {
            view = {
                window_options = {
                    number = true,
                    relativenumber = true
                }
            }
        }

        vim.keymap.set("n", "<C-t>", ":CHADopen<CR>")
    end
}
