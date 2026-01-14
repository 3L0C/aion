# BentoPDF - Privacy-first PDF toolkit
# Client-side processing, no server-side data storage needed
{
  virtualisation.oci-containers.containers.bentopdf = {
    image = "bentopdf/bentopdf:latest";
    ports = ["8083:8080"]; # BentoPDF serves on port 8080 internally
    environment = {
      TZ = "America/Los_Angeles";
    };
  };
  networking.firewall.allowedTCPPorts = [8083];
}
