class Pcre < Formula
  desc "Perl compatible regular expressions library"
  homepage "https://www.pcre.org/"
  url "http://10.10.4.242:8081/pcre-8.42.tar.bz2"
  sha256 "2cd04b7c887808be030254e8d77de11d3fe9d4505c39d4b15d2664ffe8bf9301"

  bottle do
    root_url "http://10.10.4.242:8081/bottles"
    cellar :any
    sha256 "f848e72c9a6ddfdd4e57d25df859830187cbb8e850996b22a84270a6590f56ff" => :mojave
    sha256 "b904c008c04003c3f40e30c6ee6a3b411aad81aa2f2684db9bf59bccd9d58b01" => :high_sierra
  end

  head do
    url "svn://vcs.exim.org/pcre/code/trunk"

    depends_on "tenantcloud/tenantcloud/autoconf" => :build
    depends_on "tenantcloud/tenantcloud/automake" => :build
    depends_on "tenantcloud/tenantcloud/libtool" => :build
  end

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-utf8",
                          "--enable-pcre8",
                          "--enable-pcre16",
                          "--enable-pcre32",
                          "--enable-unicode-properties",
                          "--enable-pcregrep-libz",
                          "--enable-pcregrep-libbz2",
                          "--enable-jit"
    system "make"
    ENV.deparallelize
    system "make", "test"
    system "make", "install"
  end

  test do
    system "#{bin}/pcregrep", "regular expression", "#{prefix}/README"
  end
end
