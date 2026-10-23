{ self, inputs, ... }:
{
  flake.nixosModules.nixvimKeybindings =
    {
      lib,
      nixosConfig,
      ...
    }:
    {
      keymaps = [
        {
          action = "<esc>";
          key = "jk";
          mode = "i";
          options.nowait = true;
        }
        {
          action = "";
          key = "<F1>";
          mode = [ "i" "n" "v" ];
          options.desc = "F1 to open help is annoying";
        }
        {
          action = "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>";
          key = "<leader>ur";
          options = {
            desc = "Clear search highlights" ;
            silent = true;
          };
          mode = "n";
        }
        {
          mode = "n";
          key = "Y";
          action = "y$";
          options.desc = "Yank to the end of line";
        }
        {
          mode = "n";
          key = "n";
          action = "nzzzv";
          options.desc = "Next search result (centered)";
        }
        {
          mode = "n";
          key = "N";
          action = "Nzzzv";
          options.desc = "Previous search result (centered)";
        }
        {
          mode = "n";
          key = "<C-d>";
          action = "<C-d>zz";
          options.desc = "Half page down (centered)";
        }
        {
          mode = "n";
          key = "<C-u>";
          action = "<C-u>zz";
          options.desc = "Half page up (centered)";
        }
        {
          mode = "n";
          key = "<C-f>";
          action = "<C-f>zz";
          options.desc = "Page down (centered)";
        }
        {
          mode = "n";
          key = "<C-b>";
          action = "<C-b>zz";
          options.desc = "Page up (centered)";
        }
        {
          mode = "x";
          key = "<leader>p";
          action = "\"_dP";
          options.desc = "Paste without yanking";
        }
        {
          mode = ["n" "v"];
          key = "<leader>d";
          action = "\"_d";
          options.desc = "Delete without yanking";
        }
        {
          mode = "x";
          key = "x";
          action = "\"_x";
          options.desc = "Delete single char without yanking";
        }
        {
          mode = "n";
          key = "L";
          action = "<cmd>bnext<CR>";
          options = {
            desc = "Buffer next";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "H";
          action = "<cmd>bprevious<CR>";
          options = {
            desc = "Buffer previous";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<C-h>";
          action = "<C-w>h";
          options = {
            desc = "Focus left window";
          };
        }
        {
          mode = "n";
          key = "<C-j>";
          action = "<C-w>j";
          options = {
            desc = "Focus bottom window";
          };
        }
        {
          mode = "n";
          key = "<C-k>";
          action = "<C-w>k";
          options = {
            desc = "Focus top window";
          };
        }
        {
          mode = "n";
          key = "<C-l>";
          action = "<C-w>l";
          options = {
            desc = "Focus right window";
          };
        }
        {
          mode = "n";
          key = "<leader>wd";
          action = "<cmd>clo<cr>";
          options = {
            desc = "Close window";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>wd";
          action = "<cmd>clo<cr>";
          options = {
            desc = "Close window";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<C-Up>";
          action = "<cmd>resize +2<CR>";
          options = {
            desc = "Increase window height";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<C-Down>";
          action = "<cmd>resize -2<CR>";
          options = {
            desc = "Decrease window height";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<C-Left>";
          action = "<cmd>vertical resize -2<CR>";
          options = {
            desc = "Decrease window width";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<C-Right>";
          action = "<cmd>vertical resize +2<CR>";
          options = {
            desc = "Increase window width";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<A-j>";
          action = "<cmd>m .+1<CR>==";
          options = {
            desc = "Move line down";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<A-k>";
          action = "<cmd>m .-2<CR>==";
          options = {
            desc = "Move line up";
            silent = true;
          };
        }
        {
          mode = "v";
          key = "<A-j>";
          action = "<cmd>m '>+1<CR>gv=gv";
          options = {
            desc = "Move selection down";
            silent = true;
          };
        }
        {
          mode = "v";
          key = "<A-k>";
          action = "<cmd>m '<=2<CR>gv=gv";
          options = {
            desc = "Move selection up";
            silent = true;
          };
        }
        {
          mode = "v";
          key = "<";
          action = "<gv";
          options = {
            desc = "Indent left and reselect";
          };
        }
        {
          mode = "v";
          key = ">";
          action = ">gv";
          options = {
            desc = "Indent right and reselect";
          };
        }
        {
          mode = "n";
          key = "<leader>bc";
          action = "<cmd>e ++enc=utf-8 ++ff=unix<cr>";
          options = {
            desc = "Force buffer to utf8 and unix ending";
          };
        }
        {
          mode = "n";
          key = "<leader>bd";
          action = "<cmd>bd<cr>";
          options = {
            desc = "Close buffer";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>fs";
          action = "<cmd>w<cr>";
          options = {
            desc = "Save buffer";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>fS";
          action = "<cmd>wa<cr>";
          options = {
            desc = "Save all buffer";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>qq";
          action = "<cmd>wa<cr><cmd>qa<cr>";
          options = {
            desc = "Quit nvim";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>um";
          action = "<cmd>message<cr>";
          options = {
            desc = "Show message";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>tr";
          action = {__raw = ''
              function()
                vim.opt_local.modifiable = not vim.opt_local.modifiable
              end
            '';
          };
          options = {
            desc = "Toggle readonly";
          };
        }
      ] ++ (if !nixosConfig.myoptions.nixvim.full then [
        {
          mode = "n";
          key = "<leader>ss";
          action = ":grep -ir  ./<left><left><left>";
          options = {
            desc = "Grep under current dir";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>fe";
          action = "<cmd>Explore<cr>";
          options = {
            desc = "Open file explorer";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>ff";
          action = ":find ";
          options = {
            desc = "Find file";
          };
        }
      ] else []);
    };
}
