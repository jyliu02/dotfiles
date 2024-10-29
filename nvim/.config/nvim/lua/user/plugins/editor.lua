return {
  { "tpope/vim-sleuth" },
  { "nvim-tree/nvim-web-devicons" },
  {
    "echasnovski/mini.nvim",
    config = function()
      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require("mini.surround").setup()
      -- Auto-pairs
      -- require("mini.pairs").setup()
    end,
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>" },
    },
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    keys = {
      { "<leader>S", "<cmd>Spectre<cr>" },
    },
    opts = {},
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
