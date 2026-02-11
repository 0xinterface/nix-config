{ config, pkgs, ... }:
{
  ids.gids.nixbld = 350;
  system.defaults.dock = {
    persistent-apps = [
      "/Applications/Fantastical.app"
      "/Applications/Things3.app"
      "/Applications/Helium.app"
      "/Applications/Ivory.app"
      "/Applications/Prompt.app"
      "/Applications/Ghostty.app"
    ];
  };

  environment.systemPackages = with pkgs; [
    mas
    bun
    mosh
  ];

  homebrew = {
    brews = [
      "incus"
      "opencode"
    ];
    casks = [
      "helium-browser"
      "jordanbaird-ice"
      "little-snitch"
      "raycast"
      "secretive"
      "tableplus"
      "zed"
    ];

    masApps = {};
  };
}
