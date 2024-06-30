return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function()
        local gs = require("gitsigns")

        vim.keymap.set("n", "]h", gs.next_hunk)
        vim.keymap.set("n", "[h", gs.prev_hunk)
        vim.keymap.set({ "n", "v" }, "<leader>gs", gs.stage_hunk)
        vim.keymap.set({ "n", "v" }, "<leader>gr", gs.reset_hunk)
        vim.keymap.set("n", "<leader>gp", gs.preview_hunk)
        vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk)
        vim.keymap.set("n", "<leader>gS", gs.stage_buffer)
        vim.keymap.set("n", "<leader>gR", gs.reset_buffer)
        vim.keymap.set("n", "<leader>gU", gs.reset_buffer_index)
      end,
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
    },
    cmd = { "Neogit" },
    keys = {
      {
        "<leader>G",
        function()
          require("neogit").open({ kind = "split" })
        end,
        desc = "Neogit",
        silent = true,
      },
    },
    config = true,
  },
}
