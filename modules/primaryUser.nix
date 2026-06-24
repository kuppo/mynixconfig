{ self, priUser, ... }:
{
  flake.nixosModules.primaryUser =
    {
      pkgs,
      wlib,
      lib,
      config,
      options,
      ...
    }:
    {
      users.users.${priUser.name} = {
        isNormalUser = true;
        extraGroups = priUser.groups;
        description = "${priUser.fullName}(${priUser.description})";
        initialPassword = "${priUser.initialPw}";
        shell = pkgs.fish;
      };
    };
}
