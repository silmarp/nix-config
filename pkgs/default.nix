# When you add custom packages, list them here
# These are similar to nixpkgs packages
{ pkgs }: {
  # example = pkgs.callPackage ./example { };
  plymouth-hexagon-2 = pkgs.callPackage ./plymouth-hexagon-2 {};
}
