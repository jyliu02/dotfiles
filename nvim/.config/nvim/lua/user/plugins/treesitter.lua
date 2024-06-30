return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      local treesitter = require("nvim-treesitter.configs")
      treesitter.setup({
        ensure_installed = {
          "vimdoc",
          "javascript",
          "typescript",
          "regex",
          "bash",
          "markdown",
          "markdown_inline",
          "c",
          "lua",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false, -- catppuccin requires this
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            node_incremental = "=",
            node_decremental = "-",
          },
        },
        textobjects = {
          enable = true,
          select = {
            enable = true,
            lookahead = true,
            keymaps = { ["am"] = "@function.outer", ["im"] = "@function.inner" },
          },
        },
      })
    end,
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "<leader>cz", "<cmd>TSJToggle<cr>" },
    },
    opts = {
      use_default_keymaps = false,
    },
  },
}
