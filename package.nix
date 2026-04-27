{
  lib,
  fetchurl,
  buildNpmPackage,
  nodejs_22,
  fetchFromGitHub,
  importNpmLock,
}:
buildNpmPackage (finalAttrs: {
  pname = "linearis";
  version = "2026.4.9";

  src = fetchurl {
    url = "https://registry.npmjs.org/${finalAttrs.pname}/-/${finalAttrs.pname}-${finalAttrs.version}.tgz";
    hash = "sha256-Q7niwbiDI/SBQ1zuL98rqcJl5gIreWKrFQCuhHbk4NE=";
  };

  lockSrc = fetchFromGitHub {
    owner = "czottmann";
    repo = "linearis";
    tag = "v${finalAttrs.version}";
    hash = "sha256-xWg/fBDM5nOl1NmzeexI9pvSCVanTYz6QdsscHVpORc=";
  };

  npmDeps = importNpmLock {
    pname = finalAttrs.pname;
    version = finalAttrs.version;

    # Parsed JSON from the matching GitHub tag
    package = builtins.fromJSON (builtins.readFile "${finalAttrs.lockSrc}/package.json");
    packageLock = builtins.fromJSON (builtins.readFile "${finalAttrs.lockSrc}/package-lock.json");
  };

  npmConfigHook = importNpmLock.npmConfigHook;

  postPatch = ''
    cp ${finalAttrs.lockSrc}/package-lock.json ./package-lock.json
  '';

  npmDepsHash = "sha256-PUXLphH82leQLHj5+BIxezKSpRiK/S9WevzK0duwo28=";

  nodejs = nodejs_22;

  dontNpmBuild = true;

  npmFlags = [ "--ignore-scripts" ];

  meta = {
    description = "CLI tool for Linear.app with JSON output, smart ID resolution, and optimized GraphQL queries. Designed for LLM agents and humans who prefer structured data";
    homepage = "https://github.com/czottmann/linearis";
    changelog = "https://github.com/czottmann/linearis/blob/v${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.mit;
    mainProgram = "linearis";
    platforms = lib.platforms.all;
  };
})
