{
  description = "Python development setup with Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; }; in {
      devShell = with pkgs;
         mkShell {
            packages = [ 
              gtk4
              libadwaita
              gst_all_1.gstreamer
              # Common plugins like "filesrc" to combine within e.g. gst-launch
              gst_all_1.gst-plugins-base
              # Specialized plugins separated by quality
              gst_all_1.gst-plugins-good
              gst_all_1.gst-plugins-bad
              gst_all_1.gst-plugins-ugly
              pkgs.python311 # installs python311
              pkgs.python311Packages.pygobject3
              pkgs.python311Packages.ytmusicapi
              pkgs.python311Packages.yt-dlp
              pkgs.python311Packages.requests
            ];
          shellHook = ''
            python --version
          '';
         };
      }
   );
}
