{
  flake.modules.nixos.locate =
    {
      lib,
      options,
      ...
    }:
    {
      services.locate = {
        enable = true;
        # Remove NFS from excluded filesystems to index /mnt/share
        pruneFS = lib.filter (
          fs:
          !lib.elem fs [
            "nfs"
            "nfs4"
          ]
        ) options.services.locate.pruneFS.default;
      };
    };
}
