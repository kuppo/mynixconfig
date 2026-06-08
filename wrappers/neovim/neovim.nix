{ self, ... }: {
  flake.wrappers.neovim = { pkgs, wlib, ... }: {
    imports = [ wlib.wrapperModules.neovim ];
    options = {
    };
    config = {
      settings = {
        config_directory = ./.;
        aliases = [ "vim" "vi" ];
      };
    };
  };

  perSystem = { lib, pkgs, ... }: {
    packages.neovim = lib.mkDefault (self.wrappers.neovim.wrap { inherit pkgs; });
  };
}
