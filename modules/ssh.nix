{
  self,
  priUser,
  nixpkgs,
  ...
}:
{
  flake.nixosModules.ssh =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      imports = [
        (lib.mkAliasOptionModule [ "knownHosts" ] [ "programs" "ssh" "knownHosts" ])
      ];
      config = {
        services.openssh = {
          enable = config.myoptions.enableSshd;
          openFirewall = true;
          settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
            PermitRootLogin = "no";
            AllowUsers = [ "${priUser.name}" ];
            MaxAuthTries = 3;
            PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
          };
        };
        programs.ssh = {
        };
      };
    };
}
