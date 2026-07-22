{
  self,
  priUser,
  ...
}:
{
  flake.nixosModules.earthPackages =
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
        self.packages.${pkgs.stdenv.hostPlatform.system}.zathura
        _7zip-zstd
        blender
        curl
        devenv
        dust
        eza
        firefox
        freecad-wayland
        gimp
        self.packages.${pkgs.stdenv.hostPlatform.system}.helix
        htop
        kdePackages.kdenlive
        kdePackages.okular
        kicad
        ksnip
        exiftool
        nix-tree
        numix-cursor-theme
        numix-icon-theme-square
        fresh-editor
        nwg-look
        qqmusic
        ristretto
        mediainfo
        tree
        trash-cli
        vlc
        wget
        yt-dlg
        zoxide
      ];
      environment.sessionVariables = {
        PDFVIEWER = "zathura";
      };
      programs = {
        nh = {
          enable = true;
          flake = "$HOME/.config/nixos";
        };
        wireshark = {
          enable = true;
          package = pkgs.wireshark;
          dumpcap.enable = true;
          usbmon.enable = true;
        };
        fish = {
          enable = true;
          package = self.packages.${pkgs.stdenv.hostPlatform.system}.fish;
        };
        git = {
          enable = true;
          package = self.packages.${pkgs.stdenv.hostPlatform.system}.git;
        };
        neovim = {
          enable = true;
          defaultEditor = true;
          package = self.wrappers.neovim.wrap {
            inherit pkgs;
            settings.profile = "full";
            hosts.ruby.nvim-host.enable = false;
            hosts.node.nvim-host.enable = false;
          };
        };
        gnupg.agent = {
          enable = true;
          enableSSHSupport = true;
        };
        obs-studio = {
          enable = true;
          plugins = with pkgs.obs-studio-plugins; [
            wlrobs
            obs-vaapi
            obs-pipewire-audio-capture
          ];
        };
      };
    };
}
