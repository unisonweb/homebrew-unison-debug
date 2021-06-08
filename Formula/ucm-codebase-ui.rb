require "language/node"

class UcmCodebaseUi < Formula
  desc "Unison Codebase UI"
  homepage "https://unisonweb.org"

  url "https://github.com/unisonweb/codebase-ui.git",
    revision: "b6333817e549681f25f4b10fc81ea2fc9cb424c4"
  version "1.0.M2"
  sha256 "eed15ed8e5fd55511589bfacb5b0e83f6dcbc33b97730748530ce79b6e05fcd0"
  license "MIT"

  head "https://github.com/unisonweb/codebase-ui.git"

  bottle do
    root_url "https://github.com/aryairani/homebrew-unison/releases/download/ucm-codebase-ui-1.0.M2"
    sha256 cellar: :any_skip_relocation, catalina:     "5a0eda4fd7e6ea1907e3f82cacc993d605b64f35ae4d4023566a092a3041ed33"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c7003b89ca61095d4b929c438b455cf57e30a48700ba1213f759bb25cbfd4990"
  end

  depends_on "npm" => :build

  def install
    system "npm", "install", *Language::Node.local_npm_install_args
    system "npm", "run", "build"
    share.install Dir["dist/ucm/*"]
  end

  test do
    system "true"
  end
end
