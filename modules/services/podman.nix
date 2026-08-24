# Podman backend for the container services (audiobookshelf,
# notifiarr, cleanuparr, bentopdf, flaresolverr).
{
  flake.modules.nixos.podman = {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };
    virtualisation.oci-containers.backend = "podman";
  };
}
