{ self, ... }:
{
  flake.nixosModules.locale =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      i18n = {
        extraLocales = [
          "en_US.UTF-8/UTF-8"
          "zh_CN.GB18030/GB18030"
          "zh_CN.GBK/GBK"
          "zh_CN.UTF-8/UTF-8"
          "zh_CN/GB2312"
          "zh_TW.EUC-TW/EUC-TW"
          "zh_TW.UTF-8/UTF-8"
          "zh_TW/BIG5"
        ];
        defaultLocale = "en_GB.UTF-8";
      };
      # environment.variables = {
      #   LC_TIME = "zh_CN.UTF-8";
      # };
    };
}
