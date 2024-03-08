vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.inccommand = "split"

vim.o.wrap = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.incsearch = true

vim.o.showmode = false
vim.o.termguicolors = true
vim.o.scrolloff = 8
vim.o.swapfile = false
vim.o.backup = false
vim.o.hidden = true
vim.o.signcolumn = "yes:1"

vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.updatetime = 250

vim.o.pumheight = 10
vim.o.shortmess = "TIF"
vim.o.undofile = true
vim.o.cursorline = true
vim.o.laststatus = 3 -- global status line

vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- if vim.fn.has("nvim-0.10") == 1 then
--     vim.o.termsync = false
-- end
