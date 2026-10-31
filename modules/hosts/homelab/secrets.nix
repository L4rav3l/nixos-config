{ inputs, config, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  services.openssh.generateHostKeys = true;

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  sops.defaultSopsFile = ../../secrets/homelab.yml;
  sops.defaultSopsFormat = "yaml";
}