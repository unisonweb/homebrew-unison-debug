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
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur:      "ec1c0f7ec916b245378357ca61590a5b0c3b96fcc50614733823af12b85c06c0"
    sha256 cellar: :any_skip_relocation, catalina:     "ec1c0f7ec916b245378357ca61590a5b0c3b96fcc50614733823af12b85c06c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "894b5941b88977e4e8a62af366425dc2faa305886eaee6b89fdaa4ec484504f4"
  end

  depends_on "npm" => :build

  def install
    system "npm", "install", *Language::Node.local_npm_install_args
    system "npm", "run", "build"
    chmod_R "go-w", prefix
    share.install Dir["dist/ucm/*"]
  end

  test do
    system "true"
  end
end
