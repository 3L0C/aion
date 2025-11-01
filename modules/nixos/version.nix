{
  aionRev,
  config,
  ...
}: {
  system.configurationRevision = aionRev;
  system.nixos.label = "${config.system.nixos.version}_${aionRev}";
}
