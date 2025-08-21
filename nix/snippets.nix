# Init snippets for the shells with no system-level interactive-init hook on
# NixOS / nix-darwin (nushell, elvish, murex). Plain strings that invoke `cade`
# from PATH, so this needs no package/pkgs. Shared by the system module's
# `programs.cade.shellSnippets` and the flake's `lib.shellSnippets`.
{
  nushell = ''
    mkdir ~/.cache/cade
    cade hook nushell | save --force ~/.cache/cade/hook.nu
    source ~/.cache/cade/hook.nu
  '';
  elvish = "eval (cade hook elvish | slurp)\n";
  murex = "cade hook murex -> source\n";
}
