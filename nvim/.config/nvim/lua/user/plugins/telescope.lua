return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-ui-select.nvim" },
  },
  keys = function()
    local builtin = require("telescope.builtin")

    return {
      { "<leader><leader>", builtin.builtin },
      { "<leader>/", builtin.current_buffer_fuzzy_find },
      { "<leader>fg", builtin.live_grep },
      {
        "<leader>ff",
        function()
          if vim.uv.fs_stat(vim.uv.cwd() .. "/.git") then
            builtin.git_files({ show_untracked = true })
          else
            builtin.find_files({ hidden = true })
          end
        end,
      },
      { "<leader>fr", builtin.oldfiles },
      { "<leader>fb", builtin.buffers },
      { "<leader>fh", builtin.help_tags },
      { "<leader>fs", builtin.lsp_document_symbols },
    }
  end,
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      pickers = {
        live_grep = {
          file_ignore_patterns = { ".git" },
          additional_args = { "--hidden" },
        },
        find_files = {
          file_ignore_patterns = { ".git" },
          hidden = true,
        },
      },
      extensions = {
        fzf = {},
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    })
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
  end,
}
