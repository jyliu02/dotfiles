return {
    {
        "backdround/global-note.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>n", "<cmd>GlobalNote<cr>", desc = "Toggle Global Note" },
        },
        opts = {
            directory = "~/Documents/Notes/",
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
}
