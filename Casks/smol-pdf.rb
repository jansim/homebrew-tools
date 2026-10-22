# The cask for the jansim/homebrew-tools tap, which serves it as
# `brew install --cask jansim/tools/smol-pdf`.
# It always installs the latest GitHub release, so it needs no update per
# release; `brew upgrade --greedy` picks up new ones.
cask "smol-pdf" do
  version :latest
  sha256 :no_check

  url "https://github.com/jansim/smol-pdf/releases/latest/download/smol-pdf.zip"
  name "smol-pdf"
  desc "PDF compressor"
  homepage "https://github.com/jansim/smol-pdf"

  depends_on macos: :sonoma

  app "smol-pdf.app"
  binary "#{appdir}/smol-pdf.app/Contents/Resources/smolpdf"

  # The app is only ad-hoc signed, not notarized, so Gatekeeper would refuse
  # to open it, and the command-line tool inside it, while they carry the
  # quarantine flag.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/smol-pdf.app"]
  end

  zap trash: [
    "~/Library/Preferences/io.simson.smol-pdf.plist",
    "~/Library/Saved Application State/io.simson.smol-pdf.savedState",
  ]
end
