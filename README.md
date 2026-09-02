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
