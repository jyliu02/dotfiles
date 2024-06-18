return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "nvim-telescope/telescope-ui-select.nvim" },
    },
    cmd = { "Telescope" },
    keys = {
        { "<leader><Space>", "<cmd>Telescope<cr>", desc = "Telescope" },
        { "<leader>;", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader>:", "<cmd>Telescope commands<cr>", desc = "Commands" },
        -- FIXME: Live grep doesn't show hidden files
        { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
        {
            "<leader>ff",
            function()
                local telescope = require("telescope.builtin")
                if vim.uv.fs_stat(vim.uv.cwd() .. "/.git") then
                    telescope.git_files({ show_untracked = true })
                else
                    telescope.find_files({ hidden = true })
                end
            end,
            desc = "Find Files",
        },
        {
            "<leader>fr",
            "<cmd>Telescope oldfiles<cr>",
            desc = "Recent Files",
        },
        {
            "<leader>fb",
            "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
            desc = "Buffers",
        },
        {
            "<leader>fh",
            "<cmd>Telescope help_tags<cr>",
            desc = "Help",
        },
        {
            "<leader>sd",
            "<cmd>Telescope diagnostics bufnr=0<cr>",
            desc = "Document Diagnostics",
        },
        {
            "<leader>sD",
            "<cmd>Telescope diagnostics<cr>",
            desc = "Workspace Diagnostics",
        },
        {
            "<leader>ss",
            "<cmd>Telescope lsp_document_symbols<cr>",
            desc = "Document Symbols",
        },
        {
            "<leader>sS",
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            desc = "Workspace Symbols",
        },
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
