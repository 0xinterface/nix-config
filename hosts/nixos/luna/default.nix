{ config, lib, hostname, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    hostName = hostname;
    nftables.enable = true;
    interfaces.enp2s0.wakeOnLan = {
      enable = true;
      policy = ["magic"];
    };
  };
}