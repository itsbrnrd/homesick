{ config, pkgs, ... }:

{ environment.systemPackages = with pkgs; [
    keybase
    kbfs
  ];

  services.keybase.enable = true;
  services.kbfs = {
      enable = true;
  };
}