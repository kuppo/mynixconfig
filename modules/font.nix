{ self, ... }:
{
  flake.nixosModules.font =
    { pkgs, ... }:
    let
      serif = [
        "Source Han Serif"
        "WenQuanYi Micro Hei"
      ];
      sansSerif = [ "Source Han Sans" ];
      monospace = [ "JetBrainsMono Nerd Font" ];
      emoji = [ "Twitter Color Emoji" ];
    in
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
            inherit
              serif
              monospace
              sansSerif
              emoji
              ;
          };
          # localConf = ''
          #   <?xml version="1.0"?>
          #   <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
          #   <fontconfig>
          #     <match target="pattern">
          #       <test name="prgname" compare="eq">
          #         <string>kitty</string>
          #       </test>
          #       <edit name="family" mode="prepend" binding="strong">
          #         <string>${builtins.elemAt monospace 0}</string>
          #       <family>${builtins.elemAt sansSerif 0}</family>
          #       </edit>
          #     </match>
          #     <alias>
          #       <family>${builtins.elemAt monospace 0}</family>
          #       <prefer>
          #         <family>${builtins.elemAt monospace 0}</family>
          #         <family>${builtins.elemAt sansSerif 0}</family>
          #         <family/>
          #       </prefer>
          #     </alias>
          #   </fontconfig>
          # '';
        };
      };
    };
}
