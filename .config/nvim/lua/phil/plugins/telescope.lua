return {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = true,
    cond = not vim.g.vscode,
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    cmd = "Telescope",
    keys = {
        {
            "<leader>s",
            "<cmd>Telescope file_browser<cr>",
            "Search project files"
        },
        {
            "<leader>SS",
            "<cmd>Telescope live_grep<cr>",
            "Search content in files"
        },
        {
            "<leader>Sh",
            "<cmd>Telescope help_tags<cr>",
            "Search help tags"
        },
        {
            "<leader>Sc",
            "<cmd>Telescope commands<cr>",
            "Search commands"
        },
        {
            "<leader>Sk",
            "<cmd>Telescope keymaps<cr>",
            "Search keymaps"
        },
    },
    config = function()
        local file_create = function(prompt_bufnr)
            local actions = require("telescope.actions")
            local selection = require("telescope.actions.state").get_selected_entry()
            -- From https://github.com/nvim-telescope/telescope-file-browser.nvim/blob/e94f29d800f582f317bb25f986c2cf487c9dec7f/lua/telescope/_extensions/file_browser/actions.lua#L69
            local Path = require("plenary.path")
            local os_sep = Path.path.sep
            local default = selection.path .. os_sep
            vim.ui.input({ prompt = "Insert the file name:\n", default = default }, function(file_path)
                if not file_path then
                    return
                end
                if file_path == "" then
                    print("Please enter a valid filename!")
                    return
                end
                if file_path == default then
                    print("Please enter valid file or folder name!")
                    return
                end

                local file = Path:new(file_path)
                if file:exists() then
                    error("File or folder already exists.")
                    return
                end
                local fb_utils = require "telescope._extensions.file_browser.utils"
                if not fb_utils.is_dir(file.filename) then
                    file:touch({ parents = true })
                else
                    Path:new(file.filename:sub(1, -2)):mkdir({ parents = true })
                end

                actions.close(prompt_bufnr)

                vim.cmd.edit(vim.fn.fnameescape(file_path))
            end)
        end

        require("telescope").setup({
            extensions = {
                file_browser = {
                    -- theme = "ivy"
                    depth = false,
                    create_from_prompt = false,
                    hide_parent_dir = true,
                    display_stat = false,
                    mappings = {
                        ["i"] = {
                            ["<S-CR>"] = file_create,
                            ["<C-g>"] = false,
                            ["<C-e>"] = false,
                            ["<C-w>"] = false,
                            ["<C-t>"] = false,
                            ["<bs>"] = false,
                            ["/"] = false,
                        },
                        ["n"] = {
                            ["c"] = file_create,
                            ["g"] = false,
                            ["e"] = false,
                            ["w"] = false,
                            ["t"] = false,
                        },
                    }
                }
            }
        })

        require("telescope").load_extension("fzf")
        require("telescope").load_extension("file_browser")
    end
}
