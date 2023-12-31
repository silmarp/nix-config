# NixOS Configurations
![ci-badge](https://img.shields.io/static/v1?label=Built%20with&message=nix&color=blue&style=flat&logo=nixos&link=https://nixos.org&labelColor=111212)

Repository with my NixOS/Home-manager personal configurations based on [nix starter configs](https://github.com/Misterio77/nix-starter-config)

## Current hosts
* **Limonite**: Oracle Cloud VPS 24GB RAM 4vCPUs
* **Pyrolusite**: Lenovo Ideapad 3 - 12GB RAM, Ryzen 5 5500u
* **Rutile**: Samsung rf511 - 6GB RAM, Intel i5-2450M, GTX 540M

## Usage
For building and activating host configuration:
``nixos-rebuild switch --flake .#${host}`` 


For building and activating user configuration:
``home-manager switch --flake .#"${user@host}"`` 
