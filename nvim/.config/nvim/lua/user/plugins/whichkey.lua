return {
    "folke/which-key.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
        defaults = {
            mode = { "n", "v" },
            ["gs"] = { name = "+surround" },
            ["<leader>b"] = { name = "+buffers" },
            ["<leader>c"] = { name = "+code" },
            ["<leader>f"] = { name = "+file/find" },
            ["<leader>g"] = { name = "+git" },
            ["<leader>s"] = { name = "+search" },
            ["<leader>v"] = { name = "+view" },
        },
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        wk.register(opts.defaults)
    end,
}
