vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- options
vim.opt.number = true
local vo = vim.opt
vo.relativenumber = true
vo.signcolumn = "yes"

vo.list = true
vo.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vo.hlsearch = true

vo.mouse = "a"

vo.scrolloff = 8

vo.expandtab = true
vo.smarttab = true
vo.tabstop = 2
vo.softtabstop = 2
vo.shiftwidth = 2
vo.autoindent = true
-- vo.smartindent = true

vo.breakindent = true

vo.ignorecase = true
vo.smartcase = true

vo.updatetime = 250
vo.timeoutlen = 300

vo.termguicolors = true

vo.colorcolumn = "100"
vo.showmatch = true
vo.matchtime = 2
vo.cmdheight = 0
vo.pumheight = 10
vo.pumblend = 10
vo.cursorline = true

vo.undofile = true
vo.swapfile = false

vo.backspace = "indent,eol,start"
vo.autochdir = false
-- o.iskeyword:append("-")
vo.path:append("**")
vo.selection = "exclusive"
vo.clipboard:append("unnamedplus")
vo.modifiable = true
vo.encoding = "UTF-8"

-- netrw settings
local g = vim.g
g.netrw_banner = 0
g.netrw_clipboard = 0
g.netrw_keepdir = 0
g.netrw_liststyle = 1
g.netrw_sizestyle = "h"
g.netrw_sort_by = "size"

-- colorscheme
vim.cmd("colorscheme unokai")

-- keymaps
local map = vim.keymap.set
map("i", "jk", "<esc>")

-- F1 to open help is annoying
map({ "i", "n", "v" }, "<F1>", "")

-- clear hl
map(
  "n",
  "<leader>ur",
  ":nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Clear search highlights" }
)

-- Y to EOL
map("n", "Y", "y$", { desc = "Yank to end of line" })

-- Center screen when jumping
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Better paste behavior
map("x", "<leader>p", "\"_dP", { desc = "Paste without yanking" })

-- Delete without yanking
map({ "n", "v" }, "<leader>d", "\"_d", { desc = "Delete without yanking" })
map("n", "x", "\"_x", { desc = "Delete single char without yanking" })

-- Buffer navigation
map("n", "L", ":bnext<CR>", { desc = "Next buffer" })
map("n", "H", ":bprevious<CR>", { desc = "Previous buffer" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Splitting & Resizing
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines up/down
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Quick file navigation
map("n", "<leader>e", ":Explore<CR>", { desc = "Open file explorer" })
map("n", "<leader>ff", ":find ", { desc = "Find file" })
