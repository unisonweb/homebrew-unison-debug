require "language/node"

class UcmCodebaseUi < Formula
  desc "Unison Codebase UI"
  homepage "https://unisonweb.org"

  url "https://github.com/unisonweb/codebase-ui.git", tag: "release/M2g"
  version "1.0.M2g"
  sha256 "b461e47c860a1e5c376aad40370f6ee0d1c1a658dbfa359c1056cbfd957d18a5"
  license "MIT"

  head "https://github.com/unisonweb/codebase-ui.git"

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
