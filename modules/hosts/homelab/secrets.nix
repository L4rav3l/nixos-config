{ inputs, config, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  services.openssh.generateHostKeys = true;

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  sops.secrets."tailscale/key" = { };

  sops.defaultSopsFile = ../../../secrets/homelab.yaml;
  sops.defaultSopsFormat = "yaml";
}