{
  inputs = {
    # rolling release
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # macOS specific nix functions library
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs.url = "github:serokell/deploy-rs";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    homebrew-core = { url = "github:homebrew/homebrew-core"; flake = false; };
    homebrew-cask = { url = "github:homebrew/homebrew-cask"; flake = false; };
    homebrew-bundle = { url = "github:homebrew/homebrew-bundle"; flake = false; };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ssh-keys = {
      url = "https://github.com/0xinterface.keys";
      flake = false;
    };
  };

  outputs = {...}@inputs:
    with inputs;
    let
      inherit (self) outputs;
      stateVersion = "25.05";
      darwinHosts = [
        "oblivion"
      ];
      nixosHosts = [
        "luna"
        "workstation"
      ];
      libx = import ./lib { inherit inputs outputs stateVersion; };
    in {
      # nix build .#darwinConfigurations.${hostname}.system
      # ./result/sw/bin/darwin-rebuild switch --flake .
      darwinConfigurations = builtins.listToAttrs (
        builtins.map (hostname: {
          name = hostname;
          value = libx.mkDarwin { inherit hostname; };
        }) darwinHosts
      );

      # sudo nixos-rebuild switch --flake .#${hostname}
      nixosConfigurations = builtins.listToAttrs (
        builtins.map (hostname: {
          name = hostname;
          value = libx.mkNixOS { inherit hostname; };
        }) nixosHosts
      );

      # nix run github:serokell/deploy-rs -- ".#{hostname}.system"
      deploy.nodes = builtins.listToAttrs (
        builtins.map (hostname: {
          name = hostname;
          value = {
            hostname = hostname;
            sshUser = "admin";
            remoteBuild = true;
            interactiveSudo = true;
            profiles.system = {
              user = "root";
              path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.${hostname};
            };
          };
        }) nixosHosts
      );
    };
}
