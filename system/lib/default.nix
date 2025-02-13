{
  inputs,
  self,
  stateVersion,
  ...
}: let
  helpers = import ./helpers.nix {inherit inputs self stateVersion;};
in {
  inherit
    (helpers)
    mkDarwin
    mkHome
    ;
}
