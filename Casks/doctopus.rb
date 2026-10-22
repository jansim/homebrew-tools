# The cask for the jansim/homebrew-tools tap, which serves it as
# `brew install --cask jansim/tools/doctopus`.
# It always installs the latest GitHub release, so it needs no update per
# release; `brew upgrade --greedy` picks up new ones.
cask "doctopus" do
  version :latest
  sha256 :no_check

  url "https://github.com/jansim/doctopus/releases/latest/download/Doctopus.zip"
  name "Doctopus"
  desc "Document manager that OCRs, indexes, tags and files a folder"
  homepage "https://github.com/jansim/doctopus"

  # Releases are built for Apple silicon only.
  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "Doctopus.app"

  # The app is only ad-hoc signed, not notarized, so Gatekeeper would refuse
  # to open it while it carries the quarantine flag.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Doctopus.app"]
  end

  # Libraries stay: each is a `*.doctopus` package inside the folder it indexes.
  zap trash: [
    "~/Library/Preferences/io.doctopus.app.plist",
    "~/Library/Saved Application State/io.doctopus.app.savedState",
  ]
end
