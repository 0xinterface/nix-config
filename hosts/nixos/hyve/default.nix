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
    useDHCP = false;
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
    bridges.ixbr0 = {
      interfaces = [];
    };
    interfaces.enp8s0.wakeOnLan = {
      enable = true;
      policy = ["magic"];
    };
    interfaces.enp8s0.ipv4.addresses = [
      {
        address = "10.0.3.5";
        prefixLength = 24;
      }
    ];
    interfaces.ixbr0 = {
      ipv4.addresses = [
        {
          address = "192.168.64.1";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = "192.168.64.254";
    firewall = {
      trustedInterfaces = [ "ixbr0" ];
      interfaces.tailscale0 = {
        allowedTCPPorts = [
          22
          8443
        ];
      };
    };
  };

  services.tailscale = {
    useRoutingFeatures = "server";
    extraSetFlags = [ "--advertise-routes=10.0.3.0/24,192.168.64.0/24" "--advertise-exit-node" ];
  };

  virtualisation.incus.preseed = {
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
            nictype = "bridged";
            parent = "ixbr0";
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
