return {
  {
    "backdround/global-note.nvim",
    keys = {
      { "<leader>w", "<cmd>GlobalNote<cr>" },
    },
    opts = {
      filename = "homepage.md",
      directory = vim.fn.expand("~") .. "/Documents/Notes",
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
    opts = {
      workspaces = {
        {
          name = "Notes",
          path = "~/Documents/Notes",
        },
      },
      mappings = {
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
        ["<leader>v"] = {
          action = function()
            vim.cmd("ObsidianOpen")
          end,
        },
      },
      disable_frontmatter = true,
    },
  },
}
