return {
    "nvim-telescope/telescope-file-browser.nvim",
    enabled = true,
    dependencies = { "nvim-telescope/telescope.nvim" },
    lazy = true,
    keys = {
        {
            "<leader>s",
            "<cmd>Telescope file_browser<cr>",
            "Search project files"
        },
    },
    config = function()
        local file_create = function(prompt_bufnr)
            -- Originally from https://github.com/nvim-telescope/telescope-file-browser.nvim/blob/e94f29d800f582f317bb25f986c2cf487c9dec7f/lua/telescope/_extensions/file_browser/actions.lua#L69
            local actions = require("telescope.actions")
            local selection = require("telescope.actions.state").get_selected_entry()
            local selected_path = selection.path
            local Path = require("plenary.path")
            local os_sep = Path.path.sep
            if vim.fn.isdirectory(selected_path) == 0 then
                selected_path = Path:new(selected_path):parent().filename
            end
            selected_path = selected_path .. os_sep
            vim.ui.input({ prompt = "Insert the file name:\n", default = selected_path }, function(file_path)
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

        require("telescope._extensions")._config.file_browser = {
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
                    ["<S-CR>"] = file_create,
                    ["c"] = file_create,
                    ["g"] = false,
                    ["e"] = false,
                    ["w"] = false,
                    ["t"] = false,
                },
            }
        }

        require("telescope").load_extension("file_browser")
    end,
}
