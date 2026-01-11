{ config, pkgs, lib, libs, ... }:
{
  programs.fish = {
    enable = true;
    shellInit = ''
      if test -d /opt/homebrew
        /opt/homebrew/bin/brew shellenv | source
      end
      if test -d /Users/admin/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data 
        set -x SSH_AUTH_SOCK /Users/admin/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
      end
    '';
    interactiveShellInit = ''
      set fish_greeting
      set -x GOPATH (go env GOPATH)
      set -x PATH $PATH (go env GOPATH)/bin
      function read-sops-keys
        set -Ux SOPS_AGE_RECIPIENTS (op read "op://Infrastructure/SOPS/age/public key")
        set -Ux SOPS_AGE_KEY (op read "op://Infrastructure/SOPS/password")
      end
    '';
    shellAliases = {
      sl = "eza --icons";
      ls = "eza --icons";
      l = "eza --icons -l";
      la = "eza -lag --icons";
      lt = "eza -lTg --icons";
      lt1 = "eza -lTg --level=1 --icons";
      lt2 = "eza -lTg --level=2 --icons";
      lt3 = "eza -lTg --level=3 --icons";
      lta = "eza -lTag --icons";
      lta1 = "eza -lTag --level=1 --icons";
      lta2 = "eza -lTag --level=2 --icons";
      lta3 = "eza -lTag --level=3 --icons";
      vi = "nvim";
      vim = "nvim";
      cat = "bat";
      ping = "gping";
    };
  };
}
