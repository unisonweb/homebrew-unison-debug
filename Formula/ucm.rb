class Ucm < Formula
  desc "Unison Codebase Manager"
  homepage "https://unisonweb.org"

  url "https://github.com/unisonweb/unison/archive/refs/tags/release/M2.tar.gz"
  version "1.0.M2"
  sha256 "b39921cf3205eca2b30b921f85589b9bfa4894c21e32e339b277c2a7497cf1cf"
  license "MIT"

  head "https://github.com/unisonweb/unison.git"

  bottle do
    root_url "https://github.com/aryairani/homebrew-unison/releases/download/ucm-1.0.M2"
    sha256 cellar: :any,                 catalina:     "25bec1415f3d9e2fa2841deaa10593a9edfad9086d1179c123dbf0ed9d24223f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d242a9069826ac3650e5414ca19aca0d1295088b8696541d65a44a1a9f75767e"
  end

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
