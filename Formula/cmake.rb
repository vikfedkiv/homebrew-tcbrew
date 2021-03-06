class Cmake < Formula
  desc "Cross-platform make"
  homepage "https://www.cmake.org/"
  url "http://10.10.4.242:8081/cmake-3.13.2.tar.gz"
  sha256 "c925e7d2c5ba511a69f43543ed7b4182a7d446c274c7480d0e42cd933076ae25"
  head "https://cmake.org/cmake.git"

  bottle do
    root_url "http://10.10.4.242:8081/bottles"
    cellar :any_skip_relocation
    sha256 "6ef34cdd1596e3db55071cf0a88a943ef99f2b466e1a34ead5756da7bf22db58" => :mojave
    sha256 "ac6cf789fde63484d649116a13874671d5dbb5608c7f51b0c06c98539a194e06" => :high_sierra
  end

  depends_on "tenantcloud/tenantcloud/sphinx-doc" => :build

  # The completions were removed because of problems with system bash

  # The `with-qt` GUI option was removed due to circular dependencies if
  # CMake is built with Qt support and Qt is built with MySQL support as MySQL uses CMake.
  # For the GUI application please instead use `brew cask install cmake`.

  def install
    args = %W[
      --prefix=#{prefix}
      --no-system-libs
      --parallel=#{ENV.make_jobs}
      --datadir=/share/cmake
      --docdir=/share/doc/cmake
      --mandir=/share/man
      --sphinx-build=#{Formula["sphinx-doc"].opt_bin}/sphinx-build
      --sphinx-html
      --sphinx-man
      --system-zlib
      --system-bzip2
      --system-curl
    ]

    # There is an existing issue around macOS & Python locale setting
    # See https://bugs.python.org/issue18378#msg215215 for explanation
    ENV["LC_ALL"] = "en_US.UTF-8"

    system "./bootstrap", *args, "--", "-DCMAKE_BUILD_TYPE=Release"
    system "make"
    system "make", "install"

    elisp.install "Auxiliary/cmake-mode.el"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(Ruby)")
    system bin/"cmake", "."
  end
end
