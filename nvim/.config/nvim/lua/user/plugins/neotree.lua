return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
        {
            "<leader>e",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
            end,
            desc = "Explorer NeoTree",
        },
        {
            "<leader>ce",
            function()
                require("neo-tree.command").execute({ source = "document_symbols", toggle = true })
            end,
            desc = "Symbol Explorer",
        },
        -- {
        --     "<leader>ge",
        --     function()
        --         require("neo-tree.command").execute({ source = "git_status", toggle = true })
        --     end,
        --     desc = "Git Explorer",
        -- },
        -- {
        --     "<leader>be",
        --     function()
        --         require("neo-tree.command").execute({ source = "buffers", toggle = true })
        --     end,
        --     desc = "Buffer Explorer",
        -- },
    },
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    opts = {
        sources = { "filesystem", "buffers", "git_status", "document_symbols" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
        filesystem = {
            bind_to_cwd = false,
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
            filtered_items = {
                always_show = {
                    ".gitignore",
                    ".config",
                },
                never_show = {
                    ".git",
                },
            },
        },
        window = {
            width = 30,
            mappings = {
                ["<space>"] = "none",
                ["Y"] = {
                    function(state)
                        local node = state.tree:get_node()
                        local path = node:get_id()
                        vim.fn.setreg("+", path, "c")
                    end,
                    desc = "copy path to clipboard",
                },
                ["Z"] = "expand_all_nodes",
            },
        },
        default_component_configs = {
            indent = {
                with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
        },
    },
}
