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

        stylix.url = "github:nix-community/stylix";
        stylix.inputs.nixpkgs.follows = "nixpkgs";

        impermanence.url = "github:nix-community/impermanence";
        impermanence.inputs.nixpkgs.follows = "nixpkgs";
        impermanence.inputs.home-manager.follows = "home-manager";
    };

    outputs = {self, nixpkgs, ... }@inputs: {
        nixosConfigurations = {
            laptop = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [ ./modules/hosts/laptop/default.nix ];
            };

            homelab = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [ ./modules/hosts/homelab/default.nix ];
            };

            bc250 = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [ ./modules/hosts/bc250/default.nix ];
            };
        };

        diskoConfigurations.laptop = import ./modules/hosts/laptop/disko.nix;
        diskoConfigurations.homelab = import ./modules/hosts/homelab/disko.nix;
        diskoConfigurations.bc250 = import ./modules/hosts/bc250/disko.nix;
    };
}