{
  programs.git = {
    settings = {
      user = {
        name = "3L0C";
        email = "141392286+3L0C@users.noreply.github.com";
      };
      github.user = "3L0C";
    };

    includes = [
      {
        condition = "gitdir:~/programs/Anskrevy/";
        contents = {
          user = {
            name = "Anskrevy";
            email = "95379591+Anskrevy@users.noreply.github.com";
          };
        };
      }
      {
        condition = "gitdir:~/programs/CSUG/";
        contents = {
          user = {
            name = "CSUG-Cole";
            email = "146023803+CSUG-Cole@users.noreply.github.com";
          };
        };
      }
    ];
  };
}
