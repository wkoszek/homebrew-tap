# wkoszek/homebrew-tap

Homebrew formulae for my tools.

```sh
brew tap wkoszek/tap
brew install wkoszek/tap/<formula>
```

## Formulae

| Formula | Description |
|---|---|
| [`sense`](Formula/sense.rb) | Local, on-device perception CLI for macOS — `sense vision …` and `sense audio …` |

## Notes

`sense` ships as a prebuilt, Developer ID-signed and notarized universal binary
rather than building from source. macOS keys camera, microphone and
screen-recording permissions to the code signature; a locally compiled binary is
only ad-hoc signed, and its cdhash changes on every build, so permission grants
would not survive an upgrade.

> **Status:** `sense` v0.1.0 is pending its first published release. The formula
> is in place but its `sha256` is a placeholder until the notarized tarball is
> uploaded — `brew install` will not work until then.
