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
      options = {
        enableSshd = lib.mkEnableOption "Whether enable the sshd.";
        knownHosts = options.services.openssh.knownHosts;
      };
      config = {
        services.openssh = {
          enable = config.enableSshd;
          openFirewall = true;
          settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
            PermitRootLogin = "no";
            AllowUsers = [ "${priUser.name}" ];
            MaxAuthTries = 3;
            PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
          };
          knownHosts = config.knownHosts;
        };
        programs.ssh = {
          knownHosts = config.knownHosts;
        };
      };
    };
}
