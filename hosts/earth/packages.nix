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
      users.users.${priUser.name}.packages =
        with pkgs;
        [
          curl
          vlc
          wget
          htop
          firefox
          devenv
          tree
          qqmusic
          blender
          freecad-wayland
          kdePackages.kdenlive
          _7zip-zstd
          yt-dlg
          zathura
          numix-cursor-theme
          numix-icon-theme-square
          eza
          zoxide
          dust
          nwg-look
          nix-tree
        ]
        ++ [
          self.packages.${pkgs.stdenv.hostPlatform.system}.alacritty
        ];

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
        thunar = {
          enable = true;
          plugins = with pkgs; [
            thunar-archive-plugin
            thunar-volman
          ];
        };
      };
    };
}
