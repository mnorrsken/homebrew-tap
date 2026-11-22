cask "scn3" do
  version "0.9.7"
  sha256 "6a44f996c0706e29b1a6330bec4e34b4d3ff227c6b2bc4fe1b0097502f780acd"

  url "https://github.com/mnorrsken/scn3/releases/download/v#{version}/scn3-#{version}.dmg"
  name "scn3 Disk Sunburst"
  desc "Show disk usage as a sunburst chart"
  homepage "https://github.com/mnorrsken/scn3"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "scn3.app"

  # The app is not signed with an Apple Developer ID yet, so Gatekeeper would
  # block it. Homebrew no longer has --no-quarantine, so remove the flag here.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/scn3.app"],
        writable_paths: ["{{appdir}}/scn3.app"]
  end

  zap trash: [
    "~/Library/Application Support/scn3",
    "~/Library/Caches/com.mnorrsken.scn3",
    "~/Library/WebKit/com.mnorrsken.scn3",
  ]
end
