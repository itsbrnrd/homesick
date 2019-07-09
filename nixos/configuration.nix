{ config, pkgs, ... }:

{ imports = [
    ./hardware/lenovo-x390.nix
    ./base.nix
    ./users.nix
    ./networking.nix
    ./power-management.nix
    ./xorg.nix
    ./keybase.nix
  ];
}