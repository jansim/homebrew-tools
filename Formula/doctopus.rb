# The formula for the jansim/homebrew-tools tap, which serves it as
# `brew install jansim/tools/doctopus`.
# It builds the tagged release from source, so it needs updating per release
# (tag and revision); a plain `brew upgrade` then picks it up.
class Doctopus < Formula
  desc "Document manager that OCRs, indexes, tags and files a folder"
  homepage "https://github.com/jansim/doctopus"
  url "https://github.com/jansim/doctopus.git",
      tag:      "v0.1",
      revision: "4e2c4a4884670b6d4c96fa2c2ef1d09dc881b438"
  head "https://github.com/jansim/doctopus.git", branch: "main"

  # Releases are built for Apple silicon only.
  depends_on arch: :arm64
  # The macOS 26 SDK, for FoundationModels; the app itself runs on Sequoia.
  depends_on xcode: ["26.0", :build]
  depends_on macos: :sequoia

  def install
    system "/usr/libexec/PlistBuddy", "-c", "Set :CFBundleShortVersionString #{version}", "Resources/Info.plist"
    # Homebrew already sandboxes the build, and SwiftPM can't nest its own.
    system "Scripts/build.sh", "release", "--disable-sandbox"

    prefix.install "build/Doctopus.app"
  end

  def caveats
    <<~EOS
      Doctopus.app was installed to
        #{opt_prefix}/Doctopus.app
      To list it in /Applications:
        ln -sfn #{opt_prefix}/Doctopus.app /Applications/Doctopus.app
    EOS
  end

  test do
    system "codesign", "--verify", "--strict", prefix/"Doctopus.app"
    assert_path_exists prefix/"Doctopus.app/Contents/Resources/Assets.car"
  end
end
