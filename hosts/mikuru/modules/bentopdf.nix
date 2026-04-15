# BentoPDF - Privacy-first PDF toolkit
# Client-side processing, no server-side data storage needed
{config, ...}: {
  virtualisation.oci-containers.containers.bentopdf = {
    image = "bentopdf/bentopdf-simple:latest";
    ports = ["8083:8080"]; # BentoPDF serves on port 8080 internally
    environment = {
      TZ = config.time.timeZone;
    };
    extraOptions = [
      "--pull=always"
      "--memory=512m"
    ];
  };
  networking.firewall.allowedTCPPorts = [8083];
}
