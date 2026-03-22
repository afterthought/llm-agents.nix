{
  lib,
  flake,
  rustPlatform,
  fetchFromGitHub,
  perl,
  versionCheckHook,
  versionCheckHomeHook,
}:

rustPlatform.buildRustPackage rec {
  pname = "subcog";
  version = "0.15.1";

  src = fetchFromGitHub {
    owner = "zircote";
    repo = "subcog";
    tag = "v${version}";
    hash = "sha256-599+hXG1eDWQsGEZpi2xoIgxIXIuPkzzfw0QG7L59yo=";
  };

  cargoHash = "sha256-3nxXZ1jQzZH6Tm4VL0N64nN/G7wuZsJHeqbEk4KIDm4=";

  # perl is needed by vendored OpenSSL (via git2 crate) build
  nativeBuildInputs = [ perl ];

  # Tests require network access and database connections
  doCheck = false;

  doInstallCheck = true;
  nativeInstallCheckInputs = [
    versionCheckHook
    versionCheckHomeHook
  ];

  passthru.category = "AI Assistants";

  meta = with lib; {
    description = "Persistent memory system for AI coding assistants with hybrid search and knowledge graph";
    homepage = "https://github.com/zircote/subcog";
    changelog = "https://github.com/zircote/subcog/releases/tag/v${version}";
    license = licenses.mit;
    sourceProvenance = with sourceTypes; [ fromSource ];
    maintainers = with flake.lib.maintainers; [ afterthought ];
    mainProgram = "subcog";
    platforms = platforms.all;
  };
}
