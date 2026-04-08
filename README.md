## Linearis Nix Flake
Small Nix Flake that packages [Linearis](https://github.com/czottmann/linearis), a CLI built for humans and agents to easilly interact with [linear app](https://linear.app/).

This repository also automatically updates for the latest release via CI.

### Installation

```nix
{
  inputs.linearis-flake.url = "github:GMkonan/linearis-flake";

  # on Nixos configuration
  environment.systemPackages = [ 
    inputs.linearis.packages.${pkgs.stdenv.hostPlatform.system}.linearis
 ];

  # or in home manager
  home.packages = [ inputs.linearis.packages.${pkgs.stdenv.hostPlatform.system}.linearis ];
}
```

### Development
```
nix flake check

nix build .#linearis -L
```
