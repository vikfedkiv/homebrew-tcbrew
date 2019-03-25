class Libcroco < Formula
  desc "CSS parsing and manipulation toolkit for GNOME"
  homepage "http://www.linuxfromscratch.org/blfs/view/svn/general/libcroco.html"
  url "http://10.10.4.242:8081/libcroco-0.6.12.tar.xz"
  sha256 "ddc4b5546c9fb4280a5017e2707fbd4839034ed1aba5b7d4372212f34f84f860"

  bottle do
    root_url "http://10.10.4.242:8081/bottles"
    cellar :any
    sha256 "af3b14a1519dbc7b5bd979997df77ef3152f3575b6257b4f35177abc66fa5d28" => :mojave
    sha256 "0bf41b44e72e39031c1ece76c12b20dc8bc566931c87baa484787c478f5fe4b7" => :high_sierra
  end

  depends_on "tenantcloud/tenantcloud/intltool" => :build
  depends_on "tenantcloud/tenantcloud/pkg-config" => :build
  depends_on "tenantcloud/tenantcloud/glib"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-Bsymbolic"
    system "make", "install"
  end

  test do
    (testpath/"test.css").write ".brew-pr { color: green }"
    assert_equal ".brew-pr {\n  color : green\n}",
      shell_output("#{bin}/csslint-0.6 test.css").chomp
  end
end
