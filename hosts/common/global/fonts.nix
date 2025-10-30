{ config, pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      inter # A typeface specially designed for user interfaces
      noto-fonts # Google Noto TTF fonts
      noto-fonts-cjk-sans # Google Noto CJK Sans fonts
      noto-fonts-cjk-serif # Google Noto CJK Serif fonts
      noto-fonts-color-emoji # Google Noto Color Emoji font
      ipafont # Japanese outline fonts by Information-technology Promotion Agency, Japan (IPA)
      hanazono # A free Japanese kanji font, which contains about 78,685 characters (and 2 SPACEs) defined in ISO/IEC 10646 standard / the Unicode standard
      nerd-fonts.jetbrains-mono # Patched font JetBrains Mono from nerd fonts library
      nerd-fonts.symbols-only # High number of extra glyphs from popular 'iconic fonts' (monospace)
      mplus-outline-fonts.githubRelease # M+ Japanese outline fonts
      corefonts # Microsoft Windows fonts
      vista-fonts # Some TrueType fonts from Microsoft Windows Vista
      roboto # Google's signature family of fonts
      ubuntu-sans # Ubuntu font family
      source-han-sans # Source Han Sans fonts (includes Japanese)
      source-han-serif # Source Han Serif fonts (includes Japanese)
      ibm-plex # IBM Plex fonts including Japanese support
      freefont_ttf # Free fonts (includes FreeSerif, FreeSans, FreeMono)
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        style = "slight";
      };
      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
      useEmbeddedBitmaps = true;
      defaultFonts = {
        serif = [
          "Inter"
          "Roboto"
          "Noto Serif"
          "FreeSerif"
          "Noto Serif CJK JP"
          "IPAPMincho"
          "Symbols Nerd Font"
          "Noto Color Emoji"
        ];
        sansSerif = [
          "Inter"
          "Roboto"
          "Noto Sans"
          "FreeSans"
          "Noto Sans CJK JP"
          "Source Han Sans JP"
          "IPAPGothic"
          "IBM Plex Sans JP"
          "Symbols Nerd Font"
          "Noto Color Emoji"
        ];
        monospace = [
          "JetBrainsMonoNL Nerd Font"
          "Noto Sans Mono"
          "Noto Sans Mono CJK JP"
          "IPAPGothic"
          "Symbols Nerd Font Mono"
          "Noto Color Emoji"
        ];
        emoji = [
          "Noto Color Emoji"
        ];
      };
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
          <!-- Japanese language-specific font preferences -->
          <match>
            <test name="lang" compare="contains">
              <string>ja</string>
            </test>
            <test name="family">
              <string>serif</string>
            </test>
            <edit name="family" mode="prepend">
              <string>Noto Serif CJK JP</string>
            </edit>
          </match>
          
          <match>
            <test name="lang" compare="contains">
              <string>ja</string>
            </test>
            <test name="family">
              <string>sans-serif</string>
            </test>
            <edit name="family" mode="prepend">
              <string>Noto Sans CJK JP</string>
            </edit>
          </match>
          
          <match>
            <test name="lang" compare="contains">
              <string>ja</string>
            </test>
            <test name="family">
              <string>monospace</string>
            </test>
            <edit name="family" mode="prepend">
              <string>Noto Sans Mono CJK JP</string>
            </edit>
          </match>

          <!-- Font aliases for compatibility -->
          <alias>
            <family>sans</family>
            <prefer>
              <family>sans-serif</family>
            </prefer>
          </alias>
          
          <alias>
            <family>mono</family>
            <prefer>
              <family>monospace</family>
            </prefer>
          </alias>

          <!-- Japanese font family aliases -->
          <alias>
            <family>JAPANESE-SERIF</family>
            <prefer>
              <family>Noto Serif CJK JP</family>
              <family>IPAPMincho</family>
              <family>Source Han Serif JP</family>
              <family>M+ 1c</family>
            </prefer>
          </alias>
          
          <alias>
            <family>JAPANESE-SANS</family>
            <prefer>
              <family>Noto Sans CJK JP</family>
              <family>Source Han Sans JP</family>
              <family>IPAPGothic</family>
              <family>M+ 1c</family>
            </prefer>
          </alias>
          
          <alias>
            <family>JAPANESE-MONO</family>
            <prefer>
              <family>Noto Sans Mono CJK JP</family>
              <family>IPAPGothic</family>
              <family>Source Han Sans JP</family>
              <family>M+ 1c</family>
            </prefer>
          </alias>
        </fontconfig>
      '';
    };
  };
}
