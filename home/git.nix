{ config, pkgs, lib, libs, ... }:
{
  programs = {
    delta = {
      enable = true;
      options = {
        # syntax-theme = "solarized-dark";
        side-by-side = true;
      };
    };
    git = {
      enable = true;
      settings = {
        user.name = "Kristopher Lam";
        user.email = "root@sandb0x.io";

        pull.rebase = true;
        init.defaultBranch = "main";
        github.user = "0xinterface";

        push.autoSetupRemote = true;

        core.editor = "vim";
        core.fileMode = false;
        core.ignorecase = false;

        aliases = {
          prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
          root = "rev-parse --show-toplevel";
        };
      };

      ignores = [
        ".DS_Store"
        "**/.ssh/id_*"
        "**/.ssh/*_id_*"
        "**/.ssh/known_hosts"
      ];
    };
  };
}
