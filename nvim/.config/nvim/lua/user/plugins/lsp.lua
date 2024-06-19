return {
    {
        "williamboman/mason-lspconfig",
        dependencies = {
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
        },
        event = "VeryLazy",
        config = function()
            local on_attach = function(client, bufnr)
                local map = function(modes, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    opts.remap = false
                    vim.keymap.set(modes, l, r, opts)
                end

                -- <C-w>d is the default mapping for viewing diagnostic under cursor
                map("n", "K", function()
                    vim.lsp.buf.hover()
                end, { desc = "Show Document" })
                map("n", "gd", function()
                    vim.lsp.buf.definition()
                end, { desc = "Goto Definition" })
                map("n", "gr", function()
                    vim.lsp.buf.references()
                end, { desc = "Goto References" })
                map("n", "[d", function()
                    vim.diagnostic.goto_next()
                end, { desc = "Prev Diagnostic" })
                map("n", "]d", function()
                    vim.diagnostic.goto_prev()
                end, { desc = "Next Diagnostic" })
                map("n", "<leader>ca", function()
                    vim.lsp.buf.code_action()
                end, { desc = "Code Actions" })
                map("n", "<leader>cr", function()
                    vim.lsp.buf.rename()
                end, { desc = "Rename Symbol" })
                map("i", "<C-h>", function()
                    vim.lsp.buf.signature_help()
                end, { desc = "Signature Help" })

                if client.supports_method("textDocument/inlayHint") then
                    vim.lsp.inlay_hint.enable(true, nil)
                end
            end

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "rust_analyzer" },
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
                markdown = { "prettier" },
            },
            formatters = {
                stylua = {
                    prepend_args = {
                        "--indent-type",
                        "Spaces",
                        "--quote-style",
                        "ForceDouble",
                        "--column-width",
                        "100",
                    },
                },
            },
            format_on_save = {
                -- These options will be passed to conform.format()
                timeout_ms = 2000,
                lsp_format = "fallback",
            },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
        opts = function()
            local cmp = require("cmp")

            return {
                mapping = {
                    ["<C-n>"] = cmp.mapping.select_next_item({
                        behavior = cmp.SelectBehavior.Select,
                    }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({
                        behavior = cmp.SelectBehavior.Select,
                    }),
                    ["<C-y>"] = cmp.mapping.confirm({
                        select = true,
                        behavior = cmp.ConfirmBehavior.Replace,
                    }),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "buffer" },
                }),
            }
        end,
        config = function(_, opts)
            local cmp = require("cmp")
            cmp.setup(opts)
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
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
