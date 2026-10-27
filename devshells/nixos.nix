{
  perSystem = { config, pkgs, ... }: {
    devshells.nixos = {
      devshell = {
        name = "nixos flake";
      };
      commands = [
        {
          help = "Test the nixos flake";
          name = "testos";
          command = "nh os test";
        }
        {
          help = "Switch the nixos flake to latest";
          name = "switchos";
          command = "nh os switch";
        }
        {
          help = "Clean caches without take away direnv";
          name = "cleanlight";
          command = "sudo nh clean all --no-direnv";
        }
        {
          help = "Clean all caches";
          name = "nhcleanall";
          command = "sudo nh clean all";
        }
      ];
      packages = with pkgs; [
        nixd
        nixfmt-rs
      ];
    };
  };
}
