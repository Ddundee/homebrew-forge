class Forgecli < Formula
  desc "Idea to product in one command"
  homepage "https://github.com/Ddundee/forge"
  url "https://github.com/Ddundee/forge/archive/refs/tags/v0.1.10.tar.gz"
  sha256 "9bb8c41821ce0055ead587a32374fc9c746fbd1afe07bcaad9b4b98e9cd33976"
  license "MIT"

  depends_on "python@3.11"

  skip_clean "libexec/venv"

  def install
    python = Formula["python@3.11"].opt_bin/"python3.11"
    venv = libexec/"venv"
    system python, "-m", "venv", venv
    system venv/"bin/pip", "install", "--upgrade", "pip", "--quiet"
    system venv/"bin/pip", "install", "--no-cache-dir", buildpath, "--quiet"
    bin.install_symlink venv/"bin/forgecli"
  end

  test do
    assert_match "Idea to product", shell_output("#{bin}/forgecli --help")
  end
end
