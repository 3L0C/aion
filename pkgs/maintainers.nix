# Maintainer entries in the nixpkgs `lib.maintainers` shape (attrset with
# `name`, not a bare string). nix-update reads `maintainer["name"]` and
# crashes on the bare-string style.
{
  threeloc = {
    name = "3L0C";
    github = "3L0C";
    githubId = 141392286;
  };
}
