class Forgecli < Formula
  desc "Idea to product in one command"
  homepage "https://github.com/Ddundee/forge"
  url "https://github.com/Ddundee/forge/archive/refs/tags/v0.1.8.tar.gz"
  sha256 "1b84857d876e1c255ad9e9e8f30d95355d5152c60ca993e4cd6feb8cce955c24"
  license "MIT"

  depends_on "python@3.11"

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
