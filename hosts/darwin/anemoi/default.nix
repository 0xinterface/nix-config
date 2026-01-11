{ config, pkgs, ... }:
{
  ids.gids.nixbld = 30000;
  system.defaults.dock = {
    persistent-apps = [
      "/Applications/Fantastical.app"
      "/Applications/Things3.app"
      "/Applications/Safari.app"
      "/Applications/Ivory.app"
      "/Applications/Prompt.app"
      "/Applications/Ghostty.app"
      "/Applications/Zen.app"
    ];
  };

  environment.systemPackages = with pkgs; [
    mas
  ];

  homebrew = {
    brews = [
      "incus"
    ];
    casks = [
      "helium-browser"
      "jordanbaird-ice"
      "little-snitch"
      "raycast"
      "zed"
    ];

    masApps = {};
  };
}
