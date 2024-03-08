local keymap = function(modes, l, r, opts)
    opts = opts or {}
    if opts.silent == nil then
        opts.silent = true
    end
    vim.keymap.set(modes, l, r, opts)
end

-- Remap <Space> as <leader>
keymap("", "<Space>", "<Nop>", { desc = "" })
vim.g.mapleader = " "

keymap({ "n", "i" }, "<Esc>", "<cmd>noh<cr><esc>", { desc = "Clear Search Highlights" })

keymap({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
keymap("n", "<leader>q", ":qa<cr>", { desc = "Quit Neovim" })

-- Better window navigation
keymap({ "n", "v" }, "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
keymap({ "n", "v" }, "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
keymap({ "n", "v" }, "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
keymap({ "n", "v" }, "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

keymap("n", "<A-j>", "<cmd>m .+1<cr>==")
keymap("n", "<A-k>", "<cmd>m .-2<cr>==")
keymap("v", "<A-j>", ":m '>+1<cr>gv=gv")
keymap("v", "<A-k>", ":m '<-2<cr>gv=gv")

-- Sometimes interactive CLIs (like lazygit) need <Esc>
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Enter Normal Mode" })

keymap({ "n", "v" }, "[b", "<cmd>bp<cr>", { desc = "Prev buffer" })
keymap({ "n", "v" }, "]b", "<cmd>bn<cr>", { desc = "Next buffer" })

keymap({ "n", "v" }, "<leader>]", vim.cmd.tabnext, { desc = "Next Tab" })
keymap({ "n", "v" }, "<leader>[", vim.cmd.tabprevious, { desc = "Previous Tab" })

keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

keymap("x", "<leader>p", "\"_dP")
keymap({ "n", "v" }, "<leader>d", "\"_d")

keymap("n", "[q", function()
    local status, _ = pcall(vim.cmd.cprevious)
    if not status then
        print("No Previous Quickfix")
    end
end, { desc = "Previous Quickfix" })
keymap("n", "]q", function()
    local status, _ = pcall(vim.cmd.cnext)
    if not status then
        print("No Next Quickfix")
    end
end, { desc = "Next Quickfix" })
