class Gdbm < Formula
  desc "GNU database manager"
  homepage "https://www.gnu.org/software/gdbm/"
  url "http://10.10.4.242:8081/gdbm-1.18.1.tar.gz"
#  mirror "https://ftpmirror.gnu.org/gdbm/gdbm-1.18.1.tar.gz"
  sha256 "86e613527e5dba544e73208f42b78b7c022d4fa5a6d5498bf18c8d6f745b91dc"

  bottle do
    root_url "http://10.10.4.242:8081/bottles"
    cellar :any
    rebuild 1
    sha256 "2168d58856917ca996d12dedaa930643529c66046103fe55018afc51f2bc1fcb" => :mojave
    sha256 "ac688d571f9c00e09670440d67d2869a34dab0fb897ba0b183ed84fceffdbc9c" => :high_sierra
  end

  # Use --without-readline because readline detection is broken in 1.13
  # https://github.com/Homebrew/homebrew-core/pull/10903
  def install
    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --without-readline
      --prefix=#{prefix}
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    pipe_output("#{bin}/gdbmtool --norc --newdb test", "store 1 2\nquit\n")
    assert_predicate testpath/"test", :exist?
    assert_match /2/, pipe_output("#{bin}/gdbmtool --norc test", "fetch 1\nquit\n")
  end
end
