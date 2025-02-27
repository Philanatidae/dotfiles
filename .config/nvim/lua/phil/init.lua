require("phil.set")
require("phil.remap")
require("phil.filetypes")

require("phil.lazy")


local PhilGroup = vim.api.nvim_create_augroup("Phil", {})

-- Why is this not in lsp.lua?
vim.api.nvim_create_autocmd("LspAttach", {
    group = PhilGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)

        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        -- @todo Rebind these, <leader>l is used for quick window switch
        -- vim.keymap.set("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end, opts)
        -- vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, opts)
        -- vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)
        -- vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.references() end, opts)

        vim.keymap.set("n", "<leader>o", ":ClangdSwitchSourceHeader<CR>", opts)
    end
})
