{ ... }:

{
  services.openssh = {
    enable = true;
  };

  # Passwordless sudo when SSH'ing with keys
  security.pam.enableSSHAgentAuth = true;
}

