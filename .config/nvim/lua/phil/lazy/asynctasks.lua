return {
    "voldikss/vim-floaterm",
    dependencies = {
        "skywind3000/asynctasks.vim",
        "skywind3000/asyncrun.vim",
    },
    config = function()
        vim.keymap.set("n", "`", ":FloatermToggle<CR>")
        vim.keymap.set("t", "`", "<C-\\><C-n>:FloatermToggle<CR>")

        vim.keymap.set("n", "<leader>r", ":AsyncTask run<CR>")
        vim.keymap.set("n", "<leader>B", ":AsyncTask build<CR>")
    end
}
