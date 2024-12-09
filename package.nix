{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "syspower";
  src = pkgs.fetchFromGitHub {
    owner = "System64Fumo";
    repo = "syspower";
    rev = "b205c3443daaee6c3454f23b93b78f42c10221a1";
    hash = "sha256-kLaWIaMTRurY7a8Nn7C9ft/Zdvx35AiU7Db8n/NFy90=";
  };

  buildInputs = with pkgs; [gtkmm4 gtk4-layer-shell];
  nativeBuildInputs = with pkgs; [
    pkg-config
    makeWrapper
  ];

  installPhase = ''
    install -D -t $out/bin syspower
    install -D -t $out/lib libsyspower.so
    install -D -t $out/share/sys64/power config.conf style.css
    wrapProgram $out/bin/syspower --prefix LD_LIBRARY_PATH : $out/lib
  '';
}
