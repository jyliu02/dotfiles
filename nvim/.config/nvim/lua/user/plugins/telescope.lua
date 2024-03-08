return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "nvim-telescope/telescope-ui-select.nvim" },
    },
    cmd = { "Telescope" },
    -- stylua: ignore
    keys = {
        { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep", silent = true },
        { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader><Space>", "<cmd>Telescope<cr>", desc = "Telescope" },

        { "<leader>ff", function()
            if vim.loop.fs_stat(vim.loop.cwd() .. "/.git") then
                require("telescope.builtin").git_files { show_untracked = true }
            else
                require("telescope.builtin").find_files { hidden = false }
            end
        end, desc = "Find Files", silent = true },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files", silent = true },
        { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers", silent = true },

        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help", silent = true },
        { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics", silent = true },
        { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics", silent = true },
        { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols", silent = true },
        { "<leader>sS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols", silent = true },
    },
    opts = function()
        local actions = require("telescope.actions")

        return {
            defaults = {
                mappings = {
                    i = {
                        ["<C-p>"] = actions.move_selection_previous, -- move up
                        ["<C-n>"] = actions.move_selection_next, -- move down
                        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                    },
                },
            },
            ["ui-select"] = {
                require("telescope.themes").get_dropdown({}),
            },
        }
    end,
    config = function(_, opts)
        require("telescope").setup(opts)
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("ui-select")
    end,
}
