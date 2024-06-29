return {
    {
        "backdround/global-note.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>g", "<cmd>GlobalNote<cr>", desc = "Toggle Global Note" },
        },
        opts = {
            filename = "inbox.md",
            directory = vim.fn.expand("~") .. "/Documents/Notes",
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        -- stylua: ignore
        keys = {
            { "<leader>v", ft = "markdown", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
        },
        config = function()
            vim.cmd([[do FileType]])
        end,
    },
    -- {
    --     "epwalsh/obsidian.nvim",
    --     event = {
    --         "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Notes/**.md",
    --         "BufNewFile " .. vim.fn.expand("~") .. "/Documents/Notes/**.md",
    --     },
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --     },
    --     opts = {
    --         workspaces = {
    --             {
    --                 name = "Notes",
    --                 path = "~/Documents/Notes",
    --             },
    --         },
    --         completion = {
    --             nvim_cmp = true,
    --             min_chars = 1,
    --         },
    --         -- stylua: ignore
    --         mappings = {
    --             ["gf"] = {
    --                 action = function() return require("obsidian").util.gf_passthrough() end,
    --                 opts = { noremap = false, expr = true, buffer = true },
    --             },
    --             ["<leader><cr>"] = {
    --                 action = function() return require("obsidian").util.toggle_checkbox() end,
    --                 opts = { buffer = true },
    --             },
    --             ["<leader>ff"] = {
    --                 action = function() return vim.cmd("ObsidianQuickSwitch") end,
    --                 opts = { buffer = true },
    --             },
    --         },
    --         disable_frontmatter = true,
    --     },
    -- },
}
