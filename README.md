# aion

NixOS configuration for my machines. It is a dendritic flake: flake-parts
plus import-tree, one file per feature, home-manager as a NixOS module.

Hosts: `yuki` (desktop), `haruhi` (laptop), `mikuru` (server), `nixos-vm`.

## Build

```bash
nh os switch          # rebuild the current host
nh os build           # build only
nix flake check       # checks and formatting
```

## Layout

- `flake.nix` holds the inputs and one output line.
- `modules/` holds every feature. import-tree loads each `.nix` file.
  A path with a `_` segment is data, not a module.
- `modules/hosts/<name>/` holds the host, hardware, disk, and home slices.
- `modules/pkgs/` holds custom packages.


Secrets live in a private flake input and are decrypted with sops-nix.
