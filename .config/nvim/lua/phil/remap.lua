vim.g.mapleader = " "

if (vim.g.vscode) then
    local vscode = function(cmd)
        require("vscode-neovim").call(cmd)
    end

    vim.keymap.set("n", "<leader>w", function()
        vscode("workbench.action.files.save")
    end)
    vim.keymap.set("n", "<leader>W", function()
        vscode("workbench.action.files.saveAll")
    end)
    vim.keymap.set("n", "<leader><C-q>", function()
        vscode("workbench.action.closeAllEditors")
    end)

    -- These don't work correctly (specifically, =, which
    -- has something else bound do it =?, I've got no idea
    -- what). This works in neovim proper, but not in vscode.
    -- Oh well, screw that for now.
    --
    -- Also need to add count arg
    -- vim.keymap.set("n", "=", function()
    --     vscode("workbench.action.increaseViewWidth")
    -- end)
    -- vim.keymap.set("n", "-", function()
    --     vscode("workbench.action.decreaseViewWidth")
    -- end)
    -- vim.keymap.set("n", "+", function()
    --     vscode("workbench.action.increaseViewHeight")
    -- end)
    -- vim.keymap.set("n", "_", function()
    --     vscode("workbench.action.decreaseViewHeight")
    -- end)

    vim.keymap.set("n", "<leader>l", ":<C-u>exe ':wincmd ' . v:count1 . 'l'<CR>")
    vim.keymap.set("n", "<leader>k", ":<C-u>exe ':wincmd ' . v:count1 . 'k'<CR>")
    vim.keymap.set("n", "<leader>j", ":<C-u>exe ':wincmd ' . v:count1 . 'j'<CR>")
    vim.keymap.set("n", "<leader>h", ":<C-u>exe ':wincmd ' . v:count1 . 'h'<CR>")
else
    vim.keymap.set("n", "<leader>w", "<cmd>update<CR>")
    vim.keymap.set("n", "<leader>W", "<cmd>bufdo update<CR>")
    vim.keymap.set("n", "<leader><C-q>", function()
        vim.cmd("qa")
    end)

    vim.keymap.set("n", "=", ":<C-u>exe 'vertical resize +' . v:count1<CR>")
    vim.keymap.set("n", "-", ":<C-u>exe 'vertical resize -' . v:count1<CR>")
    vim.keymap.set("n", "+", ":<C-u>exe 'resize +' . v:count1<CR>")
    vim.keymap.set("n", "_", ":<C-u>exe 'resize -' . v:count1<CR>")

    vim.keymap.set("n", "<leader>l", ":<C-u>exe ':wincmd ' . v:count1 . 'l'<CR>")
    vim.keymap.set("n", "<leader>k", ":<C-u>exe ':wincmd ' . v:count1 . 'k'<CR>")
    vim.keymap.set("n", "<leader>j", ":<C-u>exe ':wincmd ' . v:count1 . 'j'<CR>")
    vim.keymap.set("n", "<leader>h", ":<C-u>exe ':wincmd ' . v:count1 . 'h'<CR>")

    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float() end)

    vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
    vim.keymap.set("v", "J", ":m '<-2<CR>gv=gv")

    vim.keymap.set("n", "J", "mzJ`z")

    vim.keymap.set("n", "<C-d>", "<C-d>zz")
    vim.keymap.set("n", "<C-u>", "<C-u>zz")
    vim.keymap.set("n", "n", "nzzzv")
    vim.keymap.set("n", "N", "Nzzzv")
end

vim.keymap.set("n", "U", function()
    vim.cmd("redo")
end)
