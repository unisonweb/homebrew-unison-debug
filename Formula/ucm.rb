class Ucm < Formula
  desc "Unison Codebase Manager"
  homepage "https://unisonweb.org"

  url "https://github.com/unisonweb/unison/archive/refs/tags/release/M2f.tar.gz"
  version "1.0.M2f"
  sha256 "c566e7b549a264a8791bd3911e8e2ba2d29de471c056b6678f566c7b3fe8a457"
  license "MIT"

  head "https://github.com/unisonweb/unison.git"

  depends_on "ghc@8.10" => :build
  depends_on "haskell-stack" => :build
  depends_on "less"
  depends_on "ucm-codebase-ui"

  def install
    system "stack", "build", "--dependencies-only", "--system-ghc"
    system "stack", "install", "--system-ghc",
                    "--local-bin-path", "dist",
                    "--flag", "unison-parser-typechecker:optimized",
                    "--flag", "unison-core1:optimized",
                    "--ghc-options=-O2 -funbox-strict-fields"
    prefix.install "dist/unison"
    prefix.install_symlink Formula["ucm-codebase-ui"].opt_share => "ui"
    bin.install_symlink prefix/"unison" => "ucm"
  end

  test do
    (testpath/"getbase.md").write <<~EOS
      ```ucm
      .> pull https://github.com/unisonweb/base:.releases._latest .base
      ```
    EOS
    system "ucm", "transcript", testpath/"getbase.md"
  end
end
