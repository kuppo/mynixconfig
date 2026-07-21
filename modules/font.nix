{ self, ... }:
{

  flake.nixosModules.font =
    { pkgs, ... }:
    {
      fonts = {
        packages = with pkgs; [
          wqy_microhei
          wqy_zenhei
          lxgw-wenkai
          lxgw-neoxihei
          lxgw-wenkai-tc
          jigmo
          source-han-sans
          source-han-serif
          nerd-fonts.jetbrains-mono
          nerd-fonts.symbols-only
          twemoji-color-font
          edukai
          arphic-ukai
        ];
        fontconfig = {
          defaultFonts = {
            serif = [
              "Source Han Serif"
              "WenQuanYi Micro Hei"
            ];
            sansSerif = [ "Source Han Sans" ];
            monospace = [ "JetBrainsMonoNerdFont" ];
            emoji = [ "Twitter Color Emoji" ];
          };
        };
      };
    };
}
