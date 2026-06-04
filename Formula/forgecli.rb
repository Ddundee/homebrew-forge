class Forgecli < Formula
  desc "Idea to product in one command"
  homepage "https://github.com/Ddundee/forge"
  url "https://github.com/Ddundee/forge/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "2a349bda652c2bc8723bb31f296bcfbd66269bdc65272c87400a721e8bd71292"
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