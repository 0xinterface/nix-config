{ config, pkgs, lib, libs, ... }:
{
  programs.fish = {
    enable = true;
    shellInit = ''
      if test -d /opt/homebrew
        /opt/homebrew/bin/brew shellenv | source
      end
    '';
    interactiveShellInit = ''
      set fish_greeting
      function read-sops-keys
        set -Ux SOPS_AGE_RECIPIENTS (op read "op://Infrastructure/SOPS/age/public key")
        set -Ux SOPS_AGE_KEY (op read "op://Infrastructure/SOPS/password")
      end
    '';
    shellAliases = {
      sl = "eza";
      ls = "eza";
      l = "eza -l";
      la = "eza -la";
      vi = "nvim";
      vim = "nvim";
      cat = "bat";
      ping = "gping";
    };
  };
}
