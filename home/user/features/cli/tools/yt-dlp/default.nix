{pkgs, ...}: {
  imports = [
    ./audio-soundcloud.nix
    ./audio-webms-playlist.nix
    ./audio-webms.nix
    ./audio.nix
    ./audio_playlist.nix
    ./audio_webm.nix
    ./band.nix
    ./chapters.nix
    ./video.nix
    ./video_playlist.nix
    ./wsg-video.nix
  ];

  home.packages = with pkgs; [
    yt-dlp # A youtube-dl fork with additional features and fixes
  ];
}
