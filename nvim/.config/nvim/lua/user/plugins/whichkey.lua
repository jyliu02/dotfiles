return {
    "folke/which-key.nvim",
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
        },
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        wk.register(opts.defaults)
    end,
}
