{ self, ... }: {
  flake.wrappers.fish = { pkgs, wlib, ... }: {
    imports = [ wlib.wrapperModules.fish ];
    options = {
    };
    config = {
      shellAliases = {
        tree = "tre";
      };
      flags."--no-config".data = false;
      pluginConfigDirs = [ "/etc/fish" ];
      abbreviations = {
        nixswitch = {
          position = "command";
          cursor = "%";
          expansion = "pushd $NIXDOTFILE_PATH && nixos-rebuild switch --flake .#$hostname --sudo && popd";
        };
        # homeswitch = {
        #   position = "command";
        #   cursor = "%";
        #   expansion = "pushd $NIXDOTFILE_PATH && nix flake  && popd";
        # };
        nixupgrade = {
          expansion = "pushd $NIXDOTFILE_PATH && sudo nix flake update && nixos-rebuild switch --flake .#hostname && popd";
          position = "command";
          cursor = "%";
        };
        # homeupdate = {
        #   expansion = "pushd $NIXDOTFILE_PATH && sudo nix run .#update && nix run .#activate $USER@$hostname && popd";
        #   position = "command";
        #   cursor = "%";
        # };
        nixclean = {
          expansion = "pushd $NIXDOTFILE_PATH && sudo nix-collect-garbage --delete-older-than 15d && nixos-rebuild boot --flake .% --sudo && popd";
          position = "command";
          cursor = "%";
        };
        gco = "git checkout";
        gs = "git status";
        gb = "git branch";
        gd = "git diff";
        gitignore = {
          expansion = "curl -sL https://www.toptal.com/developers/gitignore/api/%";
          cursor = "%";
        };
        gdot = "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME";
        gl = "git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'";
        gll = "git log --oneline --graph --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'";
        hp = {
          expansion = "http_proxy=http://127.0.0.1:8889 https_proxy=http://127.0.0.1:8889 ftp_proxy=http://127.0.0.1:8889 all_proxy=http://127.0.0.1:8889 HTTP_PROXY=http://127.0.0.1:8889 HTTPS_PROXY=http://127.0.0.1:8889 ALL_PROXY=http://127.0.0.1:8889";
          position = "anywhere";
        };
        sp = {
          expansion = "http_proxy=socks5://127.0.0.1:1089 https_proxy=socks5://127.0.0.1:1089 ftp_proxy=socks5://127.0.0.1:1089 all_proxy=socks5://127.0.0.1:1089 HTTP_PROXY=socks5://127.0.0.1:1089 HTTPS_PROXY=socks5://127.0.0.1:1089 ALL_PROXY=socks5://127.0.0.1:1089";
          position = "anywhere";
        };
        sph = {
          expansion = "http_proxy=socks5h://127.0.0.1:1089 https_proxy=socks5h://127.0.0.1:1089 ftp_proxy=socks5h://127.0.0.1:1089 all_proxy=socks5h://127.0.0.1:1089 HTTP_PROXY=socks5h://127.0.0.1:1089 HTTPS_PROXY=socks5h://127.0.0.1:1089 ALL_PROXY=socks5h://127.0.0.1:1089";
          position = "anywhere";
        };
      };

      configFile.path = ./config.fish;
    };
  };

  perSystem = { lib, pkgs, ... }: {
    packages.fish = lib.mkDefault self.wrappers.fish.wrap;
  };
}
