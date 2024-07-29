{ rustPlatform, fetchzip, pkg-config }:

rustPlatform.buildRustPackage {
  pname = "berechenbarkeit";
  version = "0-unstable-2024-06-14";

  src = fetchzip {
    url = "https://punklabs.com/content/projects/ot-cryptid/downloads/OneTrickCRYPTID-Source-v1.0.2.zip";
  };

  cargoHash = "";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
  ];

  postInstall = ''
    mkdir $assets
    cp -R $src/src/assets/* $assets
  '';

  outputs = [ "out" "assets" ];
}
