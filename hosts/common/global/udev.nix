{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    antimicrox
  ];

  services.udev = {
    enable = true;
    packages = with pkgs; [
      antimicrox
    ];
  };
}
