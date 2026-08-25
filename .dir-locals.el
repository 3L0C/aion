((nil
  . ((eglot-workspace-configuration
      . (:nixd
         (:formatting (:command ["nixfmt"])
          :nixpkgs (:expr "import (builtins.getFlake \"/home/user/aion\").inputs.nixpkgs { }")
          :options (:nixos
                    (:expr "(builtins.getFlake \"/home/user/aion\").nixosConfigurations.yuki.options")
                    :home-manager
                    (:expr "(builtins.getFlake \"/home/user/aion\").nixosConfigurations.yuki.options.home-manager.users.type.getSubOptions [ ]"))))))))
