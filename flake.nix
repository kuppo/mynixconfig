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

    # nixpkgs.follows = "stable";
    nixpkgs.follows = "unstable";
    stable.url = "git+https://github.com/NixOS/nixpkgs?ref=nixos-26.05&shallow=1";
    unstable.url = "git+https://github.com/NixOS/nixpkgs?ref=nixos-unstable&shallow=1";
    import-tree.url = "git+https://github.com/denful/import-tree";
    wrappers = {
      url = "git+https://github.com/nix-community/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "git+https://github.com/hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    sops-nix = {
      url = "git+https://github.com/Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "git+https://github.com/oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "git+https://github.com/nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
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
          uid = "1000";
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
          uid = "1001";
        };
        cursor = {
          theme = "Numix-Cursor";
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
    substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store?priority=20"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=21"
      "https://mirrors.ustc.edu.cn/nix-channels/store?priority=22"
      "https://mirror.nju.edu.cn/nix-channels/store?priority=23"
      "https://nix-community.cachix.org?priority=39"
      "https://cache.nixos.org?priority=40"
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
