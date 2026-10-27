{ self, priUser, ... }:
{
  flake.nixosModules.fish =
    {
      config,
      ...
    }:
    {
      programs.fish = {
        shellAliases = {
          nupdate = "nix flake update --flake $NIXDOTFILE_PATH";
          nswitch = "nixos-rebuild switch --flake $NIXDOTFILE_PATH#$hostname --sudo";
          nupgrade = "nix flake update --flake $NIXDOTFILE_PATH && nixos-rebuild switch --flake $NIXDOTFILE_PATH#$hostname --sudo";
          nclean = "sudo nix-collect-garbage --delete-older-than 15d && nixos-rebuild boot --flake .$NIXDOTFILE_PATH#$hostname --sudo";
          fc-zh = "fc-list :lang=zh family";
          fc-zhfull = "fc-list :lang=zh fimily file";
          gco = "git checkout";
          gs = "git status";
          gb = "git branch";
          gd = "git diff";
          gdot = "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME";
          gl = "git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'";
          gll = "git log --oneline --graph --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'";
        };
        shellAbbrs = {
          hp = "http_proxy=http://127.0.0.1:8889 https_proxy=http://127.0.0.1:8889 ftp_proxy=http://127.0.0.1:8889 all_proxy=http://127.0.0.1:8889 HTTP_PROXY=http://127.0.0.1:8889 HTTPS_PROXY=http://127.0.0.1:8889 ALL_PROXY=http://127.0.0.1:8889";
          sp = "http_proxy=socks5://127.0.0.1:1089 https_proxy=socks5://127.0.0.1:1089 ftp_proxy=socks5://127.0.0.1:1089 all_proxy=socks5://127.0.0.1:1089 HTTP_PROXY=socks5://127.0.0.1:1089 HTTPS_PROXY=socks5://127.0.0.1:1089 ALL_PROXY=socks5://127.0.0.1:1089";
          sph = "http_proxy=socks5h://127.0.0.1:1089 https_proxy=socks5h://127.0.0.1:1089 ftp_proxy=socks5h://127.0.0.1:1089 all_proxy=socks5h://127.0.0.1:1089 HTTP_PROXY=socks5h://127.0.0.1:1089 HTTPS_PROXY=socks5h://127.0.0.1:1089 ALL_PROXY=socks5h://127.0.0.1:1089";
          gitignore = "curl -sL https://www.toptal.com/developers/gitignore/api/%";
        };
        interactiveShellInit = ''
          # set -g -x RUSTUP_UPDATE_ROOT https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup'
          # set -g -x RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup'
          # set -g -x RUSTUP_DIST_SERVER 'https://mirrors.ustc.edu.cn/rust-static'
          # set -g -x RUSTUP_UPDATE_ROOT 'https://mirrors.ustc.edu.cn/rust-static/rustup'
          set -g -x RUSTUP_DIST_SERVER 'https://mirrors.sjtug.sjtu.edu.cn/rust-static/'
          set -g -x RUSTUP_UPDATE_ROOT 'https://mirrors.sjtug.sjtu.edu.cn/rust-static/rustup'
          set -g -x FZF_DEFAULT_OPTS '--reverse --border=sharp --height=40% --no-info'
          set -gx CARGO_HOME "$HOME/.local/cargo/"
          set -g -x GOPROXY 'https://proxy.golang.com.cn,direct'
          set -g -x NO_PROXY "localhost,127.0.0.1,::1,192.168.0.0/16,172.16.0.0/24,10.0.0.0/8"
          set -g -x no_proxy "localhost,127.0.0.1,::1,192.168.0.0/16,172.16.0.0/24,10.0.0.0/8"
          set -g -x JUPYTER_CONFIG_DIR ~/.config/jupyter
          set -g -x IPYTHONDIR ~/.config/ipython
          set -gx AVANTE_GEMINI_API_KEY 'AIzaSyA7QlyWMg9maWhuM1jl2orGy2O0MRH8zxQ'
          set -gx NIXDOTFILE_PATH '${config.programs.nh.flake}'
          if test -x /etc/profiles/per-user/${priUser.name}/bin/tre; alias tree=tre; end
          if test -x /etc/profiles/per-user/${priUser.name}/bin/icdiff; alias diff="icdiff"; end
          if test -x /etc/profiles/per-user/${priUser.name}/bin/eza; alias ls="eza"; alias ll="eza -l"; alias la="eza -la"; end
          if test -x /etc/profiles/per-user/${priUser.name}/bin/dust; alias du="dust"; end
          if test -x /etc/profiles/per-user/${priUser.name}/bin/fd; alias find="fd"; end
          if test -x /etc/profiles/per-user/${priUser.name}/bin/zoxide; zoxide init fish | source; end
          if test -x /etc/profiles/per-user/${priUser.name}/bin/bat; alias cat="bat"; end
          if test -x ~${priUser.name}/.local/cargo/bin/probe-rs; probe-rs complete install 2> /dev/null | source; end
          fish_config theme choose bay-cruise; fish_config prompt choose nim
          function fish_greeting; echo Fishing time!; end
        '';
      };
    };
}
