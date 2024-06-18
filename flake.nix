{
  description = "Launch Blade of Agony";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: let
    pkgs = import nixpkgs { system = "x86_64-linux"; };

    makeGzWrapper = iwad: pkgs.writeShellScriptBin "gz-wrapper-${builtins.replaceStrings ["/" ":" "."] ["_" "_" "_"] iwad}" ''
      exec ${pkgs.gzdoom}/bin/gzdoom -file aim_assist_0.8.0.pk3 -joy_dinput 0 -joy_xinput 1 -width 1920 -height 1080 -vid_refreshrate 60 -fullscreen 1 -iwad ${iwad}
    '';

    gzdoomApp = iwad: {
      type = "app";
      program = "${makeGzWrapper iwad}/bin/gz-wrapper-${builtins.replaceStrings ["/" ":" "."] ["_" "_" "_"] iwad}";
    };
  in {
    defaultPackage.x86_64-linux = makeGzWrapper "HERETIC.WAD";

    apps.x86_64-linux = {
      heretic = gzdoomApp "HERETIC.WAD";
      hexen = gzdoomApp "HEXEN.WAD";
      chex1 = gzdoomApp "CHEX.WAD";
      chex2 = gzdoomApp "CHEX2.WAD";
      chex3 = gzdoomApp "chex3.wad";
      strife = gzdoomApp "strife1.wad";
    };
  };
}

