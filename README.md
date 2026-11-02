This is a NixOS config for my personal machine, BC250 card, and homelab, packed with tons of extra features.

---

## Quick Setup Guide

Boot into a NixOS Live USB, open a terminal, and clone the repository:

```bash
git clone [https://github.com/l4rav3l/nixos-config](https://github.com/l4rav3l/nixos-config)
cd nixos-config
```

Choose Your Target Machine
Select the target host configuration you want to deploy, then run the corresponding two-step installation commands (partitioning via Disko followed by nixos-install):

1. Personal Laptop
```
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./modules/hosts/laptop/disko.nix
sudo nixos-install --flake .#laptop
```

2. BC250
```
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./modules/hosts/bc250/disko.nix
sudo nixos-install --flake .#bc250
```

3. Homelab
```
sudo nix --experimental-features "nix-command flakes" run github:nix-command flakes" run github:nix-community/disko -- --mode disko ./modules/hosts/homelab/disko.nix
sudo nixos-install --flake .#homelab
```
