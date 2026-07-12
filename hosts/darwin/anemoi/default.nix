{ config, pkgs, ... }:
{
  ids.gids.nixbld = 350;
  system.defaults.dock = {
    persistent-apps = [
      "/Applications/Fantastical.app"
      "/Applications/Things3.app"
      "/Applications/Helium.app"
      "/Applications/Ivory.app"
      "/Applications/Ghostty.app"
    ];
  };

  environment.systemPackages = with pkgs; [
    bun
    herdr
    kubecolor
    kubectl
    mas
    mosh
    nixd
    nil
    talosctl
  ];

  homebrew = {
    brews = [
      "incus"
    ];
    casks = [
      "discord"
      "helium-browser"
      "jordanbaird-ice"
      "little-snitch"
      "mullvad-vpn"
      "raycast"
      "secretive"
      "tableplus"
      "zed"
    ];

    masApps = {};
  };
}
