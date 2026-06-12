{ self, ... }: {
  flake.wrappers.neovim = { pkgs, wlib, lib, config, ... }: {
    imports = [ wlib.wrapperModules.neovim ];
    options = {
      settings = {
        profile = lib.mkOption {
          type = lib.types.enum [ "mini" "medium" "full" ];
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
      settings = {
        # config_directory = ./.;
        aliases = [ "vim" "vi" ];
      };

      specs =  lib.mkIf (config.settings.profile != "mini") {
        lze = {
          data = with pkgs.vimPlugins; [ lze lzextras ];
        };

        lua = {
          after = [ "lze" ];
          data = [ pkgs.vimPlugins.lazydev-nvim ];
          lazy = true;
        };

        general = {
          after = [ "lze" ];
          lazy = true;
          data = with pkgs.vimPlugins; [
            nvim-surround
            nvim-autopairs
            neo-tree-nvim
            lualine-nvim
            which-key-nvim
          ];
        };

        full = lib.mkIf (config.settings.profile == "full") {
          after = [ "general" ];
          lazy = true;
          data = with pkgs.vimPlugins; [
            yazi-nvim
            lazygit-nvim
            blink-cmp
            blink-indent
          ];
        };
      };
    };
  };
}
