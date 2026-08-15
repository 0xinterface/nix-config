{ pkgs, username, ... }:
{
  users.users."${username}".extraGroups = ["incus-admin"];
  boot.initrd.kernelModules = [ "dm_thin_pool" "dm_snapshot" ];
  services.lvm.boot.thin.enable = true;
  virtualisation = {
    incus = {
      enable = true;
      ui.enable = true;
      package = pkgs.incus;
      preseed = {
        config = {
          "core.https_address" = ":8443";
        };
      };
    };
  };
}
