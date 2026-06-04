class Forgecli < Formula
  desc "Idea to product in one command"
  homepage "https://github.com/Ddundee/forge"
  url "https://github.com/Ddundee/forge/archive/refs/tags/v0.2.4.tar.gz"
  sha256 "d3c4ff5511f988ee68675ac1da817b56d0ddf4f3a5311b8dba4b73acf63c01f6"
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