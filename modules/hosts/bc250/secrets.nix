{ inputs, config, ...}:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  services.openssh.generateHostKeys = true;

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  sops.defaultSopsFile = ../../../secrets/bc250.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.secrets."tailscale/key" = { };
  #sops.secrets."user/laravel-password".neededForUsers = true;
}