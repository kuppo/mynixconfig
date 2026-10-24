{ self, ... }:
{
  flake.nixosModules.nixvimPluginLazygit =
    {
      pkgs,
      ...
    }:
    {
      extraPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.git
      ];
      plugins.lazygit = {
        enable = true;
        lazyLoad = {
          enable = true;
          settings = {
            cmd = [
              "LazyGit"
              "LazyGitConfig"
              "LazyGitCurrentFile"
              "LazyGitFilter"
              "LazyGitFilterCurrentFile"
            ];
            keys = [
              {
                __unkeyed-1 = "<leader>gg";
                __unkeyed-2 = "<cmd>LazyGit<cr>";
                desc = "LazyGit";
              }
            ];
          };
        };
      };
    };
}
