{ self, priUser, ... }:
{
  flake.nixosModules.yazi =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      # yazi dependencies
      users.users.${priUser.name}.packages = with pkgs; [
        self.packages.${stdenv.hostPlatform.system}.yazi
        file
        ffmpeg
        _7zip-zstd
        jq
        poppler
        fd
        ripgrep
        fzf
        zoxide
        resvg
        imagemagick
        wl-clipboard-rs
      ];
      services.gvfs = {
        enable = true;
        package = pkgs.gvfs.override { gnomeSupport = false; };
      };
    };
}
