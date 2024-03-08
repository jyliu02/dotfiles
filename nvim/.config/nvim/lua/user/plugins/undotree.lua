return {
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
    keys = {
        { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "UndoTree", silent = true },
    },
    init = function()
        vim.g.undotree_SetFocusWhenToggle = 1
    end,
}
