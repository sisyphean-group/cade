#!@nu@/bin/nu
# direnv shim, nushell flavour. behaviour matches direnv-compat.bash: relay
# cade's own json/shell output so no json is serialised here

def main [cmd?: string = "", target?: string = ""] {
  match $cmd {
    "export" => {
      let want = (if ($target | is-empty) { "bash" } else { $target })
      match $want {
        "json" => {
          let out = (^@cade@ reload --shell json | complete | get stdout | str trim)
          if ($out | is-empty) { "{}" } else { $out }
        }
        "bash" | "zsh" | "fish" | "nushell" | "nu" => {
          try { ^@cade@ reload --shell $want }
        }
        _ => {}
      }
    }
    "hook" => {
      ^@cade@ hook (if ($target | is-empty) { "bash" } else { $target })
    }
    "allow" | "permit" | "grant" => { ^@cade@ allow }
    "deny" | "block" | "revoke" => { ^@cade@ disallow }
    "status" => { ^@cade@ status }
    "version" => { print "2.34.0" }
    _ => {}
  }
}
