return {
    {
        "backdround/global-note.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>g", "<cmd>GlobalNote<cr>", desc = "Toggle Global Note" },
        },
        opts = {
            directory = vim.fn.expand("~") .. "/Documents/Notes",
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        keys = {
            { "<leader>v", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Markdown Preview" },
        },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        event = {
            "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Notes/**.md",
            "BufNewFile " .. vim.fn.expand("~") .. "/Documents/Notes/**.md",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        init = function()
            vim.o.conceallevel = 2
        end,
        opts = {
            workspaces = {
                {
                    name = "Notes",
                    path = "~/Documents/Notes",
                },
            },
            completion = {
                nvim_cmp = true,
                min_chars = 1,
            },
            mappings = {
                ["gf"] = {
                    action = function()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true },
                },
                ["<leader><cr>"] = {
                    action = function()
                        return require("obsidian").util.toggle_checkbox()
                    end,
                    opts = { buffer = true },
                },
                ["<leader>ff"] = {
                    action = function()
                        return vim.cmd("ObsidianQuickSwitch")
                    end,
                    opts = { buffer = true },
                },
            },
            disable_frontmatter = true,
            follow_url_func = function(url)
                -- Open the URL in the default web browser.
                vim.fn.jobstart({ "open", url }) -- Mac OS
                -- vim.fn.jobstart({"xdg-open", url})  -- linux
            end,
        },
    },
}
