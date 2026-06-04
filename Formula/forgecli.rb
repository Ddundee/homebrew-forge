class Forgecli < Formula
  desc "Idea to product in one command"
  homepage "https://github.com/Ddundee/forge"
  url "https://github.com/Ddundee/forge/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "2056dc2d39b6aceb631ae435e47c2f5b5e9ff773aa1f020410a58825a8d02aaf"
  license "MIT"

  depends_on "node"
  depends_on "python3" => :build

  def install
    system "npm", "ci"
    system "npm", "run", "build"
    libexec.install Dir["*"]
    chmod "+x", libexec/"dist/cli.js"
    bin.install_symlink libexec/"dist/cli.js" => "forgecli"
  end

  test do
    assert_match "build", shell_output("#{bin}/forgecli --help")
  end
end