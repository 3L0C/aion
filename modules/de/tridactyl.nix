{
  flake.modules.homeManager.tridactyl = {
    xdg.configFile."tridactyl/tridactylrc".text = ''
      " This wipes all existing settings. This means that if a setting in this file
      " is removed, then it will return to default. In other words, this file serves
      " as an enforced single point of truth for Tridactyl's configuration.
      sanitize tridactyllocal tridactylsync

      " Theme
      set theme midnight

      " Blacklist
      blacklistadd my.vultr.com
      blacklistadd glkvm.tail7d01e8.ts.net

      " Hide mode indicator
      set modeindicator false

      " Old find settings
      " bind n findnext --search-from-view
      " bind N findnext --search-from-view --reverse
      " bind / fillcmdline find

      " Rebind basics
      bind d scrollline 10
      bind e hint -b
      bind h tabprev
      bind j scrollpage 0.5
      bind J scrollpx 10
      bind k scrollpage -0.5
      bind K scrollpx -10
      bind l tabnext
      bind m tabmove
      bind O fillcmdline tabopen
      bind scp source
      bind st fillcmdline tab
      bind S fillcmdline open search
      bind u scrollline -10
      bind x tabclose
      bind ,, nohlsearch
      bind ;d hint -qA
      bind V mode visual
      bind ,y hint -y

      " Unbound keys
      unbind s
      unbind <C-b>
      unbind <C-f>
      unbind <C-x>
      unbind <C-e>
      unbind W
      unbind w

      " Search urls
      set searchurls.aw https://wiki.archlinux.org/index.php?search=
      set searchurls.yt https://www.youtube.com/results?search_query=
      set searchurls.ny https://nyaa.si/?s=seeders&o=desc&q=
      set searchurls.yi https://yandex.com/images/search?text=
      set searchurls.an https://amazon.com/s?k=
      set searchurls.bs https://search.brave.com/search?q=
      set searchurls.ms https://mangasee123.com/search/?name=
      set searchurls.go https://google.com/search?q=
      set searchurls.di https://dashboardicons.com/icons?q=
      set searchurls.nixpr https://nixpk.gs/pr-tracker.html?pr=

      " Costom binds

      " Hint search text
      bind ,nh composite hint -p | nyaa_search

      " Gallery-dl
      bind ,gh hint -W gal_dl
      bind ,gn composite url2args | gal_dl

      " MPV
      bind ,mh hint -W mpv_open
      bind ,mn composite url2args | mpv_open
      bind ,Mh hint -W mpv_music
      bind ,Mn composite url2args | mpv_music

      " AMPV
      bind ,ah hint -W ampv_open
      bind ,an composite url2args | ampv_open
      bind ,ar hint -qW ampv_open

      " UMPV
      bind ,uh hint -W umpv_open
      bind ,un composite url2args | umpv_open
      bind ,ur hint -qW umpv_open

      " YT-DLP
      bind ,Yh hint -W yt_options
      bind ,Yn composite url2args | yt_options

      " Nyaa search
      command nyaa_search js -p tri.excmds.open("https://nyaa.si/?f=0&c=1_2&s=seeders&o=desc&q=" + JS_ARG)

      " Gallery-dl
      command gal_dl js -p tri.excmds.shellescape(JS_ARG).then(url => tri.excmds.exclaim_quiet('setsid -f gallery-dl -f "/O" -d "$HOME/gallery-dl" ' + url))

      " MPV
      command mpv_open js -p tri.excmds.shellescape(JS_ARG).then(url => tri.excmds.exclaim_quiet('setsid -f mpv --no-terminal --loop-playlist=no --keep-open=yes ' + url))
      command mpv_music js -p tri.excmds.shellescape(JS_ARG).then(url => tri.excmds.exclaim_quiet('setsid -f smpv --music ' + url))

      " AMPV
      command ampv_open js -p tri.excmds.shellescape(JS_ARG).then(url => tri.excmds.exclaim_quiet('setsid -f smpv --socket "ampv" ' + url))

      " UMPV
      command umpv_open js -p tri.excmds.shellescape(JS_ARG).then(url => tri.excmds.exclaim_quiet('setsid -f smpv ' + url))

      " YT-DLP
      command yt_options js -p tri.excmds.shellescape(JS_ARG).then(url => tri.excmds.exclaim_quiet('setsid -f yt-opts ' + url))
    '';
  };
}
