{ stdenv, callPackage, fetchurl, makeFontsConf, gnome2 }:

let
  mkStudio = opts: callPackage (import ./common.nix opts) {
    fontsConf = makeFontsConf {
      fontDirectories = [];
    };
    inherit (gnome2) GConf gnome_vfs;
  };
  latestVersion = {
    version = "3.2.0.9"; # "Android Studio 3.2 Canary 10"
    build = "181.4705630";
    sha256Hash = "07xf00f0wvrk576iaqn7qpcpgar432n6q3jlgpslhm4m1cww3sww";
  };
in rec {
  # Old alias
  preview = beta;

  # Attributes are named by the corresponding release channels

  stable = mkStudio {
    pname = "android-studio";
    #pname = "android-studio-stable"; # TODO: Rename and provide symlink
    version = "3.1.0.16"; # "Android Studio 3.1"
    build = "173.4670197";
    sha256Hash = "1i0ldyadrcyy5pl9vjpm2k755mf08xi9x5qz8655qsbiajzqf9fy";

    meta = with stdenv.lib; {
      description = "The Official IDE for Android (stable channel)";
      longDescription = ''
        Android Studio is the official IDE for Android app development, based on
        IntelliJ IDEA.
      '';
      homepage = https://developer.android.com/studio/index.html;
      license = licenses.asl20;
      platforms = [ "x86_64-linux" ];
      maintainers = with maintainers; [ primeos ];
    };
  };

  beta = mkStudio {
    pname = "android-studio-preview";
    #pname = "android-studio-beta"; # TODO: Rename and provide symlink
    version = "3.1.0.16"; # "Android Studio 3.1"
    build = "173.4670197";
    sha256Hash = "1i0ldyadrcyy5pl9vjpm2k755mf08xi9x5qz8655qsbiajzqf9fy";

    meta = stable.meta // {
      description = "The Official IDE for Android (beta channel)";
      homepage = https://developer.android.com/studio/preview/index.html;
    };
  };

  dev = mkStudio (latestVersion // {
    pname = "android-studio-dev";

    meta = beta.meta // {
      description = "The Official IDE for Android (dev channel)";
    };
  });

  canary = mkStudio (latestVersion // {
    pname = "android-studio-canary";

    meta = beta.meta // {
      description = "The Official IDE for Android (canary channel)";
    };
  });
}
