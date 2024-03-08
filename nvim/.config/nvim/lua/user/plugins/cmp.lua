return {
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
            for _, source in ipairs(opts.sources) do
                source.group_index = source.group_index or 1
            end

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
            cmp.setup.cmdline("/", {
                mapping = opts.mapping,
                sources = {
                    { name = "buffer" },
                },
            })
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        event = "InsertEnter",
        dependencies = {
            {
                "hrsh7th/nvim-cmp",
                dependencies = { "saadparwaiz1/cmp_luasnip" },
                opts = function(_, opts)
                    opts.snippet = {
                        expand = function(args)
                            require("luasnip").lsp_expand(args.body)
                        end,
                    }
                    opts.sources = opts.sources or {}
                    table.insert(opts.sources, { name = "luasnip" })
                end,
            },
            {
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
            {
                {
                    "kawre/neotab.nvim",
                    event = "InsertEnter",
                    opts = {
                        tabkey = "",
                        act_as_tab = false,
                    },
                },
            },
        },
        -- stylua: ignore
        keys = {
            {
                "<C-l>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next"
                        or "<Plug>(neotab-out)"
                end,
                expr = true,
                silent = true,
                mode = { "i", "s" },
            },
            {
                "<C-h>",
                function()
                    return require("luasnip").jumpable(-1) and "<Plug>luasnip-jump-prev"
                end,
                expr = true,
                silent = true,
                mode = { "i", "s" },
            },
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
    },
    {
        "Saecki/crates.nvim",
        event = { "BufReadPre Cargo.toml" },
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
