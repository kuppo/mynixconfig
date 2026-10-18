{
  self,
  inputs,
  ...
}:
{
  flake.wrappers.neovim =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      imports = [ wlib.wrapperModules.neovim ];
      options = {
        dev = {
          lua = lib.mkEnableOption "Enable lua dev";
          python = lib.mkEnableOption "Enable python dev";
          nix = lib.mkEnableOption "Enable nix dev";
        };
        settings = {
          profile = lib.mkOption {
            type = lib.types.enum [
              "mini"
              "medium"
              "full"
            ];
            description = "Choose the neovim profile.";
            default = "mini";
          };
          colorscheme = lib.mkOption {
            type = lib.types.str;
            default = "unokai";
          };
        };
      };
      config = {
        # information pass down to neovim
        # grab it in lua with `nixInfo(nil, "info", "key") == "value"`
        info = {
          vscode-lldb-path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}";
        };
        # add runtimePkgs to the spec
        specMods =
          {
            parentSpec ? null,
            parentOpts ? null,
            parentName ? null,
            config,
            ...
          }:
          {
            options.runtimePkgs = options.runtimePkgs // {
              description = ''
                A runtimePkgs spec field to put packages on the PATH
                If the spec is disabled, this value will not be included in the resulting neovim derivation
              '';
            };
          };
        runtimePkgs = config.specCollect (acc: v: acc ++ (v.runtimePkgs or [ ])) [ ];
        settings = {
          # config_directory = ./.;
          aliases = [
            "vim"
            "vi"
          ];
        };

        specs = lib.mkIf (config.settings.profile != "mini") {
          lze = {
            data = [
              (config.nvim-lib.mkPlugin "lze" inputs.lze)
              (config.nvim-lib.mkPlugin "lzextras" inputs.lzextras)
              # pkgs.luaPackages.nvim-nio
            ];
          };

          general = {
            after = [ "lze" ];
            lazy = true;
            data = with pkgs.vimPlugins; [
              nvim-surround
              ultimate-autopair-nvim
              vim-suda
            ];
          };

          full = lib.mkIf (config.settings.profile == "full") {
            after = [ "general" ];
            lazy = true;
            data = with pkgs.vimPlugins; [
              # these are pure dependencies
              {
                data = nui-nvim;
                lazy = false;
              }
              {
                data = hydra-nvim;
                lazy = false;
              }
              {
                data = plenary-nvim;
                lazy = false;
              }

              (config.nvim-lib.mkPlugin "floatty" inputs.vimplug-floatty)
              (config.nvim-lib.mkPlugin "neo-tree" inputs.neo-tree)
              (config.nvim-lib.mkPlugin "org-bullets" inputs.org-bullets)
              (config.nvim-lib.mkPlugin "project" inputs.project)
              (config.nvim-lib.mkPlugin "rustaceanvim" inputs.rustaceanvim)
              (config.nvim-lib.mkPlugin "nvim-dap" inputs.nvim-dap)
              # (config.nvim-lib.mkPlugin "dap-virtual-text" inputs.dap-virtual-text)
              # (config.nvim-lib.mkPlugin "dap-view" inputs.dap-view)
              nvim-dap-ui
              # (config.nvim-lib.mkPlugin "texpresso" inputs.texpresso)
              # knap
              blink-cmp
              blink-indent
              conform-nvim
              lazydev-nvim
              lazygit-nvim
              lualine-nvim
              multicursor-nvim
              org-roam-nvim
              orgmode
              vimtex
              nvim-dap-python
              nvim-dap-disasm
              # nvim-dap-lldb
              which-key-nvim
              yazi-nvim

              {
                data = fzf-lua;
                runtimePkgs = with pkgs; [
                  delta
                  jj
                ];
              }
              {
                data = luasnip;
                runtimePkgs = [ pkgs.luajitPackages.jsregexp ];
              }
              {
                data = nvim-web-devicons;
                runtimePkgs = [ pkgs.nerd-fonts.symbols-only ];
              }
            ];
          };
          grammers = lib.mkIf (config.settings.profile == "full") {
            data = with pkgs.vimPlugins.nvim-treesitter-parsers; [
              c
              rust
              python
              make
              markdown
              typst
              latex
              zig
              lua
              vim
              vimdoc
              cmake
            ];
          };

        };
      };
    };
}
