{ self, ... }:
{
  flake.nixosModules.desktop =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      imports = [
        self.nixosModules.niriNoctalia
        self.nixosModules.dms
      ];

      config = {
        myoptions.desktop.dm = "greetd";
        myoptions.desktop.userTerminal = "kitty";
        environment.sessionVariables = {
          TERMINAL = "${config.myoptions.desktop.userTerminal}";
        };
      };
    };
}
