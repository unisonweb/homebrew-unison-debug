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
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur:      "5e6e2cedba152dcc17da4e386c3989c6ab54caf5d04824579fa7310f9e3aab9e"
    sha256 cellar: :any_skip_relocation, catalina:     "d9126e8a3d0b8c69ce647f529b495b33db045d7130ffc44b281583f18df6053a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f26c11d154592b1577dda2e717194a5924d639c93196b1e3db9b63915c4432eb"
  end

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
