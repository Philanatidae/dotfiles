-- Need "let g:np_plugin_maps=1"

vim.opt.backup = false      -- No backup before overwriting file
vim.opt.writebackup = false -- ^^^
vim.opt.updatetime = 750    -- 750ms after no input before writing swap file
vim.opt.confirm = true      -- Prompt to save buffer if unsaved
vim.opt.exrc = true

-- Indent w/ 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.autoindent = true

-- Enable mouse
vim.opt.mouse = "a"

--vim.opt.clipboard = "unnamedplus" -- Use global clipboard

vim.opt.cursorline = true  -- Highlight line cursor is on
vim.opt.signcolumn = "yes" -- Column on left for breakpoints, etc.
vim.opt.number = true      -- Enable line numbers

-- Auto switch between relative and normal
local numbertoggle_augroup = vim.api.nvim_create_augroup("numbertoggle", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
    pattern = "*",
    group = numbertoggle_augroup,
    command = "if &nu && mode() != 'i' | set rnu   | endif",
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
    pattern = "*",
    group = numbertoggle_augroup,
    command = "if &nu | set nornu | endif",
})

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.diagnostic.config({
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    }
})
