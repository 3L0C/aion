# Glance Feeds page - RSS, Twitch, HN, Reddit, Steam
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
            { url = "https://ciechanow.ski/atom.xml"; }
            {
              url = "https://www.joshwcomeau.com/rss.xml";
              title = "Josh Comeau";
            }
            { url = "https://samwho.dev/rss.xml"; }
            {
              url = "https://ishadeed.com/feed.xml";
              title = "Ahmad Shadeed";
            }
          ];
        }
        {
          type = "twitch-channels";
          channels = [
            "mikaels1"
            "deathydl"
            "deadlockfightnight"
          ];
        }
      ];
    }
    {
      size = "full";
      widgets = [
        {
          type = "group";
          widgets = [
            { type = "hacker-news"; }
            { type = "lobsters"; }
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
