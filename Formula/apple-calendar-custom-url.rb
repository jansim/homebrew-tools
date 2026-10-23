# The formula for the jansim/homebrew-tools tap, which serves it as
# `brew install jansim/tools/apple-calendar-custom-url`.
# It builds the tagged release from source, so it needs updating per release
# (tag and revision); a plain `brew upgrade` then picks it up.
class AppleCalendarCustomUrl < Formula
  desc "Adds your own meeting links to Apple Calendar's video call options"
  homepage "https://github.com/jansim/apple-calendar-custom-url"
  url "https://github.com/jansim/apple-calendar-custom-url.git",
      tag:      "v0.1",
      revision: "3bb77362abde24b6b9930174b1b6880d7fe49a1f"
  head "https://github.com/jansim/apple-calendar-custom-url.git", branch: "main"

  # The macOS 26 SDK, and actool for its Icon Composer icons; the app itself
  # runs on Sonoma.
  depends_on xcode: ["26.0", :build]
  depends_on macos: :sonoma

  def install
    ["Resources/Info.plist", "Resources/Extension/Info.plist"].each do |plist|
      system "/usr/libexec/PlistBuddy", "-c", "Set :CFBundleShortVersionString #{version}", plist
    end
    # Homebrew already sandboxes the build, and SwiftPM can't nest its own.
    system "Scripts/build.sh", "release", "--disable-sandbox"

    prefix.install "build/CustomCalendarURL.app"
  end

  def caveats
    <<~EOS
      CustomCalendarURL.app was installed to
        #{opt_prefix}/CustomCalendarURL.app
      To list it in /Applications:
        ln -sfn #{opt_prefix}/CustomCalendarURL.app /Applications/CustomCalendarURL.app
      Open it once, and again after each upgrade, so Calendar finds its extension.
    EOS
  end

  test do
    system prefix/"CustomCalendarURL.app/Contents/MacOS/CustomCalendarURL", "--selftest"
  end
end
