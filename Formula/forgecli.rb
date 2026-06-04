class Forgecli < Formula
  desc "Idea to product in one command"
  homepage "https://github.com/Ddundee/forge"
  url "https://github.com/Ddundee/forge/archive/refs/tags/v0.2.7.tar.gz"
  sha256 "34663258363c456108b9e20323989b64190720246c38d586261acd65cecd31f1"
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