class Librsvg < Formula
  desc "Library to render SVG files using Cairo"
  homepage "https://wiki.gnome.org/Projects/LibRsvg"
  url "http://10.10.4.242:8081/librsvg-2.44.11.tar.xz"
  sha256 "e45a6eee174faf442e06636ee31ca1d30758b84d525a174c34434ca0e3a1af9e"

  bottle do
    root_url "http://10.10.4.242:8081/bottles"
    sha256 "7a4886ed6586dc35d6462f47867e12a208345e1be9d16c864d8ec538dd690bc8" => :mojave
    sha256 "a3b8ae6f5f642f9eaceef91083788724c8362c7196a6ae1c74e5f0d7da0bfba0" => :high_sierra
  end

  depends_on "tenantcloud/tenantcloud/gobject-introspection" => :build
  depends_on "tenantcloud/tenantcloud/pkg-config" => :build
  depends_on "tenantcloud/tenantcloud/rust" => :build
  depends_on "tenantcloud/tenantcloud/cairo"
  depends_on "tenantcloud/tenantcloud/gdk-pixbuf"
  depends_on "tenantcloud/tenantcloud/glib"
  depends_on "tenantcloud/tenantcloud/libcroco"
  depends_on "tenantcloud/tenantcloud/pango"
  depends_on "tenantcloud/tenantcloud/gtk+3" => :optional

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --disable-Bsymbolic
      --enable-tools=yes
      --enable-pixbuf-loader=yes
      --enable-introspection=yes
    ]

    system "./configure", *args

    # disable updating gdk-pixbuf cache, we will do this manually in post_install
    # https://github.com/Homebrew/homebrew/issues/40833
    inreplace "gdk-pixbuf-loader/Makefile",
              "$(GDK_PIXBUF_QUERYLOADERS) > $(DESTDIR)$(gdk_pixbuf_cache_file) ;",
              ""

    system "make", "install",
      "gdk_pixbuf_binarydir=#{lib}/gdk-pixbuf-2.0/2.10.0/loaders",
      "gdk_pixbuf_moduledir=#{lib}/gdk-pixbuf-2.0/2.10.0/loaders"
  end

  def post_install
    # librsvg is not aware GDK_PIXBUF_MODULEDIR must be set
    # set GDK_PIXBUF_MODULEDIR and update loader cache
    ENV["GDK_PIXBUF_MODULEDIR"] = "#{HOMEBREW_PREFIX}/lib/gdk-pixbuf-2.0/2.10.0/loaders"
    system "#{Formula["gdk-pixbuf"].opt_bin}/gdk-pixbuf-query-loaders", "--update-cache"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <librsvg/rsvg.h>
      int main(int argc, char *argv[]) {
        RsvgHandle *handle = rsvg_handle_new();
        return 0;
      }
    EOS
    cairo = Formula["cairo"]
    fontconfig = Formula["fontconfig"]
    freetype = Formula["freetype"]
    gdk_pixbuf = Formula["gdk-pixbuf"]
    gettext = Formula["gettext"]
    glib = Formula["glib"]
    libpng = Formula["libpng"]
    pixman = Formula["pixman"]
    flags = %W[
      -I#{cairo.opt_include}/cairo
      -I#{fontconfig.opt_include}
      -I#{freetype.opt_include}/freetype2
      -I#{gdk_pixbuf.opt_include}/gdk-pixbuf-2.0
      -I#{gettext.opt_include}
      -I#{glib.opt_include}/glib-2.0
      -I#{glib.opt_lib}/glib-2.0/include
      -I#{include}/librsvg-2.0
      -I#{libpng.opt_include}/libpng16
      -I#{pixman.opt_include}/pixman-1
      -D_REENTRANT
      -L#{cairo.opt_lib}
      -L#{gdk_pixbuf.opt_lib}
      -L#{gettext.opt_lib}
      -L#{glib.opt_lib}
      -L#{lib}
      -lcairo
      -lgdk_pixbuf-2.0
      -lgio-2.0
      -lglib-2.0
      -lgobject-2.0
      -lintl
      -lm
      -lrsvg-2
    ]
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
