{ pkgs, lib, inputs, stateVersion, ... }:
let
  inherit (inputs) nixpkgs ssh-keys;
in
{
  time.timeZone = "Asia/Hong_Kong";
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = stateVersion;

  services = {
    openssh.enable = true;
    tailscale.enable = true;
  };

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
      trusted-users = [ "admin" "root" ];
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

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keyFiles = [ ssh-keys.outPath ];
  };

  # environment.systemPackages = with pkgs; [
  #   #
  # ];
}
