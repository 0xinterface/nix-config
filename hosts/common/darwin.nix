{ inputs, outputs, config, lib, hostname, system, username, pkgs, ... }:
let
  inherit (inputs) nixpkgs;
in
{
  users.users.admin.home = "/Users/admin";

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
    channel.enable = false;
  };
  system.stateVersion = 5;

  system.primaryUser = "admin";

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = lib.mkDefault "${system}";
  };

  programs.fish = {
    enable = true;
  };

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    onActivation.cleanup = "zap";

    taps = builtins.attrNames config.nix-homebrew.taps;
    
    casks = [
      "1password"
      "ghostty"
      "iina"
      "istat-menus"
      "keka"
      "orbstack"
      "popclip"
      "transmit"
    ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;
  system.defaults = {
    dock = {
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
      show-recents = false;
      persistent-others = [];
      orientation = "right";
      tilesize = 44;
    };
    menuExtraClock = {
      Show24Hour = true;
      ShowAMPM = false;
      ShowDate = 2;
      ShowDayOfWeek = false;
      ShowDayOfMonth = false;
    };
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.AppleTemperatureUnit = "Celsius";
    NSGlobalDomain.InitialKeyRepeat = 10;
    NSGlobalDomain.KeyRepeat = 1;
    NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
    NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
    NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
    NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
    NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
    WindowManager.EnableStandardClickToShowDesktop = false;
    trackpad = {
      TrackpadThreeFingerDrag = true;
      Clicking = true;
    };
  };
}
