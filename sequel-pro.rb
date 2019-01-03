class Sequel Pro < Formula
  desc "Sequel Pro"
  homepage "http://sequelpro.com"
  url "http://10.10.0.134/release-1.1.2.tar.gz"
  sha256 "88d4baeee461da524212ac703fff90d510eb8c9cb07b42ba5bf1ab1f54eaa8ba"

  def install
        bin.install "sequel-pro"
  end
end
