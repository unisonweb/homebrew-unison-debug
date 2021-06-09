class Ucm < Formula
  desc "Unison Codebase Manager"
  homepage "https://unisonweb.org"

  url "https://github.com/unisonweb/unison/archive/refs/tags/release/M2g.tar.gz"
  version "1.0.M2g"
  sha256 "a4abc27a02aa1bb3552c57079403d6d6c87cddc70767d40be002c7bb61b9b706"
  license "MIT"

  head "https://github.com/unisonweb/unison.git"

  depends_on "ghc@8.10" => :build
  depends_on "haskell-stack" => :build
  depends_on "llvm" => :build
  depends_on "less"
  depends_on "ucm-codebase-ui"

  def install
    system "stack", "build", "--dependencies-only", "--system-ghc", "--skip-ghc-check"
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
