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
    protoc-gen-go
    protobuf
    pnpm
    yt-dlp
    bun
  ];

  homebrew = {
    brews = [
      "incus"
    ];
    casks = [
      "altserver"
      "audio-hijack"
      "camo-studio"
      "discord"
      "figma"
      "google-chrome@dev"
      "helium-browser"
      "little-snitch"
      "loopback"
      "raycast"
      "zen"
      "jordanbaird-ice"
      "visual-studio-code"
      "tableplus"
      "rapidapi"
      "reflector"
      "pixelsnap"
      "utm"
      "xscope"
      "zed"
    ];
  };
}
