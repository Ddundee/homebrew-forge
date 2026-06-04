class Forgecli < Formula
  desc "Idea to product in one command"
  homepage "https://github.com/Ddundee/forge"
  url "https://github.com/Ddundee/forge/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "PLACEHOLDER"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "ci"
    system "npm", "run", "build"
    libexec.install Dir["*"]
    (bin/"forgecli").write <<~EOS
      #!/usr/bin/env bash
      node_major=$(node -e "process.stdout.write(process.version.slice(1).split('.')[0])" 2>/dev/null)
      if [ -n "$node_major" ] && [ "$node_major" -lt 23 ]; then
        exec node --experimental-sqlite "#{libexec}/dist/cli.js" "$@"
      else
        exec node "#{libexec}/dist/cli.js" "$@"
      fi
    EOS
    chmod "+x", bin/"forgecli"
  end

  test do
    assert_match "build", shell_output("#{bin}/forgecli --help")
  end
end