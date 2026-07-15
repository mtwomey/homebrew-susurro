cask "susurro" do
  version "0.1.7"
  sha256 "69ffb5482fdd10862b362b4f45e293a03480463e1f3b66b2c58a5aac061f2d58"

  url "https://github.com/mtwomey/susurro/releases/download/v#{version}/Susurro-#{version}.zip"
  name "Susurro"
  desc "Push-to-talk dictation for macOS powered by whisper.cpp"
  homepage "https://github.com/mtwomey/susurro"

  depends_on macos: :sequoia
  depends_on arch: :arm64

  app "Susurro.app", target: "~/Applications/Susurro.app"

  postflight do
    system_command "/usr/bin/xattr",
      args: ["-dr", "com.apple.quarantine", staged_path/"Susurro.app"]
    system_command "/usr/bin/xattr",
      args: ["-dr", "com.apple.provenance", staged_path/"Susurro.app"]
  end

  # tccutil can only resolve a bundle id while the app is still on disk, so
  # this must run in the `uninstall` stanza (which fires before the `app`
  # artifact is removed) rather than `zap`'s early_script (which fires
  # after removal and always fails with "No such bundle identifier").
  #
  # `uninstall` also fires during `brew upgrade`/`brew reinstall`, which
  # should NOT reset Mic/Accessibility grants (permissions should survive a
  # version bump). Only a genuine `brew uninstall` (with or without --zap)
  # should reset them. Homebrew doesn't expose that distinction to scripts,
  # so it's derived by checking the invoking brew process's own command
  # line for the literal "uninstall" subcommand -- "upgrade" and
  # "reinstall" never match that word.
  uninstall early_script: {
    executable: "/bin/sh",
    args: ["-c", "if ps -o command= -p \"$PPID\" 2>/dev/null | grep -Eq '(^|[[:space:]])uninstall([[:space:]]|$)'; then tccutil reset Accessibility com.mtwomey.susurro; tccutil reset Microphone com.mtwomey.susurro; fi; true"],
  }

  zap trash: [
    "~/Library/Application Support/Susurro",
    "~/Library/Preferences/com.mtwomey.susurro.plist",
    "~/Library/Caches/com.mtwomey.susurro",
    "~/Library/Saved Application State/com.mtwomey.susurro.savedState",
  ]
end
