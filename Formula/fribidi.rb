class Fribidi < Formula
  desc "Implementation of the Unicode BiDi algorithm"
  homepage "https://github.com/fribidi/fribidi"
  url "http://10.10.4.242:8081/fribidi-1.0.5.tar.bz2"
  sha256 "6a64f2a687f5c4f203a46fa659f43dd43d1f8b845df8d723107e8a7e6158e4ce"

  bottle do
    root_url "http://10.10.4.242:8081/bottles"
    cellar :any
    sha256 "56d5510ea4bc68244be0fd9c4aea28fb237102d436dc53588f82e4f4ed0bb357" => :mojave
    sha256 "840d79617e028fbf2a65f504a1510a86df4339bbfceaff276038a497e37700d4" => :high_sierra
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--enable-static"
    system "make", "install"
  end

  test do
    (testpath/"test.input").write <<~EOS
      a _lsimple _RteST_o th_oat
    EOS

    assert_match /a simple TSet that/, shell_output("#{bin}/fribidi --charset=CapRTL --test test.input")
  end
end
