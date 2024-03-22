{inputs, ...}:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.age.keyFile = "/home/silmar/.config/sops/age/keys.txt";
}
