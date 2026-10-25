{
  self,
  priUser,
  inputs,
  ...
}:
{
  flake.nixosModules.marswslPackages =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      users.users.${priUser.name}.packages = with pkgs; [
        # self.packages.${pkgs.stdenv.hostPlatform.system}.sioyek
        # sioyek
        _7zip-zstd
        curl
        devenv
        htop
        nix-tree
        tree
        trash-cli
        wget
        yt-dlg
        zoxide
      ];
      programs = {
        nh = {
          enable = true;
          flake = "$HOME/.config/nixos";
        };
        fish = {
          enable = true;
          # package = self.packages.${pkgs.stdenv.hostPlatform.system}.fish;
        };
        git = {
          enable = true;
          package = self.packages.${pkgs.stdenv.hostPlatform.system}.git;
        };
        neovim = {
          enable = true;
          defaultEditor = true;
          viAlias = true;
          vimAlias = true;
          withPython3 = true;
        };
      };
    };
}
