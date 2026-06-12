{
  description = "My system config";

  inputs = {
    stable.follows = "nixpkgs";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    import-tree = {
      url = "github:denful/import-tree";
    };

    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devshell.url = "github:numtide/devshell";

    # devenv = {
    #   url = "git+https://v6.gh-proxy.org/https://github.com/cachix/devenv";
    # };

    # flake-parts.follows = "devenv/flake-parts";

    # nixpkgs.follows = "devenv/nixpkgs";

    nixpkgs = {
      url = "git+https://github.com/NixOS/nixpkgs?ref=nixos-26.05&shallow=1";
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
          description = "Peng Lei";
          email = "swk-pl@163.com";
          initialPw = "123";
        };
        secUser = {
          name = "test";
          description = "Test people";
          email = "test@example.com";
          initialPw = "123";
        };
      };
    in
    inputs.flake-parts.lib.mkFlake {
      inherit inputs;
      specialArgs = args;
    } (
      inputs.import-tree.matchNot ".*/flake\.nix" ./.
    );

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
