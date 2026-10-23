{ ... }:
{
  flake.nixosModules.nixvimOptions =
    {
      lib,
      nixosConfig,
      ...
    }:
    {
      globals = {
        mapleader = " ";
        maplocalleader = ",";
        netrw_banner = 0;
        netrw_clipboard = 0;
        netrw_keepdir = 1;
        netrw_liststyle = 1;
        netrw_sizestyle = "h";
        netrw_sort_by = "size";
        enabled_lsps = [
          "lua_ls"
          "nixd"
          "ty"
          "ruff"
          "tinymist"
          "texlab"
          "clangd"
        ];
      };

      opts = {
        number = true;
        relativenumber = true;
        signcolumn = "yes";
        inccommand = "split";
        list = true;
        listchars = {
          tab = "» ";
          trail = "·";
          nbsp = "␣";
        };
        hlsearch = true;
        equalalways = false;
        splitright = true;
        mouse = "a";
        autoread = true;
        expandtab = true;
        smarttab = true;
        tabstop = 2;
        softtabstop = 2;
        shiftwidth = 2;
        autoindent = true;
        smartindent = lib.mkIf nixosConfig.myoptions.nixvim.full true;
        breakindent = true;
        ignorecase = true;
        smartcase = true;
        updatetime = 250;
        timeoutlen = 300;
        termguicolors = true;
        textwidth = 85;
        colorcolumn = "85,100,120";
        showmatch = true;
        matchtime = 2;
        cmdheight = 1;
        pumheight = 10;
        pumblend = 10;
        cursorline = true;
        undofile = true;
        swapfile = false;
        backspace = "indent,eol,start";
        autochdir = false;
        # o.iskeyword:append("-");
        # path:append("**");
        # vo.selection = "exclusive";
        # clipboard:append("unnamedplus");
        modifiable = true;
        encoding = "UTF-8";
        # formatoptions:append("mM");
      };
      extraConfigLua = ''
        vim.opt.clipboard:append("unnamedplus")
        vim.opt.formatoptions:append("mM")
        vim.opt.path:append("**")
      '';
    };
}
