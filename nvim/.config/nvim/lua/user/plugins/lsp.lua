return {
    {
        "williamboman/mason-lspconfig",
        dependencies = {
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" }
        },
        event = "VeryLazy",
        config = function()
            local on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "<leader>vs", function() vim.lsp.buf.workspace_symbol() end, opts)

                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format()
                    end,
                })

                if client.supports_method("textDocument/inlayHint") then
                    vim.lsp.inlay_hint.enable(true, nil)
                end
            end

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "rust_analyzer" },
                automatic_installation = true,
            })
            require("mason-lspconfig").setup_handlers {
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
                        }
                    })
                end,
            }
        end
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
            local default = require("cmp.config.default")()

            return {
                mapping = {
                    ["<C-n>"] = cmp.mapping({
                        i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                        c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    }),
                    ["<C-p>"] = cmp.mapping({
                        i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                        c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    }),
                    ["<C-y>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping.complete(), -- invoke complete manually
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "path" },
                }, {
                    { name = "buffer" },
                }),
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                sorting = default.sorting,
            }
        end,
        config = function(_, opts)
            local cmp = require("cmp")
            cmp.setup(opts)
            cmp.setup.cmdline(":", {
                mapping = opts.mapping,
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = opts.mapping,
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
