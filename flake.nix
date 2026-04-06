{
  description = "Linearis CLI";

  outputs =
    { nixpkgs, ... }:
    {
      packages.x86_64-linux.linearis =
        let
          pkgs = import nixpkgs { system = "x86_64-linux"; };
        in
        pkgs.callPackage ./package.nix { };
    };
}
