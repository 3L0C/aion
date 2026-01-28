((nil
  . ((eglot-workspace-configuration
      . (:nixd
         (:formatting (:command ["alejandra"])
          :nixpkgs (:expr "import (builtins.getFlake \"/home/user/aion\").inputs.nixpkgs { }")
          :options (:nixos (:expr "(builtins.getFlake \"/home/user/aion\").nixosConfigurations.yuki.options")
                    :home-manager (:expr "(builtins.getFlake \"/home/user/aion\").homeConfigurations.\"user@yuki\".options"))))))))
