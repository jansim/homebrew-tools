# homebrew-tools
Homebrew for personally developed tools.

```bash
brew install --cask jansim/tools/<name>
```

| Cask | |
| --- | --- |
| [`apple-calendar-custom-url`](https://github.com/jansim/apple-calendar-custom-url) | Adds your own meeting links to Apple Calendar's video call options |
| [`doctopus`](https://github.com/jansim/doctopus) | Document manager that OCRs, indexes, tags and files a folder |
| [`smol-pdf`](https://github.com/jansim/smol-pdf) | PDF compressor, with the command-line tool `smolpdf` |

Use the full name `jansim/tools/<name>` the first time: installing a cask by its full name is how you
tell Homebrew to trust it.

Each cask installs the latest GitHub release of its app, so a plain `brew upgrade` does not notice new
ones; `brew upgrade --greedy` fetches them. The apps are ad-hoc signed, not notarized: the casks remove
the quarantine flag so macOS will open them.
