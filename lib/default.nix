{
  inputs,
  outputs,
  stateVersion,
  ...
}:
let
  helpers = import ./util.nix { inherit inputs outputs stateVersion; };
in
{
  inherit (helpers)
    mkDarwin
    mkNixOS
    ;
}