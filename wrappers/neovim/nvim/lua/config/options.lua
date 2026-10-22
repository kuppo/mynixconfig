-- netrw settings
local g = vim.g
g.netrw_banner = 0
g.netrw_clipboard = 0
g.netrw_keepdir = 1
g.netrw_liststyle = 1
g.netrw_sizestyle = "h"
g.netrw_sort_by = "size"

-- lsp enable
-- g.enabled_lsps = { "lua_ls", "nixd", "ty", "ruff", "tinymist", "rust-analyzer" }
-- no rust-analyzer here as it is handled by rustaceannvim
g.enabled_lsps = { "lua_ls", "nixd", "ty", "ruff", "tinymist", "texlab", "clangd" }

-- options
local vo = vim.opt
vim.opt.number = true
vo.relativenumber = true
vo.signcolumn = "yes"

vo.inccommand = "split"

vo.list = true
vo.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vo.hlsearch = true

vo.equalalways = false

vo.splitright = true

vo.mouse = "a"

vo.autoread = true

vo.scrolloff = 8

vo.expandtab = true
vo.smarttab = true
vo.tabstop = 2
vo.softtabstop = 2
vo.shiftwidth = 2
vo.autoindent = true
if nixInfo.is_mini then vo.smartindent = true end

vo.breakindent = true

vo.ignorecase = true
vo.smartcase = true

vo.updatetime = 250
vo.timeoutlen = 300

vo.termguicolors = true

vo.textwidth = 85
vo.colorcolumn = "85,100,120"
vo.showmatch = true
vo.matchtime = 2
vo.cmdheight = 1
vo.pumheight = 10
vo.pumblend = 10
vo.cursorline = true

vo.undofile = true
vo.swapfile = false

vo.backspace = "indent,eol,start"
vo.autochdir = false
-- o.iskeyword:append("-")
vo.path:append("**")
-- vo.selection = "exclusive"
vo.clipboard:append("unnamedplus")
vo.modifiable = true
vo.encoding = "UTF-8"

vo.formatoptions:append("mM")
