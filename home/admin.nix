{ config, inputs, pkgs, lib, ...}:
{
  imports = [
    ./git.nix
    ./shell.nix
  ];

  home.stateVersion = "25.05";

  programs = {

    home-manager.enable = true;

    dircolors = {
      enable = true;
    };

    direnv = {
      # https://github.com/nix-community/nix-direnv#via-home-manager
      enable = true;
      nix-direnv.enable = true;
    };

    ssh = {
      enable = true;
    };

    starship = {
      enable = true;
      settings = pkgs.lib.importTOML ./starship/config.toml;
    };

    tmux = {
      enable = true;
      clock24 = true;
    };

  };
}
