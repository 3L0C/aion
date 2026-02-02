# Glance Startpage - bookmarks, calendar, releases, weather, dns-stats
{
  name = "Startpage";
  columns = [
    {
      size = "small";
      widgets = [
        {
          type = "calendar";
          first-day-of-week = "sunday";
        }
        {
          type = "releases";
          cache = "1d";
          repositories = [
            "dockerhub:schollz/croc"
            "dockerhub:crazymax/diun"
            "dockerhub:glanceapp/glance"
            "dockerhub:jellyfin/jellyfin"
            "dockerhub:gotson/komga"
            "dockerhub:deluan/navidrome"
            "dockerhub:jc21/nginx-proxy-manager"
            "dockerhub:portainer/portainer-ce"
            "dockerhub:tomsquest/docker-radicale"
            "dockerhub:lscr.io/linuxserver/wireguard"
          ];
        }
      ];
    }
    {
      size = "full";
      widgets = [
        {
          type = "bookmarks";
          groups = [
            {
              hide-arrow = true;
              title = "4chan";
              color = "87 37 58";
              links = [
                {
                  title = "/a/";
                  url = "https://4chan.org/a/";
                  icon = "di:4chan";
                }
                {
                  title = "/g/";
                  url = "https://4chan.org/g/";
                  icon = "di:4chan";
                }
                {
                  title = "/pol/";
                  url = "https://4chan.org/pol/";
                  icon = "di:4chan";
                }
              ];
            }
            {
              title = "Media";
              color = "200 60 50";
              links = [
                {
                  title = "Audiobookshelf";
                  url = "https://audiobookshelf.colebruns.com";
                  icon = "di:audiobookshelf";
                }
                {
                  title = "Jellyfin";
                  url = "https://jellyfin.colebruns.com";
                  icon = "di:jellyfin";
                }
                {
                  title = "Komga";
                  url = "https://komga.colebruns.com";
                  icon = "di:komga";
                }
                {
                  title = "Navidrome";
                  url = "https://navidrome.colebruns.com";
                  icon = "di:navidrome";
                }
              ];
            }
            {
              title = "Arr Stack";
              color = "30 80 50";
              links = [
                {
                  title = "Sonarr";
                  url = "https://sonarr.colebruns.com";
                  icon = "di:sonarr";
                }
                {
                  title = "Radarr";
                  url = "https://radarr.colebruns.com";
                  icon = "di:radarr";
                }
                {
                  title = "Lidarr";
                  url = "https://lidarr.colebruns.com";
                  icon = "di:lidarr";
                }
                {
                  title = "Prowlarr";
                  url = "https://prowlarr.colebruns.com";
                  icon = "di:prowlarr";
                }
                {
                  title = "Jackett";
                  url = "https://jackett.colebruns.com";
                  icon = "di:jackett-light";
                }
                {
                  title = "FlareSolverr";
                  url = "https://flaresolverr.colebruns.com";
                  icon = "di:flaresolverr";
                }
                {
                  title = "Bazarr";
                  url = "https://bazarr.colebruns.com";
                  icon = "di:bazarr";
                }
                {
                  title = "Jellyseerr";
                  url = "https://jellyseerr.colebruns.com";
                  icon = "di:jellyseerr";
                }
              ];
            }
            {
              title = "Downloads";
              color = "280 60 50";
              links = [
                {
                  title = "qBittorrent";
                  url = "https://qbittorrent.colebruns.com";
                  icon = "di:vuetorrent";
                }
                {
                  title = "Syncthing (Mikuru)";
                  url = "https://syncthing.colebruns.com";
                  icon = "di:syncthing";
                }
                {
                  title = "Syncthing (Yuki)";
                  url = "http://yuki.tail7d01e8.ts.net:8384";
                  icon = "di:syncthing";
                }
                {
                  title = "Syncthing (Haruhi)";
                  url = "http://haruhi.tail7d01e8.ts.net:8384";
                  icon = "di:syncthing";
                }
                {
                  title = "Syncthing (localhost)";
                  url = "http://localhost:8384";
                  icon = "di:syncthing";
                }
              ];
            }
            {
              title = "Tools";
              color = "180 50 50";
              links = [
                {
                  title = "BentoPDF";
                  url = "https://bentopdf.colebruns.com";
                  icon = "di:bentopdf";
                }
              ];
            }
            {
              title = "Network";
              color = "220 50 50";
              links = [
                {
                  title = "AdGuard";
                  url = "https://adguard.colebruns.com";
                  icon = "di:adguard-home";
                }
                {
                  title = "Flint2 Router";
                  url = "http://192.168.1.1";
                  icon = "di:openwrt";
                }
                {
                  title = "Linksys AP";
                  url = "http://192.168.1.124";
                  icon = "di:openwrt";
                }
                {
                  title = "GLiNet KVM";
                  url = "https://glkvm.tail7d01e8.ts.net";
                  icon = "di:glinet-dark";
                }
              ];
            }
          ];
        }
      ];
    }
    {
      size = "small";
      widgets = [
        {
          type = "weather";
          location = "Rio Vista, California, United States";
          units = "imperial";
          hour-format = "12h";
        }
        {
          type = "dns-stats";
          service = "adguard";
          url = "http://adguard.colebruns.com/";
          username = "cole";
          password = "\${ADGUARD_PASSWORD}";
        }
        {
          type = "server-stats";
          servers = [
            {
              type = "local";
              name = "Services";
            }
          ];
        }
      ];
    }
  ];
}
