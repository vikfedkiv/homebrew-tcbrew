class Sequel < Formula
  desc ""
  homepage ""

  version "1.1.2"
  sha256 "88d4baeee461da524212ac703fff90d510eb8c9cb07b42ba5bf1ab1f54eaa8ba"
  url "http://10.10.4.242/sequel-pro-release-1.1.2.tar.gz"

  def install
    system "make", "install"
  end

end