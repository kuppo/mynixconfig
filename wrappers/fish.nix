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
        # nixswitch = {
        #   position = "command";
        #   cursor = "%";
        #   expansion = "pushd $NIXDOTFILE_PATH && nix run .#activate && popd";
        # };
        # homeswitch = {
        #   position = "command";
        #   cursor = "%";
        #   expansion = "pushd $NIXDOTFILE_PATH && nix flake  && popd";
        # };
        # nixupgrade = {
        #   expansion = "pushd $NIXDOTFILE_PATH && sudo nix flake update && nixos-rebuild switch --flake . && echo 'waiting network...' && sleep 10 && nix run .#activate $USER@$hostname && popd";
        #   position = "command";
        #   cursor = "%";
        # };
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
        # launch tmux if the connection is over ssh
        if status is-interactive; and test -z "$TMUX"; and not set -q INSIDE_EMACS; and false
            test -x /usr/bin/tmux; and tmux new-session -A -s TMUX
        end

        # set the default fzf interface
        set -g -x FZF_DEFAULT_OPTS '--reverse --border=sharp --height=40% --no-info'

        # source z.lua
        #if test -e ~/.config/fish/z.lua; and test -x /usr/bin/lua
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

        # Starship setup
        if test -x /usr/bin/starship
            /usr/bin/starship init fish | source
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

        # add doom emacs bin to HOME
        if test -x ~/.config/emacs/bin/doom
            fish_add_path -aPg ~/.config/emacs/bin
        end
        fish_add_path -aPg ~/.local/bin

        # pass command directory for save all password
        set -gx PASSWORD_STORE_DIR "$HOME/.config/password-store"

        # the fuck
        if test -x /usr/bin/thefuck
            thefuck --alias | source
        end

        # better diff
        if test -x /usr/bin/icdiff
            abbr diff="icdiff"
        end

        # better ls
        if test -x /usr/bin/eza
            abbr ls="eza"
            abbr ll="eza -l"
            abbr la="eza -la"
        end

        # better du
        if test -x /usr/bin/dust
            abbr du="dust"
        end

        # better find
        #if test -x /usr/bin/fd
        #    abbr find="fd"
        #end

        # better cd
        if test -x /usr/bin/zoxide
            zoxide init fish | source
        end

        # better cat
        if test -x /usr/bin/bat
            abbr cat="bat"
        end

        # add flutter to PATH
        if test -e ~/dev/tools/flutter/bin
            fish_add_path ~/dev/tools/flutter/bin
        end

        # add cargo bin to PATH
        if test -e ~/.local/cargo/bin
            fish_add_path ~/.local/cargo/bin
        end

        # add flutter cli to PATH
        if test -e ~/.pub-cache/bin/
            fish_add_path ~/.pub-cache/bin/
        end

        # pyenv and virtualenv
        if test -x /usr/bin/pyenv
            pyenv init - | source
        end

        # probe-rs
        if test -x ~/.local/cargo/bin/probe-rs
            probe-rs complete install 2>/dev/null | source
        end

        # Gemini API key
        set -gx AVANTE_GEMINI_API_KEY 'AIzaSyA7QlyWMg9maWhuM1jl2orGy2O0MRH8zxQ'

        # flake configuration dir
        set -gx NIXDOTFILE_PATH $HOME/.config/nixos

        # autosuggestion
        # set -gx fish_autosuggestion_enabled 1

        # # prompts
        function fish_prompt --description 'Write out the prompt'
          set -l last_pipestatus $pipestatus
          set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

          if not set -q __fish_git_prompt_show_informative_status
                  set -g __fish_git_prompt_show_informative_status 1
          end
          if not set -q __fish_git_prompt_hide_untrackedfiles
                  set -g __fish_git_prompt_hide_untrackedfiles 1
          end
          if not set -q __fish_git_prompt_color_branch
                  set -g __fish_git_prompt_color_branch magenta --bold
          end
          if not set -q __fish_git_prompt_showupstream
                  set -g __fish_git_prompt_showupstream informative
          end
          if not set -q __fish_git_prompt_color_dirtystate
                  set -g __fish_git_prompt_color_dirtystate blue
          end
          if not set -q __fish_git_prompt_color_stagedstate
                  set -g __fish_git_prompt_color_stagedstate yellow
          end
          if not set -q __fish_git_prompt_color_invalidstate
                  set -g __fish_git_prompt_color_invalidstate red
          end
          if not set -q __fish_git_prompt_color_untrackedfiles
                  set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
          end
          if not set -q __fish_git_prompt_color_cleanstate
                  set -g __fish_git_prompt_color_cleanstate green --bold
          end

          set -l color_cwd
          set -l suffix
          if functions -q fish_is_root_user; and fish_is_root_user
                  if set -q fish_color_cwd_root
                          set color_cwd $fish_color_cwd_root
                  else
                          set color_cwd $fish_color_cwd
                  end
                  set suffix '#'
          else
                  set color_cwd $fish_color_cwd
                  set suffix '$'
          end

          # PWD
          set_color $color_cwd
          echo -n (prompt_pwd)
          set_color --reset

          printf '%s ' (fish_vcs_prompt)

          set -l status_color (set_color $fish_color_status)
          set -l statusb_color (set_color --bold $fish_color_status)
          set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)
          echo -n $prompt_status
          set_color --reset

          echo -n "$suffix "
        end
      '';
    };
  };

  perSystem = { lib, pkgs, ... }: {
    packages.fish = lib.mkDefault self.wrappers.fish.wrap;
  };
}
