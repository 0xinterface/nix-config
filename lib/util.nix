{ inputs, outputs, stateVersion, ... }:

{
  mkDarwin = { hostname, username ? "admin", system ? "aarch64-darwin",}:
  let
    inherit (inputs.nixpkgs) lib;
    customConfPath = ./../hosts/darwin/${hostname};
    customConf = if builtins.pathExists (customConfPath) then (customConfPath + "/default.nix") else ./../hosts/common/dock.nix;
  in
    inputs.darwin.lib.darwinSystem {
      specialArgs = { inherit system inputs username; };
      #extraSpecialArgs = { inherit inputs; }
      modules = [
        ../hosts/common/packages.nix
        ../hosts/common/darwin.nix
        customConf
        inputs.home-manager.darwinModules.home-manager {
            networking.hostName = hostname;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.${username} = { imports = [ ./../home/darwin.nix ]; };
        }
        inputs.nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            autoMigrate = true;
            mutableTaps = false;
            user = "${username}";
            taps = with inputs; {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "homebrew/homebrew-bundle" = homebrew-bundle;
            };
          };
        }
      ];
    };
  mkNixOS = { hostname, username ? "admin", system ? "x86_64-linux",}:
  let
    inherit (inputs.nixpkgs) lib;
  in
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        ../hosts/nixos/${hostname}/default.nix
        inputs.home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bak";
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.${username} = { imports = [ ./../home/${username}.nix ]; };
        }
      ];
      specialArgs = { inherit inputs outputs system username stateVersion; };
    };

}
