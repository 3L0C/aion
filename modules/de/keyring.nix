{
  flake.modules.nixos.keyring = { lib, ... }: {
    services.gnome = {
      gnome-keyring.enable = true;
      gcr-ssh-agent.enable = lib.mkForce false;
    };

    security.pam.services = {
      greetd.enableGnomeKeyring = true;
    };
  };
}
