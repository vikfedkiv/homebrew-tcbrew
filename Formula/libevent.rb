class Libevent < Formula
  desc "Asynchronous event library"
  homepage "https://libevent.org/"
  url "http://10.10.4.242:8081/libevent-2.1.8-stable.tar.gz"
  sha256 "316ddb401745ac5d222d7c529ef1eada12f58f6376a66c1118eee803cb70f83d"

  bottle do
    root_url "http://10.10.4.242:8081/bottles"
    cellar :any
    sha256 "9ab81f4ca9902042f7ea95d02bf36394c5cdc11d715b7f928badc9cf5724ca8b" => :mojave
    sha256 "61a8cf2df6d58f79678fad0f798b6a9d368245097f908e2f911f25cb3f7916cf" => :high_sierra
  end

  depends_on "tenantcloud/tenantcloud/autoconf" => :build
  depends_on "tenantcloud/tenantcloud/automake" => :build
  depends_on "tenantcloud/tenantcloud/doxygen" => :build
  depends_on "tenantcloud/tenantcloud/libtool" => :build
  depends_on "tenantcloud/tenantcloud/pkg-config" => :build
  depends_on "tenantcloud/tenantcloud/openssl"

  conflicts_with "pincaster",
    :because => "both install `event_rpcgen.py` binaries"

  def install
    inreplace "Doxyfile", /GENERATE_MAN\s*=\s*NO/, "GENERATE_MAN = YES"
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-debug-mode",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
    system "make", "doxygen"
    man3.install Dir["doxygen/man/man3/*.3"]
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <event2/event.h>
      int main()
      {
        struct event_base *base;
        base = event_base_new();
        event_base_free(base);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-levent", "-o", "test"
    system "./test"
  end
end
