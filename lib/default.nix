{
  inputs,
  outputs,
  stateVersion,
  ...
}:
let
  util = import ./util.nix { inherit inputs outputs stateVersion; };
in
{
  inherit (util)
    mkDarwin
    mkNixOS
    ;
}