{inputs, ...}:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  #sops.age.keyFile = "/home/silmar/.config/sops/age/keys.txt";
  sops.age.sshKeyPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
  ];
}
