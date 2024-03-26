return {
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        -- stylua: ignore
        keys = {
            { "gd", "<cmd>Telescope lsp_definitions<CR>", desc = "Goto Definition", silent = true },
            { "K", vim.lsp.buf.hover, desc = "Hover", silent = true },
            { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
            { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", silent = true },
            { "vr", "<cmd>Telescope lsp_references<cr>", desc = "References", silent = true },
            { "<leader>vs", vim.lsp.buf.signature_help, desc = "View Signature", silent = true },
            { "<leader>vd", vim.diagnostic.open_float, desc = "View Diagnostic", silent = true },
            { "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic", silent = true },
            { "[d", vim.diagnostic.goto_prev, desc = "Prev Diagnostic", silent = true },
        },
        config = function()
            vim.diagnostic.config({
                underline = true,
            })

            -- vim.api.nvim_set_hl(0, "LspInlayHint", { link = "CursorLine", default = false })
            -- local on_attach = function(client, buffer)
            --     -- Nvim inlayHint is kinda buggy, but anyways...
            --     if
            --         vim.fn.has("nvim-0.10") == 1
            --         and client.supports_method("textDocument/inlayHint")
            --     then
            --         vim.lsp.inlay_hint.enable(buffer, true)
            --     end
            -- end

            local nvim_lsp = require("lspconfig")
            nvim_lsp.lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        workspace = {
                            checkThirdParty = false,
                            -- Tells lua_ls where to find all the Lua files that you have loaded
                            -- for your neovim configuration.
                            library = {
                                "${3rd}/luv/library",
                                unpack(vim.api.nvim_get_runtime_file("", true)),
                            },
                            -- If lua_ls is really slow on your computer, you can try this instead:
                            -- library = { vim.env.VIMRUNTIME },
                        },
                        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                        diagnostics = { disable = { "missing-fields" } },
                    },
                },
            })

            nvim_lsp.pyright.setup({})
            nvim_lsp.gopls.setup({})
            nvim_lsp.taplo.setup({}) -- toml

            -- nvim_lsp.clangd.setup({})
            -- nvim_lsp.ocamllsp.setup({})
        end,
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^4", -- Recommended
        ft = { "rust" },
        dependencies = {
            {
                "lvimuser/lsp-inlayhints.nvim",
                opts = {},
            },
        },
        config = function()
            vim.g.rustaceanvim = {
                inlay_hints = {
                    highlight = "NonText",
                },
                tools = {
                    hover_actions = {
                        auto_focus = true,
                    },
                },
                server = {
                    on_attach = function(client, bufnr)
                        require("lsp-inlayhints").on_attach(client, bufnr)
                    end,
                    default_settings = {
                        ["rust-analyzer"] = {
                            check = {
                                allTargets = false,
                            },
                            cargo = {
                                features = "all",
                            },
                        },
                    },
                },
            }
        end,
    },
    -- {
    --     "tomtomjhj/coq-lsp.nvim", -- See also tomtomjhj/vscoq.nvim
    --     event = "BufReadPre *.v", -- Load before BufRead to ensure correct file type detection
    --     dependencies = {
    --         { "neovim/nvim-lspconfig" },
    --         {
    --             "whonore/Coqtail",
    --             init = function()
    --                 -- Don't load Coqtail
    --                 vim.g["loaded_coqtail"] = 1
    --                 vim.g["coqtail#supported"] = 0
    --             end,
    --         },
    --     },
    --     config = true,
    -- },
}
