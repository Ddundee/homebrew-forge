class Forgecli < Formula
  desc "Idea to product in one command"
  homepage "https://github.com/Ddundee/forge"
  url "https://github.com/Ddundee/forge/archive/refs/tags/v0.2.8.tar.gz"
  sha256 "c2297f054d35000925d6e908bf6b0edb576b6f6806c0cc10ad5e66ae21d0c585"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "ci"
    system "npm", "run", "build"
    libexec.install Dir["*"]
    node = Formula["node"].opt_bin/"node"
    (bin/"forgecli").write <<~EOS
      #!/usr/bin/env bash
      exec "#{node}" "#{libexec}/dist/cli.js" "$@"
    EOS
    chmod "+x", bin/"forgecli"
  end

  test do
    assert_match "build", shell_output("#{bin}/forgecli --help")
  end
end