return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            filesystem = {
                filtered_items = {
                    visible = true,          -- Show hidden files
                    hide_dotfiles = false,   -- Do not hide dotfiles
                    hide_gitignored = false, -- Do not hide gitignored files
                },
                follow_current_file = true,
                use_libuv_file_watcher = true,
            },
            window = {
                position = "left",
                width = 30,
                mappings = {
                    ["<CR>"] = "open",
                    ["<C-x>"] = "open_split",
                    ["<C-v>"] = "open_vsplit",
                    ["<C-t>"] = "open_tabnew",
                    ["<"] = "prev_source",
                    [">"] = "next_source",
                },
            },
            default_component_configs = {
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "ﰊ",
                    default = "",
                },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                },
            },
            enable_git_status = true,
            enable_diagnostics = true,
        })

        vim.keymap.set('n', '<leader>n', '<cmd>Neotree reveal<CR>', { desc = "Reveal Neo-tree Filesystem" })
        vim.keymap.set('n', '<leader>g', '<cmd>Neotree git_status<CR>', { desc = "Open Neo-tree Git Status" })
    end
}

