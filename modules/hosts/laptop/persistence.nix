{ ... }:
{
  environment.persistence."/persist" = {
    hideMounts = true;

    directories = [
      "/var/lib/nixos"
      "/var/lib/bluetooth"
      "/var/lib/tailscale"
      "/var/lib/libvirt"
      "/var/lib/NetworkManager"
      "/etc/NetworkManager/system-connections"
      "/etc/usbguard"
      "/etc/cups"
      "/var/lib/alsa"
      "/var/lib/systemd"
      "/var/lib/fwupd"
      "/var/lib/AccountsService"
      "/var/lib/usbguard"
    ];

    files = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/machine-id"
    ];
  };

  fileSystems."/persist".neededForBoot = true;
}