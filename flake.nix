{
    description = "L4rav3l's own nixOS configuration.";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs = {self, nixpkgs, ...}; {
        nixOSConfigurations = {
            laptop = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [ ./hosts/laptop ];
            };

            homelab = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [ ./hosts/homelab ];
            };
        };
    };
}