{lib, ...}: {
  custom = {
    relativeToRoot = lib.path.append ../.;
  };
}
