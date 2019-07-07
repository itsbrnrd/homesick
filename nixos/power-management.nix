{ config, pkgs, ... }:

{ powerManagement.powertop.enable = true;
  services.upower.enable = true;
}