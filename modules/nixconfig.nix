{ self, ... }: {
  flake.nixosModules.nixconfig = {
    nix.settings = {
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
        "root"
        "peng"
      ];
      extra-experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
