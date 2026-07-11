{ config, lib, hostname, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/incus.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModprobeConfig = ''
    options kvm ignore_msrs=1 report_ignored_msrs=0
  '';
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "intel_iommu=on"
    "iommu=pt"
  ];
  networking = {
    hostName = hostname;
    nftables.enable = true;
    useDHCP = true;
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
    interfaces.enp8s0.wakeOnLan = {
      enable = true;
      policy = ["magic"];
    };
    firewall = {
      trustedInterfaces = [ "ixbr0" ];
      interfaces.tailscale0 = {
        allowedTCPPorts = [
          22
          8443
        ];
      };
      interfaces.ixbr0 = {
        allowedTCPPorts = [
          53
          67
        ];
        allowedUDPPorts = [
          53
          67
        ];
      };
    };
  };

  virtualisation.incus.preseed = {
    networks = [
      {
        config = {
          "ipv4.address" = "192.168.64.254/24";
          "ipv4.dhcp" = "true";
          "ipv4.dhcp.ranges" = "192.168.64.1-192.168.64.249";
          "ipv4.nat" = "true";
        };
        name = "ixbr0";
        type = "bridge";
      }
    ];
    storage_pools = [
      {
        name = "standard";
        driver = "lvm";
        config = {
          source = "standard";
        };
      }
      {
        name = "vmpool";
        driver = "lvm";
        config = {
          source = "vmpool";
        };
      }
    ];
    profiles = [
      {
        name = "default";
        devices = {
          eth0 = {
            type = "nic";
            network = "ixbr0";
          };
          root = {
            type = "disk";
            path = "/";
            pool = "standard";
            size = "32GiB";
          };
        };
      }
    ];
  };
}
