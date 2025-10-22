{ inputs, pkgs, ... }:
let
  inherit (inputs) nixpkgs;
in
{
  nixpkgs.config.allowUnfree = true;
  fonts.packages = with pkgs; [
    inter
    fira-code
    raleway
    quicksand
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.bitstream-vera-sans-mono
  ];
  environment.systemPackages = with pkgs; [
    _1password-cli
    gnupg
    age
    tmux
    just
    wget
    fish
    bat
    btop
    ansible
    gping
    neofetch # fancy system + hardware info
    iperf
    sops
    vault
    yubikey-manager
    neovim
    eza
    tree
    terraform
    du-dust # better du alternative
    ripgrep
    # zbar
    jq
    go
    rclone
    # compression
    zip
    lz4
    nodejs_22
    git
  ] ++ lib.optionals stdenv.isLinux [
    btrfs-progs
    dig
    e2fsprogs # badblocks
    gptfdisk
    hddtemp
    htop
    molly-guard
    ncdu
    nmap
    nvme-cli
    powertop
    python3
    smartmontools
    tmux
    wget
    xfsprogs
    iotop
    lm_sensors
    iputils
    libuuid # `uuidgen` (already pre-installed on mac)
  ];
}