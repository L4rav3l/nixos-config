{
    description = "L4rav3l's own nixOS configuration.";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        nixos-hardware.url = "github:nixos/nixos-hardware";

        disko.url = "github:nix-community/disko";

        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        sops-nix.url = "github:Mic92/sops-nix";
        sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = {self, nixpkgs, ... }@inputs: {
        nixosConfigurations = {
            laptop = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [ ./modules/hosts/laptop/default.nix ];
            };

            /* homelab = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [ ./modules/hosts/homelab/default.nix ];
            }; */
        };

        diskoConfigurations.laptop = ./modules/hosts/laptop/disko.nix;
    };
}