{pkgs, ...}: {
  programs.gpg = {
    enable = true;
    settings = {
      # Prefer strong algorithms
      personal-cipher-preferences = "AES256 AES192 AES";
      personal-digest-preferences = "SHA512 SHA384 SHA256";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
      # Display preferences
      keyid-format = "0xlong";
      with-fingerprint = true;
      # Behavior
      no-emit-version = true;
      no-comments = true;
      # Trust model
      trust-model = "tofu+pgp";
    };
  };

  services.gpg-agent = {
    enable = true;
    # Cache passphrases for 1 hour
    defaultCacheTtl = 3600;
    maxCacheTtl = 7200;
    # Use pinentry for passphrase entry
    pinentry.package = pkgs.pinentry-qt;
  };
}
