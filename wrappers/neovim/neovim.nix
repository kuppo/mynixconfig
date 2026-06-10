{ self, ... }: {
  flake.wrappers.neovim = { pkgs, wlib, lib, ... }: {
    imports = [ wlib.wrapperModules.neovim ];
    options = {
      profile = lib.mkOption {
        type = lib.types.enum [ "mini" "medium" "full" ];
        description = "Choose the neovim profile.";
        default = "mini";
      };
    };
    config = {
      settings = {
        # config_directory = ./.;
        aliases = [ "vim" "vi" ];
      };
    };
  };
}
