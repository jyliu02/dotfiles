return {
  { "tpope/vim-sleuth" },
  {
    "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
  },
  {
    "echasnovski/mini.nvim",
    config = function()
      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require("mini.surround").setup()
    end,
  },
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "UndoTree", silent = true },
    },
    init = function()
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
  {
    "alexghergh/nvim-tmux-navigation",
    event = "VeryLazy",
    config = function()
      local nav = require("nvim-tmux-navigation")

      nav.setup({
        disable_when_zoomed = true,
      })

      vim.keymap.set({ "n", "v" }, "<C-h>", nav.NvimTmuxNavigateLeft)
      vim.keymap.set({ "n", "v" }, "<C-j>", nav.NvimTmuxNavigateDown)
      vim.keymap.set({ "n", "v" }, "<C-k>", nav.NvimTmuxNavigateUp)
      vim.keymap.set({ "n", "v" }, "<C-l>", nav.NvimTmuxNavigateRight)
    end,
  },
}
