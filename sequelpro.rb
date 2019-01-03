class Sequelpro < Formula
  desc "MySQL/MariaDB database management for macOS"
  homepage "https://sequelpro.com/"
  url "https://github.com/sequelpro/sequelpro/archive/release-1.1.2.tar.gz"
  sha256 "88d4baeee461da524212ac703fff90d510eb8c9cb07b42ba5bf1ab1f54eaa8ba"
  # depends_on "cmake" => :build

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

end
