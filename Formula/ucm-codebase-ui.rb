require "language/node"

class UcmCodebaseUi < Formula
  desc "Unison Codebase UI"
  homepage "https://unisonweb.org"

  url "https://github.com/unisonweb/codebase-ui.git",
    revision: "8f08e8a2722066c961cbede520992c3a6011469f"
  version "1.0.M2f"
  sha256 "eed15ed8e5fd55511589bfacb5b0e83f6dcbc33b97730748530ce79b6e05fcd0"
  license "MIT"

  head "https://github.com/unisonweb/codebase-ui.git"

  bottle do
    root_url "https://github.com/unisonweb/homebrew-unison-debug/releases/download/ucm-codebase-ui-1.0.M2f"
    sha256 cellar: :any_skip_relocation, any:      "66b824d36494e529514d7087e18dd2732307a5054e9674908c1234980261f814"
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
