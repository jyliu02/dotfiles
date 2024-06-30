return {
  {
    "backdround/global-note.nvim",
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
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = { "markdown" },
    keys = {
      { "<leader>v", ft = "markdown", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
    },
  },
}
