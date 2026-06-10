{ self, priUser, ... }:
{
  flake.nixosModules.earthConfiguration =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        self.nixosModules.earthHardware
      ];

      networking.hostName = "earth"; # Define your hostname.
      networking.networkmanager.enable = true;
      time.timeZone = "Asia/Shanghai";
      i18n.defaultLocale = "en_US.UTF-8";
      services.pipewire = {
        enable = true;
        pulse.enable = true;
      };
      services.libinput.enable = true;
      users.users.${priUser.name} = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        description = "${priUser.description}";
        initialPassword = "${priUser.initialPw}";
        shell = pkgs.fish;
        packages = with pkgs; [
          tree
        ];
      };

      programs = {
        fish = {
          enable = true;
          package = self.packages.${pkgs.stdenv.hostPlatform.system}.fish;
        };
        neovim = {
          enable = true;
          defaultEditor = true;
          package = self.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
        };
        git = {
          enable = true;
          package = self.packages.${pkgs.stdenv.hostPlatform.system}.git;
        };
      };

      services.v2raya = {
        enable = true;
        # package = pkgs.xray;
      };

      environment.systemPackages = with pkgs; [
        self.packages.${pkgs.stdenv.hostPlatform.system}.alacritty
        fuzzel
        wget
        htop
        firefox
      ];
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
      system.stateVersion = "25.06";
    };
}
