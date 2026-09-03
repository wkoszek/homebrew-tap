class Sense < Formula
  desc "Local, on-device perception CLI for macOS: images, audio, screen and camera"
  homepage "https://github.com/wkoszek/sense"
  url "https://github.com/wkoszek/sense/releases/download/v3.2.0/sense-3.2.0-macos-universal.tar.gz"
  sha256 "d2caba37c0f1cd8a399184c6805f042b8713fa76aac6950d4fb62826918883ef"
  license "MIT"

  # Ships as a prebuilt, Developer ID-signed, notarized universal binary rather
  # than building from source. This is deliberate: macOS keys camera, microphone
  # and screen-recording grants to the code signature, and a locally compiled
  # binary is only ad-hoc signed — its cdhash changes on every build, so every
  # `brew upgrade` would re-prompt for permissions.
  depends_on arch: [:arm64, :x86_64]
  depends_on macos: :sequoia

  def install
    bin.install "sense"
  end

  def caveats
    <<~EOS
      sense runs entirely on-device.

      Commands that touch the camera, screen or microphone need a one-time
      permission grant. Get the camera and screen prompts over with:

        sense vision doctor --request

      The microphone and speech-recognition prompts appear the first time you
      run `sense audio record` or `sense audio transcribe`.

      On-device transcription needs a dictation language model installed under
      System Settings > Keyboard > Dictation.

      For much better text-to-speech, download the free premium voices:

        sense audio voices --install

      To hear the difference first, `sense audio samples --open` writes a
      self-contained page comparing them.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sense --version")

    # Exercises a real framework round-trip (AVSpeechSynthesizer -> file) without
    # needing any permission grant, so it passes unattended in CI.
    system bin/"sense", "audio", "talk", "-o", testpath/"hello.wav", "hello there"
    assert_path_exists testpath/"hello.wav"
    assert_match "PCM", shell_output("#{bin}/sense audio info #{testpath}/hello.wav")

    # The signature is the reason this formula ships a prebuilt binary at all:
    # if Homebrew ever strips or re-signs it, permission grants stop surviving
    # upgrades and this catches it.
    assert_match "QQ5A9Q7C7Z", shell_output("codesign -dv --verbose=2 #{bin}/sense 2>&1")
  end
end
