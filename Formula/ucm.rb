class Ucm < Formula
  desc "Unison Codebase Manager"
  homepage "https://unisonweb.org"

  url "https://github.com/unisonweb/unison/archive/refs/tags/release/M2f.tar.gz"
  version "1.0.M2f"
  sha256 "c566e7b549a264a8791bd3911e8e2ba2d29de471c056b6678f566c7b3fe8a457"
  license "MIT"

  head "https://github.com/unisonweb/unison.git"

  bottle do
    root_url "https://github.com/unisonweb/homebrew-unison-debug/releases/download/ucm-1.0.M2f"
    sha256 cellar: :any_skip_relocation, big_sur:      "75c9998f0d3e4d2687b7dfed927b3aab7f1754279bbd118e7d55de7a2a67e7be"
    sha256 cellar: :any_skip_relocation, catalina:     "387a78cae5fdefc1f7478312cc362103b43c20a855d310849a67c2927ecb9f39"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b5e2e506e9138fdd4cc5ef9e9d4ba062315af7865e6e265370fc28e314ff83ec"
  end

  depends_on "ghc@8.10" => :build
  depends_on "haskell-stack" => :build
  depends_on "less"
  depends_on "llvm" => :build
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
