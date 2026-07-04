rec {
  description = "My system config";

  inputs = {
    ## NOTE
    # 1. using "git+https://github.com/someuser/somerepo" schema will use nix internal libcurl to download
    # 2. using "git+ssh/https://url" will use git to dwonload
    # 3. can add "host" parameters to "git+https://github.com/someuser/somerepo?host=host" to change url to non-github
    # 4. regarding parameters of the url
    #    - ref = branches or tag, use ref=refs/tags/tag to get tag
    #    - shallow = truncated git history, small size for big repo
    stable.follows = "nixpkgs";
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?ref=nixos-26.05&shallow=1";
    home-manager = {
      url = "git+https://github.com/nix-community/home-manager?ref=release-26.05&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "git+https://github.com/denful/import-tree";
    # wrappers = {
    #   url = "git+https://github.com/BirdeeHub/nix-wrapper-modules";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    wrappers = {
      url = "path:///home/peng/projects/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "git+https://github.com/hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    # vaultix.url = "git+https://github.com/milieuim/vaultix";
    sops-nix = {
      url = "git+https://github.com/Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nvim plugins
    lze = {
      url = "git+https://github.com/BirdeeHub/lze";
      flake = false;
    };
    lzextras = {
      url = "git+https://github.com/BirdeeHub/lzextras";
      flake = false;
    };
    vimplug-floatty = {
      url = "git+https://github.com/ingur/floatty.nvim";
      flake = false;
    };
    org-bullets = {
      url = "git+https://github.com/nvim-orgmode/org-bullets.nvim";
      flake = false;
    };
    project = {
      url = "git+https://github.com/DrKJeff16/project.nvim?ref=refs/tags/v5.1.0-1";
      flake = false;
    };
    neo-tree = {
      url = "git+https://github.com/nvim-neo-tree/neo-tree.nvim";
      flake = false;
    };
  };

  outputs =
    {
      self,
      import-tree,
      flake-parts,
      ...
    }@inputs:
    let
      args = {
        priUser = {
          name = "peng";
          fullName = "Peng Lei";
          description = "The Best!";
          email = "swk-pl@163.com";
          initialPw = "123";
          groups = [
            "wheel"
            "video"
            "audio"
            "wireshark"
            "networkmanager"
          ];
        };
        secUser = {
          name = "test";
          fullName = "Jane Doe";
          description = "Anonymous!";
          email = "test@example.com";
          initialPw = "123";
        };
        cursor = {
          theme = "";
          size = 24;
        };
        inherit nixConfig;
      };
    in
    inputs.flake-parts.lib.mkFlake {
      inherit inputs;
      specialArgs = args;
    } (inputs.import-tree.matchNot ".*/(flake|devenv)\.nix" ./.);

  nixConfig = {
    extra-substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store?priority=20"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=21"
      "https://mirror.nju.edu.cn/nix-channels/store?priority=22"
      "https://nix-community.cachix.org?priority=39"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    trusted-users = [
      "peng"
      "root"
    ];

    extra-experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
