{
  description = "My system config";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs = {
      url = "git+https://mirror.nju.edu.cn/git/nixpkgs.git?ref=nixos-26.05&shallow=1";
    };
    stable.url = "git+https://mirror.nju.edu.cn/git/nixpkgs.git?ref=nixos-26.05&shallow=1";
    unstable.url = "git+https://mirror.nju.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";

    flake-parts = {
      url = "git+https://v6.gh-proxy.org/https://github.com/hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "git+https://v6.gh-proxy.org/https://github.com/nix-community/home-manager.git?ref=release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    import-tree = {
      url = "git+https://v6.gh-proxy.org/https://github.com/denful/import-tree";
    };

    wrappers = {
      url = "git+https://v6.gh-proxy.org/https://github.com/BirdeeHub/nix-wrapper-modules";
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
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
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
