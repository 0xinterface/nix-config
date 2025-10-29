{ config, inputs, pkgs, lib, ...}:
{
  imports = [
    ./admin.nix
  ];

  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      font-size = 14;
      background-blur-radius = 20;
      background-opacity = 0.9;
      window-height = 33;
      window-width = 125;
      macos-auto-secure-input = true;
      macos-secure-input-indication = true;
      shell-integration-features = "ssh-terminfo,ssh-env";
      theme = "Rose Pine";
    };
  };

  programs.zed-editor = {
    enable = true;
    package = null;
    userSettings = {
      terminal = {
        font_family = "FiraCode Nerd Font";
        font_size = 14;
      };
      theme = {
        mode = "system";
        light = "Dracula";
        dark = "Dracula";
      };
      buffer_font_size = 15;
      ui_font_size = 16;
    };
  };
}