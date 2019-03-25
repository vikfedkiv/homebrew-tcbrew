class Libzip < Formula
  desc "C library for reading, creating, and modifying zip archives"
  homepage "https://libzip.org/"
  url "http://10.10.4.242:8081/libzip-1.5.1.tar.gz"
  sha256 "47eaa45faa448c72bd6906e5a096846c469a185f293cafd8456abb165841b3f2"

  bottle do
    root_url "http://10.10.4.242:8081/bottles"
    sha256 "c3527d9364aaca72f5bbd0486962639b421efcbd7ba7209b8a14a7900e52607b" => :mojave
    sha256 "4ffb9ac04f1fc2c98e5ba902999ed6f4bc5d7d9133d22fc183fd8fa13b7fd9be" => :high_sierra
  end

  depends_on "tenantcloud/tenantcloud/cmake" => :build

  conflicts_with "libtcod", :because => "both install `zip.h` header"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    touch "file1"
    system "zip", "file1.zip", "file1"
    touch "file2"
    system "zip", "file2.zip", "file1", "file2"
    assert_match /\+.*file2/, shell_output("#{bin}/zipcmp -v file1.zip file2.zip", 1)
  end
end
