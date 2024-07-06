return {
  {
    "williamboman/mason-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    build = ":MasonUpdate",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      {
        "j-hui/fidget.nvim", -- lsp progress
        opts = {
          progress = {
            display = {
              render_limit = 8,
            },
          },
        },
      },
    },
    config = function()
      local on_attach = function(client, bufnr)
        -- <C-w>d is the default mapping for viewing diagnostic under cursor
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0 })
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { buffer = 0 })

        if client.supports_method("textDocument/inlayHint") then
          vim.lsp.inlay_hint.enable(true, nil)
        end
      end

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
        automatic_installation = true,
      })
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            on_attach = on_attach,
          })
        end,
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            on_attach = on_attach,
            settings = {
              Lua = {
                runtime = { version = "LuaJIT" },
                workspace = {
                  checkThirdParty = false,
                  library = {
                    "${3rd}/luv/library",
                    unpack(vim.api.nvim_get_runtime_file("", true)),
                  },
                },
                diagnostics = { disable = { "missing-fields" } },
              },
            },
          })
        end,
        ["rust_analyzer"] = function()
          require("lspconfig").rust_analyzer.setup({
            on_attach = on_attach,
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
        end,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        markdown = { { "prettierd", "prettier" }, "markdownlint" },
      },
      format_on_save = {
        timeout_ms = 2000,
        lsp_format = "fallback",
      },
      -- format = {
      --   timeout_ms = 2000,
      --   async = false, -- not recommended to change
      --   quiet = false, -- not recommended to change
      --   lsp_format = "fallback", -- not recommended to change
      -- },
    },
    -- config = function(_, opts)
    --   local conform = require("conform")
    --   conform.setup(opts)
    --
    --   vim.keymap.set({ "n", "v" }, "<leader>cf", function()
    --     conform.format()
    --   end, { desc = "Formatting" })
    -- end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        markdown = { "markdownlint" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = {
      {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
          opts.sources = opts.sources or {}
          table.insert(opts.sources, { name = "crates" })
        end,
      },
    },
    opts = {
      src = {
        cmp = { enabled = true },
      },
    },
  },
}
