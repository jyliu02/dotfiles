local map = function(modes, l, r, opts)
    opts = opts or {}
    if opts.silent == nil then
        opts.silent = true
    end
    vim.keymap.set(modes, l, r, opts)
end

local try_with_msg = function(fn, msg)
    local inner = function()
        local status, _ = pcall(fn)
        if not status then
            print(msg)
        end
    end

    return inner
end

-- Remap <Space> as <leader>
map("", "<Space>", "<Nop>", { desc = "" })
vim.g.mapleader = " "

map({ "n", "i" }, "<Esc>", "<cmd>noh<cr><esc>", { desc = "Clear Search Highlights" })

-- Better window navigation
-- map({ "n", "v" }, "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
-- map({ "n", "v" }, "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
-- map({ "n", "v" }, "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
-- map({ "n", "v" }, "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "J", "mzJ`z")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("v", "J", ":m '>+1<cr>gv=gv")
map("v", "K", ":m '<-2<cr>gv=gv")

-- Sometimes interactive CLIs (like lazygit) need <Esc>
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Enter Normal Mode" })

map({ "n", "v" }, "[b", "<cmd>bp<cr>", { desc = "Prev buffer" })
map({ "n", "v" }, "]b", "<cmd>bn<cr>", { desc = "Next buffer" })

map({ "n", "v" }, "<leader>]", vim.cmd.tabnext, { desc = "Next Tab" })
map({ "n", "v" }, "<leader>[", vim.cmd.tabprevious, { desc = "Previous Tab" })

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("x", "<leader>p", "\"_dP")
map({ "n", "v" }, "<leader>d", "\"_d")

map("n", "[q", try_with_msg(vim.cmd.cprev, "No Prev Quickfix"), { desc = "Previous Quickfix" })
map("n", "]q", try_with_msg(vim.cmd.cnext, "No Next Quickfix"), { desc = "Next Quickfix" })
