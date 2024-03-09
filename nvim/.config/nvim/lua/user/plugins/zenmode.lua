return {
    "Pocco81/true-zen.nvim",
    cmd = { "TZMinimalist" },
    keys = {
        { "<leader>z", "<cmd>TZMinimalist<cr>", desc = "Zen Mode", silent = true },
        { "<C-w>z", "<cmd>TZFocus<cr>", desc = "Zoom Window", silent = true },
    },
    opts = {
        -- NOTE: Tmux integration isn't working.
        modes = {
            minimalist = {
                options = {
                    number = true,
                    relativenumber = true,
                    signcolumn = "yes:1",
                },
            },
        },
    },
}
