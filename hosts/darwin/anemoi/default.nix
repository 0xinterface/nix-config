{ config, pkgs, inputs, system, ... }:
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
  ] ++ [ 
    inputs.herdr.packages.${system}.default
    inputs.concord.packages.${system}.default
  ];

  homebrew = {
    brews = [
      "incus"
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

  programs.fish.interactiveShellInit = ''
    alias discord concord
  '';
}
