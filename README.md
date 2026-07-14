# homebrew-susurro

Homebrew tap for [Susurro](https://github.com/mtwomey/susurro) — push-to-talk dictation for macOS powered by whisper.cpp.

## Install

```bash
brew install --cask mtwomey/susurro/susurro
```

That's it. Homebrew handles the quarantine flag automatically — no "Open Anyway" dance required.

## Requirements

- Apple Silicon Mac (arm64)
- macOS 15 Sequoia or later

## Uninstall

```bash
brew uninstall --cask susurro
```

To also remove all app data (models, preferences, rules):

```bash
brew uninstall --zap --cask susurro
```

## Updating

```bash
brew upgrade --cask susurro
```

## Manual tap (if needed)

```bash
brew tap mtwomey/susurro
brew install --cask susurro
```
