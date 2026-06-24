{ self, priUser, ... }:
{
  flake.wrappers.git =
    {
      pkgs,
      wlib,
      config,
      lib,
      ...
    }:
    {
      imports = [ wlib.wrapperModules.git ];

      options = {
        git.user = lib.mkOption {
          type = lib.types.str;
          description = "Git user name, will appear on the commit message.";
          default = "${priUser.fullName}";
        };
        git.email = lib.mkOption {
          type = lib.types.str;
          description = "Git user's email, will appear on the commit message.";
          default = "${priUser.email}";
        };
      };

      config = {
        settings = {
          commit.template = "${./template.txt}";
          user.email = config.git.email;
          user.name = config.git.user;
          init.defaultBranch = "dev";
        };
        configFile.content = ''
          [url "https://v6.gh-proxy.org/https://github.com"]
                  insteadOf = https://github.com
          [url "https://github.com"]
                  pushInsteadOf = https://github.com
        '';
      };
    };

  perSystem =
    { lib, pkgs, ... }:
    {
      packages.git = lib.mkDefault self.wrappers.git.wrap;
    };
}
