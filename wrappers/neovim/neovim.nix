{ self, inputs, ... }:
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
            data = with pkgs.vimPlugins; [
              lze
              lzextras
            ];
          };

          general = {
            after = [ "lze" ];
            lazy = true;
            data = with pkgs.vimPlugins; [
              nvim-surround
              nvim-autopairs
              vim-suda
            ];
          };

          full = lib.mkIf (config.settings.profile == "full") {
            after = [ "general" ];
            lazy = true;
            data = with pkgs.vimPlugins; [
              lazydev-nvim
              orgmode
              org-roam-nvim
              (config.nvim-lib.mkPlugin "org-bullets" inputs.org-bullets)
              neo-tree-nvim
              lualine-nvim
              which-key-nvim
              {
                data = config.nvim-lib.mkPlugin "floatty" inputs.vimplug-floatty;
              }
              {
                data = fzf-lua;
                runtimePkgs = with pkgs; [
                  fd
                  ripgrep
                  bat
                  delta
                  jj
                ];
              }
              {
                data = luasnip;
                runtimePkgs = [ pkgs.luajitPackages.jsregexp ];
              }
              {
                data = yazi-nvim;
                runtimePkgs = [ pkgs.yazi ];
              }
              {
                data = lazygit-nvim;
                runtimePkgs = [ pkgs.lazygit ];
              }
              {
                data = blink-cmp;
                runtimePkgs = [
                  (self.packages.${pkgs.stdenv.hostPlatform.system}.git or pkgs.git)
                  pkgs.curl
                ];
              }
              blink-indent
              multicursors-nvim
              conform-nvim
              {
                data = nvim-web-devicons;
                runtimePkgs = [ pkgs.nerd-fonts.symbols-only ];
              }
              {
                data = mini-icons;
                runtimePkgs = [ pkgs.nerd-fonts.symbols-only ];
              }
            ];
          };
        };
      };
    };
}
