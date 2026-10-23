# homebrew-tools
Homebrew for personally developed tools.

```bash
brew install --cask jansim/tools/<name>   # the prebuilt app
brew install jansim/tools/<name>          # or build it from source
```

| Name | |
| --- | --- |
| [`apple-calendar-custom-url`](https://github.com/jansim/apple-calendar-custom-url) | Adds your own meeting links to Apple Calendar's video call options |
| [`doctopus`](https://github.com/jansim/doctopus) | Document manager that OCRs, indexes, tags and files a folder |
| [`smol-pdf`](https://github.com/jansim/smol-pdf) | PDF compressor, with the command-line tool `smolpdf` |

Use the full name `jansim/tools/<name>` the first time: installing a cask or formula by its full name
is how you tell Homebrew to trust it.

## Casks

Each cask installs the latest GitHub release of its app, so a plain `brew upgrade` does not notice new
ones; `brew upgrade --greedy` fetches them. The apps are ad-hoc signed, not notarized: the casks remove
the quarantine flag so macOS will open them.

## Formulae

Each formula builds a pinned release tag from source, with Xcode (16 for `smol-pdf`, 26 for the
others), and installs the app into Homebrew's prefix rather than `/Applications`; the install prints
the command that links it there. A plain `brew upgrade` picks up a new release once its formula is
updated to it, and `--HEAD` builds the latest commit instead. Built locally, the apps
carry no quarantine flag.

Install either the cask or the formula of an app, not both: for `smol-pdf` both put `smolpdf` on the
`PATH`.
