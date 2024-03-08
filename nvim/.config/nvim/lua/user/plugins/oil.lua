return {
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    init = function()
        if vim.fn.argc(-1) == 1 then
            local stat = vim.loop.fs_stat(vim.fn.argv(0))
            if stat and stat.type == "directory" then
                require("lazy").load({ plugins = { "oil.nvim" } })
            end
        end
    end,
    opts = {
        use_default_keymaps = false,
        lsp_rename_autosave = true,
        keymaps = {
            ["-"] = "actions.parent",
            ["q"] = "actions.close",
            ["R"] = "actions.refresh",
            ["<CR>"] = "actions.select",
            ["<Tab>"] = "actions.preview",
            ["<C-v>"] = "actions.select_vsplit",
            ["<C-t>"] = "actions.select_tab",
            ["g?"] = "actions.show_help",
            ["g."] = "actions.toggle_hidden",
            ["gs"] = "actions.change_sort",
            ["gx"] = "actions.open_external",
        },
    },
    keys = {
        { "-", "<cmd>Oil<cr>", desc = "File Explorer", silent = true },
    },
}
