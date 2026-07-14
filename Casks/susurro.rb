cask "susurro" do
  version "0.1.6"
  sha256 "ac3240dd2729243aa03c5b803adf55e1d6f5267f2b7d147582b9b9fad9f662d6"

  url "https://github.com/mtwomey/susurro/releases/download/v#{version}/Susurro-#{version}.zip"
  name "Susurro"
  desc "Push-to-talk dictation for macOS powered by whisper.cpp"
  homepage "https://github.com/mtwomey/susurro"

  depends_on macos: :sequoia
  depends_on arch: :arm64

  app "Susurro.app", target: "~/Applications/Susurro.app"

  zap trash: [
    "~/Library/Application Support/Susurro",
    "~/Library/Preferences/com.mtwomey.susurro.plist",
    "~/Library/Caches/com.mtwomey.susurro",
    "~/Library/Saved Application State/com.mtwomey.susurro.savedState",
  ]
end
