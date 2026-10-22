-- keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local map = vim.keymap.set

map("i", "jk", "<esc>")

-- F1 to open help is annoying
map({ "i", "n", "v" }, "<F1>", "")

-- clear hl
map(
  "n",
  "<leader>ur",
  "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
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
map("n", "L", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "H", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Better windows
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<leader>wd", "<cmd>clo<cr>", { desc = "Close the window" })

-- Splitting & Resizing
-- map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
-- map("n", "<leader>hh", "<cmd>split<CR>", { desc = "Split window horizontally" })
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines up/down
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
-- map("v", "<", "<gv", { desc = "Indent left and reselect" })
-- map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Quick file navigation
if not nixInfo.is_full then
  map("n", "<leader>e", "<cmd>Explore<CR>", { desc = "Open file explorer" })
  map("n", "<leader>ff", ":find ", { desc = "Find file" })
end

-- reload file with utf-8
map("n", "<leader>bc", "<cmd>e ++enc=utf-8<cr>", { desc = "Reload [c]oding with UTF-8" })
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Leave the buffer" })

-- buffers
map("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save buffer" })
map("n", "<leader>fS", "<cmd>wa<cr>", { desc = "Save all buffers" })

-- quit
map("n", "<leader>qq", "<cmd>wa<cr><cmd>qa<cr>", { desc = "Quit nvim" })

-- quick messages check
map("n", "<leader>um", "<cmd>messages<cr>", { desc = "Check messages" })

-- quick list
map("n", "<leader>ss", ":grep -ir  ./<left><left><left>", { desc = "Grep under current dir" })

-- toggle
map("n", "<leader>tr", function()
  vim.opt_local.modifiable = not vim.opt_local.modifiable
end, { desc = "Toggle readonly" })
