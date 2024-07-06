return {
  {
    "backdround/global-note.nvim",
    keys = {
      { "<leader>g", "<cmd>GlobalNote<cr>", desc = "Toggle Global Note" },
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
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
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

      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
        end

        local out = { aliases = note.aliases }
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,

      open_app_foreground = true,
    },
  },
}
