{ self, ... }:
{
  flake.wrappers.stylua =
    {
      config,
      lib,
      wlib,
      pkgs,
      ...
    }:
    {
      imports = [ wlib.modules.default ];
      options = {
        settings = lib.mkOption {
          inherit (pkgs.formats.toml { }) type;
          default = { };
          description = ''
            stylua settings. Please refer to "https://github.com/JohnnyMorganz/StyLua".
          '';
        };
      };
      config = {
        flags."--config-path" = {
          ifs = null;
          sep = " ";
          data = config.configFile.path;
        };
        package = lib.mkDefault pkgs.stylua;
        constructFiles.stylua = {
          relPath = "${config.binName}.toml";
          content = lib.generators.toGitINI config.settings + "\n" + config.configFile.content;
        };
        meta.maintainers = [ wlib.maintainers.birdee ];
        meta.description = ''
          Nix uses git for all sorts of things. Including fetching flakes!

          So if you put this one in an overlay, name it something other than `pkgs.git`!

          Otherwise you will probably get infinite recursion.

          The vast majority of other packages do not have this issue. And,
          due to the passthrough of `.override` and `.overrideAttrs`,
          most other packages are safe to replace with their wrapped counterpart in overlays directly.
        '';
      };
    };
}
