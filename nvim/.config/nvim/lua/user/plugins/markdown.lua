return {
  {
    "backdround/global-note.nvim",
    keys = {
      { "<leader>g", "<cmd>GlobalNote<cr>", desc = "Toggle Global Note" },
    },
    opts = {
      filename = "index.md",
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
  {
    "epwalsh/obsidian.nvim",
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
      mappings = {
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
      },
      disable_frontmatter = true,
    },
  },
}
