{ self, priUser, ... }:
{
  flake.nixosModules.latex =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      fetchurl,
      ...
    }:
    let
      ctex-kit = pkgs.stdenvNoCC.mkDerivation {
        name = "ctex-kit";
        src = (
          fetchurl {
            url = "https://github.com/CTeX-org/ctex-kit";
            hash = "sha256-/2I2xHXpZi0S988uFsGuPV6hhMw8e0U5m/P8myf42R0=";
          }
        );
        installPhase = "cp -r $src $out";
        passthru.tlType = "run";
      };

      texlive-ctex-kit = {
        pkgs = [
          ctex-kit
        ];
      };
    in
    {
      users.users.${priUser.name}.packages = with pkgs; [
        texliveFull
        # (texliveFull.withPackages (ps: with ps; [ texlive-ctex-kit ]))
        # miktex
        texlab # lsp
        tex-fmt # formatters
        # texpresso # previewer
        # rubber
        # pandoc
        # sioyek
        # (texliveMinimal.withPackages (
        #   ps: with ps; [
        #     luatex
        #     uptex
        #     xetex
        #     luatexja
        #     latexmk
        #     ctex
        #     xecjk
        #     cjk
        #     zhmetrics
        #     zhmetrics-uptex
        #     fandol
        #   ]
        # ))

      ];
    };
}
