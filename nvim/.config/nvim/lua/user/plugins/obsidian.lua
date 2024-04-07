return {
    "epwalsh/obsidian.nvim",
    version = "*",
    event = {
        "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Vault/**.md",
        "BufNewFile " .. vim.fn.expand("~") .. "/Documents/Vault/**.md",
    },
    cmd = { "ObsidianNew", "ObsidianQuickSwitch", "ObsidianToday" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    init = function()
        vim.o.conceallevel = 1
    end,
    opts = {
        workspaces = {
            {
                name = "Vault",
                path = "~/Documents/Vault",
            },
        },
        daily_notes = {
            folder = "Daily",
        },
        templates = {
            subdir = "Templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
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
        },
    },
}
