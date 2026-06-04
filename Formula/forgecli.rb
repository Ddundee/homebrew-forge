class Forgecli < Formula
  desc "Idea to product in one command"
  homepage "https://github.com/Ddundee/forge"
  url "https://github.com/Ddundee/forge/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "PLACEHOLDER"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "ci", "--ignore-scripts"
    system "npm", "run", "build"
    libexec.install Dir["*"]
    chmod "+x", libexec/"dist/cli.js"
    bin.install_symlink libexec/"dist/cli.js" => "forgecli"
  end

  test do
    assert_match "build", shell_output("#{bin}/forgecli --help")
  end
end
