{ config, pkgs, ... }:
{
  ids.gids.nixbld = 30000;
  system.defaults.dock = {
    persistent-apps = [
      "/Applications/Fantastical.app"
      "/Applications/Things3.app"
      "/Applications/Safari.app"
      "/Applications/Ivory.app"
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
    ffmpeg
  ];

  homebrew = {
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
    casks = [
      "altserver"
      "audio-hijack"
      "camo-studio"
      "discord"
      "figma"
      "helium-browser"
      "little-snitch"
      "loopback"
      "raycast"
      "mos"
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
