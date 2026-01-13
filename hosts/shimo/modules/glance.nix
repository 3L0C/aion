# Glance dashboard
{config, ...}: {
  sops.secrets."adguard/password" = {};

  sops.templates."glance-env" = {
    content = ''
      ADGUARD_PASSWORD=${config.sops.placeholder."adguard/password"}
    '';
  };

  services.glance = {
    enable = true;
    environmentFile = config.sops.templates."glance-env".path;

    settings = {
      server = {
        host = "0.0.0.0";
        port = 8080;
      };

      theme = {
        background-color = "0 4 9";
        primary-color = "51 33 80";
        negative-color = "358 100 68";
        contrast-multiplier = 1.2;
      };

      pages = [
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
                          title = "/g/";
                          url = "https://4chan.org/g/";
                        }
                        {
                          title = "/pol/";
                          url = "https://4chan.org/pol/";
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
        {
          name = "Feeds";
          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "rss";
                  limit = 10;
                  collapse-after = 3;
                  cache = "12h";
                  feeds = [
                    {
                      url = "https://selfh.st/rss/";
                      title = "selfh.st";
                    }
                    {url = "https://ciechanow.ski/atom.xml";}
                    {
                      url = "https://www.joshwcomeau.com/rss.xml";
                      title = "Josh Comeau";
                    }
                    {url = "https://samwho.dev/rss.xml";}
                    {
                      url = "https://ishadeed.com/feed.xml";
                      title = "Ahmad Shadeed";
                    }
                  ];
                }
                {
                  type = "twitch-channels";
                  channels = ["mikaels1" "deathydl" "deadlockfightnight"];
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "group";
                  widgets = [
                    {type = "hacker-news";}
                    {type = "lobsters";}
                  ];
                }
                {
                  type = "group";
                  widgets = [
                    {
                      type = "reddit";
                      subreddit = "technology";
                      show-thumbnails = true;
                    }
                    {
                      type = "reddit";
                      subreddit = "selfhosted";
                      show-thumbnails = true;
                    }
                  ];
                }
              ];
            }
            {
              size = "small";
              widgets = [
                {
                  type = "custom-api";
                  title = "Steam Specials";
                  cache = "12h";
                  url = "https://store.steampowered.com/api/featuredcategories?cc=us";
                  template = ''
                    <ul class="list list-gap-10 collapsible-container" data-collapse-after="5">
                    {{ range .JSON.Array "specials.items" }}
                      <li>
                        <a class="size-h4 color-highlight block text-truncate" target="_blank" href="https://store.steampowered.com/app/{{ .Int "id" }}/">{{ .String "name" }}</a>
                        <ul class="list-horizontal-text">
                          <li>{{ .Int "final_price" | toFloat | mul 0.01 | printf "$%.2f" }}</li>
                          {{ $discount := .Int "discount_percent" }}
                          <li{{ if ge $discount 40 }} class="color-positive"{{ end }}>{{ $discount }}% off</li>
                        </ul>
                      </li>
                    {{ end }}
                    </ul>
                  '';
                }
              ];
            }
          ];
        }
        {
          name = "Videos";
          columns = [
            {
              size = "full";
              widgets = [
                {
                  type = "group";
                  widgets = [
                    {
                      type = "videos";
                      title = "/b/";
                      style = "grid-cards";
                      limit = 24;
                      channels = [
                        "UC6AEAig50WUnBEk5hVkhHbg"
                        "UCbguawtJlHjxXzdAskubQVg"
                      ];
                    }
                    {
                      type = "videos";
                      title = "/diy/";
                      style = "grid-cards";
                      limit = 24;
                      channels = ["UCQJQB-ij7HNYKCyNdi0Y--Q"];
                    }
                    {
                      type = "videos";
                      title = "/g/";
                      style = "grid-cards";
                      limit = 24;
                      channels = [
                        "UCftcLVz-jtPXoH3cWUUDwYw"
                        "UCeeFfhMcJa1kjtfZAGskOCA"
                        "UCUUTDOHVELFLSP4NBnlPEwA"
                        "UCXGgrKt94gR6lmN4aN3mYTg"
                        "UCO2x-p9gg9TLKneXlibGR7w"
                        "UCXuqSBlHAE6Xw-yeJA0Tunw"
                        "UCR-DXc1voovS8nhAvccRZhg"
                        "UCBJycsmduvYEL83R_U4JriQ"
                        "UC6mIxFTvXkWQVEHPsEdflzQ"
                        "UCshObcm-nLhbu8MY50EZ5Ng"
                      ];
                    }
                    {
                      type = "videos";
                      title = "/jp/";
                      style = "grid-cards";
                      limit = 24;
                      channels = [
                        "UCHL9bfHTxCMi-7vfxQ-AYtg"
                        "UCo_qOsi_-M5cNgNvMB6vPuw"
                      ];
                    }
                    {
                      type = "videos";
                      title = "/pol/";
                      style = "grid-cards";
                      limit = 24;
                      channels = [
                        "UC2-i3KuYoODXsM99Z3-Gm0A"
                        "UCmGSJVG3mCRXVOP4yZrU1Dw"
                        "UCqykZoZjaOPb6i_Y5gk0kLQ"
                      ];
                    }
                    {
                      type = "videos";
                      title = "/sci/";
                      style = "grid-cards";
                      limit = 24;
                      channels = [
                        "UC7QE72cxiBkiwnvGoFfqYOg"
                        "UCFhXFikryT4aFcLkLw2LBLA"
                        "UC1D3yD4wlPMico0dss264XA"
                        "UC06E4Y_-ybJgBUMtXx8uNNw"
                        "UCVS89U86PwqzNkK2qYNbk5A"
                        "UCHnyfMqiRRG1u-2MsSQLbXA"
                        "UCQeDjGVRTWAApRmP_xFWaRA"
                      ];
                    }
                    {
                      type = "videos";
                      title = "/tv/";
                      style = "grid-cards";
                      limit = 24;
                      channels = [
                        "UCzjbia0NqUsSL1_-loJihMg"
                        "UCCA75dU6oaqia36HHrVveaQ"
                      ];
                    }
                    {
                      type = "videos";
                      title = "/v/";
                      style = "grid-cards";
                      limit = 24;
                      channels = [
                        "UCNvzD7Z-g64bPXxGzaQaa4g"
                        "UCyhnYIvIKK_--PiJXCMKxQQ"
                        "UCedicLbmN_7vPUmPXlvKPFg"
                        "UCsvn_Po0SmunchJYOWpOxMg"
                        "UCGntRpUdlsUG0tcvj2zIAIQ"
                      ];
                    }
                  ];
                }
              ];
            }
          ];
        }
      ];
    };
  };
}
