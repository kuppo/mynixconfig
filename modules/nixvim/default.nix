{ self, inputs, ... }:
{
  flake.nixosModules.nixvim =
    {
      config,
      lib,
      ...
    }:
    {
      imports = [
        inputs.nixvim.nixosModules.nixvim
      ];
      config = lib.mkIf config.myoptions.nixvim.enable {
        programs.nixvim = {
          enable = true;
          defaultEditor = true;
          viAlias = true;
          vimAlias = true;
          withRuby = false;
          colorschemes.tokyonight.enable = true;

          imports = [
            self.nixosModules.nixvimAutocmds
            self.nixosModules.nixvimKeybindings
            self.nixosModules.nixvimLsp
            self.nixosModules.nixvimOptions
          ]
          ++
            ## plugins
            (
              if config.myoptions.nixvim.full then
                [
                  self.nixosModules.nixvimPluginBlink
                  self.nixosModules.nixvimPluginBlinkIndent
                  self.nixosModules.nixvimPluginBlinkPairs
                  self.nixosModules.nixvimPluginFzflua
                  self.nixosModules.nixvimPluginLazygit
                  self.nixosModules.nixvimPluginLuasnip
                  self.nixosModules.nixvimPluginLzn
                  self.nixosModules.nixvimPluginNeotree
                  self.nixosModules.nixvimPluginWhichkey
                ]
              else
                [ ]
            );
        };
      };
    };
}
