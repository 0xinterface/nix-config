{ hostname, inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/incus.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    hostName = hostname;
    nftables.enable = true;
    useDHCP = false;
    interfaces.eno1 = {
      useDHCP = true;
      wakeOnLan = {
        enable = true;
        policy = [ "magic" ];
      };
    };
    firewall = {
      trustedInterfaces = [ "incusbr0" ];
      interfaces.tailscale0.allowedTCPPorts = [
        22
        8443
      ];
    };
  };

  services.tailscale = {
    useRoutingFeatures = "server";
    extraSetFlags = [ "--advertise-routes=192.168.46.0/24" ];
  };

  virtualisation.incus.preseed = {
    networks = [
      {
        name = "incusbr0";
        type = "bridge";
        config = {
          "ipv4.address" = "192.168.46.1/24";
          "ipv4.nat" = "true";
          "ipv6.address" = "none";
        };
      }
    ];
    storage_pools = [
      {
        name = "default";
        driver = "btrfs";
        config.source = "/var/lib/incus-storage";
      }
    ];
    profiles = [
      {
        name = "default";
        devices = {
          eth0 = {
            name = "eth0";
            network = "incusbr0";
            type = "nic";
          };
          root = {
            path = "/";
            pool = "default";
            type = "disk";
          };
        };
      }
    ];
  };
}
