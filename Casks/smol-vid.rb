# The cask for the jansim/homebrew-tools tap, which serves it as
# `brew install --cask jansim/tools/smol-vid`.
# It always installs the latest GitHub release, so it needs no update per
# release; `brew upgrade --greedy` picks up new ones.
cask "smol-vid" do
  version :latest
  sha256 :no_check

  url "https://github.com/jansim/smol-vid/releases/latest/download/smol-vid.zip"
  name "smol-vid"
  desc "Video compressor"
  homepage "https://github.com/jansim/smol-vid"

  # smol-vid compresses with an installed ffmpeg rather than a bundled one.
  depends_on formula: "ffmpeg"
  depends_on macos: :sonoma

  app "smol-vid.app"
  binary "#{appdir}/smol-vid.app/Contents/Resources/smolvid"

  # The app is only ad-hoc signed, not notarized, so Gatekeeper would refuse
  # to open it, and the command-line tool inside it, while they carry the
  # quarantine flag.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/smol-vid.app"]
  end

  zap trash: [
    "~/Library/Preferences/io.simson.smol-vid.plist",
    "~/Library/Saved Application State/io.simson.smol-vid.savedState",
  ]
end
