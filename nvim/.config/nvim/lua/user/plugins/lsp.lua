return {
  {
    "williamboman/mason-lspconfig",
    event = "VeryLazy",
    build = ":MasonUpdate",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      -- lsp progress
      { "j-hui/fidget.nvim", opts = { progress = { display = { render_limit = 8 } } } },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          -- <C-w>d is the default mapping for viewing diagnostic under cursor
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { buffer = 0 })

          vim.lsp.inlay_hint.enable(true, nil)
        end,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = vim.tbl_deep_extend("force", vim.api.nvim_get_runtime_file("", true), {
                "${3rd}/luv/library",
              }),
            },
            diagnostics = { disable = { "missing-fields" } },
          },
        },
      })

      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            check = {
              allTargets = false,
            },
            cargo = {
              features = "all",
            },
          },
        },
      })

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "clangd",
          "pyright",
          "gopls",
        },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    -- keys = {
    --   {
    --     "<leader>cf",
    --     function()
    --       require("conform").format()
    --     end,
    --     mode = { "n", "v" },
    --     desc = "Format",
    --   },
    -- },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "autopep8" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        html = { "prettierd", "prettier" },
        javascript = { "prettierd", "prettier" },
        css = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        sh = { "shfmt" },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        lsp_format = "fallback",
        timeout_ms = 1000,
      },
      default_format_opts = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_format = "fallback", -- not recommended to change
      },
    },
  },
}
