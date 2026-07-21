{ self, priUser, ... }:
{
  flake.nixosModules.fcitx5 =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    let
      sourceDir = "~${priUser.name}/.config/nixos/modules/fcitx5/data";
      confSource = "${sourceDir}/config";
      confDst = "~${priUser.name}/.config/fcitx5";
      dataSource = "${sourceDir}/rime";
      dataDst = "~${priUser.name}/.local/share/fcitx5/rime";
    in
    {
      i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5 = {
          waylandFrontend = true;
          addons = with pkgs; [
            fcitx5-rime
            kdePackages.fcitx5-configtool
            libime
          ];
        };
      };
      system.userActivationScripts = {
        cpRimeData = {
          text = ''
            id ${priUser.name} >/dev/null 2>&1 && \
            mkdir -p ${confDst} && \
            mkdir -p ${dataDst} && \
            cp -rf ${confSource}/. ${confDst}/ && \
            cp -rf ${dataSource}/. ${dataDst}/
          '';
        };
      };
    };
}
