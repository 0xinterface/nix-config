{
  config, inputs, pkgs, lib, ...
}: {
  home.packages = with pkgs; [
    waybar
    ghostty
    wofi
  ];
}