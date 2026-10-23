# The formula for the jansim/homebrew-tools tap, which serves it as
# `brew install jansim/tools/smol-pdf`.
# It builds the tagged release from source, so it needs updating per release
# (tag and revision); a plain `brew upgrade` then picks it up.
class SmolPdf < Formula
  desc "PDF compressor"
  homepage "https://github.com/jansim/smol-pdf"
  url "https://github.com/jansim/smol-pdf.git",
      tag:      "v0.1.1",
      revision: "574c243318573bcb9818d3c5e277247fb8fa1893"
  head "https://github.com/jansim/smol-pdf.git", branch: "main"

  depends_on xcode: ["16.0", :build]
  depends_on macos: :sonoma

  uses_from_macos "zlib"

  def install
    # Homebrew already sandboxes the build, and SwiftPM can't nest its own.
    inreplace "scripts/build-app.sh", "swift build -c release", "swift build --disable-sandbox -c release"
    ENV["VERSION"] = version.to_s
    system "scripts/build-app.sh"

    prefix.install "build/smol-pdf.app"
    bin.install_symlink prefix/"smol-pdf.app/Contents/Resources/smolpdf"
  end

  def caveats
    <<~EOS
      smol-pdf.app was installed to
        #{opt_prefix}/smol-pdf.app
      To list it in /Applications:
        ln -sfn #{opt_prefix}/smol-pdf.app /Applications/smol-pdf.app
    EOS
  end

  test do
    assert_match "usage: smolpdf", shell_output("#{bin}/smolpdf --help")
    system "codesign", "--verify", "--strict", prefix/"smol-pdf.app"
  end
end
