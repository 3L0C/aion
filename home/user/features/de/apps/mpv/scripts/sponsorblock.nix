{pkgs, ...}: {
  programs.mpv = {
    scripts = [pkgs.mpvScripts.sponsorblock];
    bindings = {
      "alt+g" = "script-binding sponsorblock/set_segment";
      "alt+G" = "script-binding sponsorblock/submit_segment";
      "alt+h" = "script-binding sponsorblock/upvote_segment";
      "alt+H" = "script-binding sponsorblock/downvote_segment";
    };
  };
}
