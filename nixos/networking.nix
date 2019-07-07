{ config, pkgs, ... }:

{ networking.hostName = "columbia"; 
  networking.networkmanager.enable = true;
  networking.networkmanager.dhcp = "dhcpcd";
}
