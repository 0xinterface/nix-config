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
    kubecolor
    kubectl
    kubernetes-helm
    mas
    mosh
    nixd
    nil
    talosctl
  ];

  homebrew = {
    brews = [
      "incus"
      "herdr"
      "concord"
    ];
    casks = [
      "helium-browser"
      "google-chrome"
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

  programs.fish.shellAliases = {
    discord = "concord";
  };
}
