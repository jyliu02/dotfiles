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
      require("mason-lspconfig").setup()
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
        markdown = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 2000,
        lsp_format = "fallback",
      },
    },
  },
}
