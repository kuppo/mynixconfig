{ self, lib, ... }:
{
  flake.nixosModules.nixvimPluginLazygit =
    {
      ...
    }:
    {
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
