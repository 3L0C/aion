{pkgs, ...}: {
  home.packages = with pkgs; [
    file # Program that shows the type of files

    microcode-amd # Microcode update image for AMD CPUs
    ocl-icd # OpenCL ICD Bindings

    alsa-utils # Advanced Linux Sound Architecture - Utilities
    alsa-plugins # Additional ALSA plugins
    sof-firmware # Sound Open Firmware
    xorg.libXft # FreeType-based font drawing library for X

    wget # Network utility to retrieve files from the web
    curl # command line tool and library for transferring data with URLs
    rsync # A fast and versatile file copying tool for remote and local files
    tree # A directory listing program displaying a depth indented list of files
    findutils # GNU utilities to locate files
    gnugrep # A string search utility
    gnused # GNU stream editor
    gawk # GNU version of awk
    gettext # GNU internationalization library
    gzip # GNU compression utility
    zip # Compressor/archiver for creating and modifying zipfiles
    unzip # For extracting and viewing files in .zip archives
    unrar # The RAR uncompression program
    atool # A script for managing file archives of various types
    dosfstools # DOS filesystem utilities
    ntfs3g # NTFS filesystem driver and utilities
    gvfs # Virtual filesystem implementation for GIO
    smbnetfs # Virtual filesystem implementation for GIO - SMB/CIFS backend (Windows file sharing)
    cifs-utils # For mount.cifs, required unless domain name resolution is not needed
    simple-mtpfs # A FUSE filesystem that supports reading/writing from MTP devices
    sshfs # FUSE client based on the SSH File Transfer Protocol

    inetutils # A collection of common network programs
    net-tools # Configuration tools for Linux networking
    iproute2 # Collection of utilities for controlling TCP/IP networking and traffic control in Linux
    netcat-openbsd # TCP/IP swiss army knife. OpenBSD variant
    socat # Multipurpose relay

    iptables # Linux kernel packet control tool
    ipset # Administration tool for IP sets
    wireguard-tools # next generation secure network tunnel - tools for configuration
    openssh # SSH protocol implementation for remote login, command execution and file transfer
    lshw # A small tool to provide detailed information on the hardware configuration of the machine
    dmidecode # Desktop Management Interface table related utilities
    avahi # Service Discovery for Linux using mDNS/DNS-SD (compatible with Bonjour)
    nssmdns # glibc plugin providing host name resolution via mDNS
    dict # Online dictionary client and server
    cups # OpenPrinting CUPS - daemon package

    moreutils # A growing collection of the unix tools that nobody thought to write thirty years ago
    trash-cli # Command line trashcan (recycle bin) interface
    dialog # A tool to display dialog boxes from shell scripts
    man # A utility for reading man pages
    man-pages # Linux man pages
    texinfo # GNU documentation system for on-line information and printed output
    groff # GNU troff text-formatting system
    tldr # Command line client for tldr, a collection of simplified man pages

    qemu # Generic and open source machine emulator and virtualizer
    libguestfs # Access and modify virtual machine disk images
    vde2 # Virtual Distributed Ethernet for emulators like qemu
    wineWowPackages.waylandFull # Support both 32-bit and 64-bit applications
    winetricks # Script to install various redistributable runtime libraries in Wine

    fdupes # a program for identifying or deleting duplicate files residing within specified directories
    rmlint # remove duplicates and other lint (without-gui)

    wlr-randr # Utility to manage outputs of a Wayland compositor
    xdg-user-dirs # Manage user directories like ~/Desktop and ~/Music
    xdg-utils # Command line tools that assist applications with a variety of desktop integration tasks

    mtools # A collection of utilities to access MS-DOS disks
    gnupatch # A utility to apply patch files to original sources
    perl540Packages.FileMimeInfo # Determine file type, includes mimeopen and mimetype
    perl540Packages.TermReadKey # Provides simple control over terminal driver modes
    jq # Command-line JSON processor
    jqp # TUI playground to experiment with jq
    lynx # A text browser for the World Wide Web
    nfs-utils # Support programs for Network File Systems
    sfeed # RSS and Atom parser
    abook # Text-based addressbook designed for use with Mutt
    xidel # Command line tool to process HTML/XML/JSON locally or from online sources
  ];
}
