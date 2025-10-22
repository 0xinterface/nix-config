{ pkgs, lib, inputs, stateVersion, ... }:
let
  inherit (inputs) nixpkgs;
in
{
  time.timeZone = "Asia/Hong_Kong";
  system.stateVersion = stateVersion;

  virtualisation = {
    docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };

  nix = {
    settings = {
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;
    };
    # Automate garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7";
    };
  };

  programs.fish.enable = true;

  # environment.systemPackages = with pkgs; [
  #   #
  # ];
}
