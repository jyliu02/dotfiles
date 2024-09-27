return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function()
        local gs = require("gitsigns")
        vim.keymap.set({ "n", "v" }, "<leader>gr", gs.reset_hunk, { buffer = 0 })
        vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { buffer = 0 })
        vim.keymap.set("n", "[h", function()
          gs.nav_hunk("prev")
        end, { buffer = 0 })
        vim.keymap.set("n", "]h", function()
          gs.nav_hunk("next")
        end, { buffer = 0 })
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
    config = function()
      vim.keymap.set("n", "<leader>G", "<cmd>Git<cr>")
    end,
  },
}
