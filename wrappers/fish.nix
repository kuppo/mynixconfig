{self, ...}: {
  flake.wrappers.fish = {
    pkgs,
    wlib,
    ...
  }: {
    imports = [wlib.wrapperModules.fish];
    options = {
    };
    config = {
      # package = pkgs.fishMinimal;
      flags."--no-config".data = false;
      pluginConfigDirs = ["/etc/fish"];
      abbreviations = {
        nixswitch = {
          position = "command";
          cursor = "%";
          expansion = "pushd $NIXDOTFILE_PATH && nixos-rebuild switch --flake .#$hostname --sudo && popd";
        };
        nixdev = {
          position = "command";
          cursor = "%";
          expansion = "nix develop --no-pure-eval $NIXDOTFILE_PATH#%";
        };
        # homeswitch = {
        #   position = "command";
        #   cursor = "%";
        #   expansion = "pushd $NIXDOTFILE_PATH && nix flake  && popd";
        # };
        nixupgrade = {
          expansion = "pushd $NIXDOTFILE_PATH && sudo nix flake update && nixos-rebuild switch --flake .#$hostname && popd";
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

      configFile.content = ''
        # set the default fzf interface
        set -g -x FZF_DEFAULT_OPTS '--reverse --border=sharp --height=40% --no-info'

        # source z.lua
        #if test -e ~/.config/fish/z.lua; and test -x /etc/profiles/per-user/$USER/bin/lua
        #    source (lua ~/.config/fish/z.lua --init fish | psub)
        #end

        # rustup mirror
        # rustcc.cn
        #set -g -x RUSTUP_DIST_SERVER 'http://mirrors.rustcc.cn'
        #set -g -x RUSTUP_UPDATE_ROOT 'http://mirrors.rustcc.cn/rustup'

        # 清华大学
        #set -g -x RUSTUP_UPDATE_ROOT https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup'
        #set -g -x RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup'

        # 中国科学技术大学
        #set -g -x RUSTUP_DIST_SERVER 'https://mirrors.ustc.edu.cn/rust-static'
        #set -g -x RUSTUP_UPDATE_ROOT 'https://mirrors.ustc.edu.cn/rust-static/rustup'

        # 上海交通大学
        set -g -x RUSTUP_DIST_SERVER 'https://mirrors.sjtug.sjtu.edu.cn/rust-static/'
        set -g -x RUSTUP_UPDATE_ROOT 'https://mirrors.sjtug.sjtu.edu.cn/rust-static/rustup'

        # Rustup Tsinghua mirror
        #set -gx RUSTUP_UPDATE_ROOT https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
        #set -gx RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup

        # Cargo home
        set -gx CARGO_HOME "$HOME/.local/cargo/"

        # devenv
        if test -x /etc/profiles/per-user/$USER/bin/devenv
          devenv hook fish | source
        end

        # tree = tre
        if test -x /etc/profiles/per-user/$USER/bin/tre
            alias tree=tre
        end

        # Go Proxy
        set -g -x GOPROXY 'https://proxy.golang.com.cn,direct'

        # NO_proxy
        set -g -x NO_PROXY "localhost,127.0.0.1,::1,192.168.0.0/16,172.16.0.0/24,10.0.0.0/8"
        set -g -x no_proxy "localhost,127.0.0.1,::1,192.168.0.0/16,172.16.0.0/24,10.0.0.0/8"

        # Jupyter notebook config directory
        set -g -x JUPYTER_CONFIG_DIR ~/.config/jupyter

        # iPython config directory
        set -g -x IPYTHONDIR ~/.config/ipython

        # add doom emacs bin to HOME -- Disabled in NixOS
        # if test -x ~/.config/emacs/bin/doom
        #     fish_add_path -aPg ~/.config/emacs/bin
        # end
        fish_add_path -aPg ~/.local/bin

        # pass command directory for save all password
        set -gx PASSWORD_STORE_DIR "$HOME/.config/password-store"

        # better diff
        if test -x /etc/profiles/per-usr/$USER/bin/icdiff
            alias diff="icdiff"
        end

        # better ls
        if test -x /etc/profiles/per-usr/$USER/bin/eza
            alias ls="eza"
            alias ll="eza -l"
            alias la="eza -la"
        end

        # better du
        if test -x /etc/profiles/per-usr/$USER/bin/dust
            alias du="dust"
        end

        # better find
        if test -x /etc/profiles/per-usr/$USER/bin/fd
           alias find="fd"
        end

        # better cd
        if test -x /etc/profiles/per-usr/$USER/bin/zoxide
            zoxide init fish | source
        end

        # better cat
        if test -x /etc/profiles/per-usr/$USER/bin/bat
            alias cat="bat"
        end

        # probe-rs
        if test -x ~/.local/cargo/bin/probe-rs
            probe-rs complete install 2>/dev/null | source
        end

        # Gemini API key
        set -gx AVANTE_GEMINI_API_KEY 'AIzaSyA7QlyWMg9maWhuM1jl2orGy2O0MRH8zxQ'

        # flake configuration dir
        set -gx NIXDOTFILE_PATH $HOME/.config/nixos

        ## fish
        fish_config theme choose bay-cruise
        fish_config prompt choose nim
        function fish_greeting
          echo Fishing time!
        end
      '';
    };
  };
}
