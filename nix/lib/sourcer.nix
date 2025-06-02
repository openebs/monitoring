{ lib, stdenv, git, sourcer, tag ? "" }:
let
  whitelistSource = src: allowedPrefixes:
    builtins.path {
      filter = (path: type:
        (lib.any
          (allowedPrefix:
            (lib.hasPrefix (toString (src + "/${allowedPrefix}")) path) ||
            (type == "directory" && lib.hasPrefix path (toString (src + "/${allowedPrefix}")))
          )
          allowedPrefixes)
        ## Remove unwanted files, example:
        # && path != (toString (src + "/utils/dependencies/scripts/release.sh"))
      );
      path = src;
      name = "monitoring";
    };
in
{
  inherit whitelistSource;

  git-src = whitelistSource ../../. [ ".git" ];
  repo-org = whitelistSource ../../mayastor-extensions/dependencies/control-plane/utils/dependencies/scripts [ "git-org-name.sh" ];
}
