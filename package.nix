{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
  nodejs_22,
}:

buildNpmPackage (finalAttrs: {
  pname = "linearis";
  version = "2025.12.3";

  src = fetchFromGitHub {
    owner = "czottmann";
    repo = "linearis";
    tag = "v${finalAttrs.version}";
    hash = "sha256-8Sz1RQJKbimPsGKUpHvqbkXnxxoUHppl4EA2+BjzryM=";
  };

  npmDepsHash = "sha256-PUXLphH82leQLHj5+BIxezKSpRiK/S9WevzK0duwo28=";

  nodejs = nodejs_22;

  meta = {
    description = "CLI tool for Linear.app with JSON output, smart ID resolution, and optimized GraphQL queries. Designed for LLM agents and humans who prefer structured data";
    homepage = "https://github.com/czottmann/linearis";
    changelog = "https://github.com/czottmann/linearis/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
    mainProgram = "linearis";
    platforms = lib.platforms.all;
  };
})
