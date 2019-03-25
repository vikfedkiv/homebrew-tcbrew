class Icu4c < Formula
  desc "C/C++ and Java libraries for Unicode and globalization"
  homepage "https://ssl.icu-project.org/"
  url "http://10.10.4.242:8081/icu4c-63_1-src.tgz"
#  mirror "https://github.com/unicode-org/icu/releases/download/release-63-1/icu4c-63_1-src.tgz"
  version "63.1"
  sha256 "05c490b69454fce5860b7e8e2821231674af0a11d7ef2febea9a32512998cb9d"

  bottle do
    root_url "http://10.10.4.242:8081/bottles"
    cellar :any
    sha256 "e707bf5e3d0189ede7d941d95a417b5dacad3eac99b9a677042464140f12fa1d" => :mojave
    sha256 "0ac5ee60393d26ec26a915ed957a38a0b2355fe7991f607044edaedd3ff14cc1" => :high_sierra
  end

  keg_only :provided_by_macos, "macOS provides libicucore.dylib (but nothing else)"

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-samples
      --disable-tests
      --enable-static
      --with-library-bits=64
    ]

    cd "source" do
      system "./configure", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/gendict", "--uchars", "/usr/share/dict/words", "dict"
  end
end
