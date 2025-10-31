let
  colors = {
    bg = "#181616";
    bgAlt = "#0d0c0c";
    fg = "#DCD7BA";
    fgAlt = "#C8C093";
    base0 = "#0d0c0c";
    base1 = "#12120f";
    base2 = "#1D1C19";
    base3 = "#282727";
    base4 = "#393836";
    base5 = "#625e5a";
    base6 = "#727169";
    base7 = "#C8C093";
    base8 = "#DCD7BA";

    grey = "#727169";
    red = "#FF5D62";
    orange = "#FFA066";
    green = "#98BB6C";
    teal = "#7AA89F";
    yellow = "#E6C384";
    blue = "#7FB4CA";
    darkBlue = "#7E9CD8";
    magenta = "#957FB8";
    violet = "#9CABCA";
    cyan = "#A3D4D5";
    darkCyan = "#658594";
  };

  waveBlue1 = "#223249";
  waveBlue2 = "#2D4F67";
  boatYellow2 = "#C0A36E";

  samuraiRed = "#E82424";

  autumnGreen = "#76946A";
  autumnRed = "#C34043";
  autumnYellow = "#DCA561";
  winterGreen = "#2B3328";
  winterYellow = "#49443C";
  winterRed = "#43242B";

  lightMagenta = "#D8A8E1";
  termBlack = "#191922";
  termRed = "#d8616b";
  termGreen = "#98bb6c";
  termYellow = "#e6c384";
  termBlue = "#7FB4CA";
  termMagenta = "#957fb8";
  termCyan = "#A3D4D5";
  termWhite = "#DCD7BA";
  termBrightBlack = "#525259";
  termBrightRed = "#e18890";
  termBrightGreen = "#b1cb90";
  termBrightYellow = "#ecd2a2";
  termBrightBlue = "#9fc6d7";
  termBrightMagenta = "#b4a4cf";
  termBrightCyan = "#badedf";
  termBrightWhite = "#C8C093";
in {
  themeSpec = {
    name = "kanagawa-abyss";
    inherit colors;

    border = colors.blue; # active window border
    borderInactive = colors.base4; # inactive window border
    background = colors.bg; # primary background
    backgroundAlt = colors.bgAlt; # alternative background
    foreground = colors.fg; # primary text
    foregroundAlt = colors.fgAlt; # secondary text
    error = samuraiRed; # Bright error red
    warning = colors.yellow; # warnings
    success = colors.green; # success states
    info = colors.blue; # informational
    highlight = colors.darkBlue; # highlighted elements
    selection = waveBlue1; # Deep blue selection background
    cursor = colors.blue; # cursor color
    match = boatYellow2; # Bright yellow for search matches
    accent = colors.blue; # general purpose accent color
    active = colors.green; # active/enabled UI elements
    urgent = samuraiRed; # urgent attention (brighter than error)
    disabled = colors.grey; # disabled/inactive elements
    button = colors.blue; # buttons
    buttonHover = colors.darkBlue; # button hover state
    menu = colors.base3; # menu background
    menuSelection = waveBlue2; # Menu item selection
    tooltip = colors.base3; # tooltip background
    barBackground = colors.base0; # status bar background
    barForeground = colors.fg; # status bar text
    barAccent = colors.blue; # status bar accent
    comment = colors.grey; # code comments
    keyword = colors.blue; # language keywords
    function = colors.magenta; # function names
    string = colors.green; # string literals
    variable = lightMagenta; # lighter magenta - variables
    constant = colors.violet; # constants
    type = colors.yellow; # type names
    operator = colors.blue; # operators
    number = colors.orange; # numeric literals
    vcsAdded = autumnGreen; # Green for added lines
    vcsModified = autumnYellow; # Yellow for modified lines
    vcsDeleted = autumnRed; # Red for deleted lines
    diffAdd = winterGreen; # Dark green background for additions
    diffChange = winterYellow; # Dark yellow background for changes
    diffDelete = winterRed; # Dark red background for deletions
    terminal = {
      color0 = termBlack;
      color1 = termRed;
      color2 = termGreen;
      color3 = termYellow;
      color4 = termBlue;
      color5 = termMagenta;
      color6 = termCyan;
      color7 = termWhite;
      color8 = termBrightBlack;
      color9 = termBrightRed;
      color10 = termBrightGreen;
      color11 = termBrightYellow;
      color12 = termBrightBlue;
      color13 = termBrightMagenta;
      color14 = termBrightCyan;
      color15 = termBrightWhite;
    };
    fonts = {
      mono = "monospace";
      sans = "sans-serif";
      serif = "serif";
      size = 12;
    };
  };
}
