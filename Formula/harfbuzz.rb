class Harfbuzz < Formula
  desc "OpenType text shaping engine"
  homepage "https://wiki.freedesktop.org/www/Software/HarfBuzz/"
  url "http://10.10.4.242:8081/harfbuzz-2.3.0.tar.bz2"
  sha256 "3b314db655a41d19481e18312465fa25fca6f63382217f08062f126059f96764"

  bottle do
    root_url "http://10.10.4.242:8081/bottles"
    cellar :any
    sha256 "67d163766bd48b21f1400f18414019fe2f0b9e118ad57370066efe9147661733" => :mojave
    sha256 "2679592b0ab7669745103679038a059af24c34693823ef800f6966eb2ecccbac" => :high_sierra
  end

  head do
    url "https://github.com/behdad/harfbuzz.git"

    depends_on "tenantcloud/tenantcloud/autoconf" => :build
    depends_on "tenantcloud/tenantcloud/automake" => :build
    depends_on "tenantcloud/tenantcloud/libtool" => :build
    depends_on "tenantcloud/tenantcloud/ragel" => :build
  end

  depends_on "tenantcloud/tenantcloud/gobject-introspection" => :build
  depends_on "tenantcloud/tenantcloud/pkg-config" => :build
  depends_on "tenantcloud/tenantcloud/cairo"
  depends_on "tenantcloud/tenantcloud/freetype"
  depends_on "tenantcloud/tenantcloud/glib"
  depends_on "tenantcloud/tenantcloud/graphite2"
  depends_on "tenantcloud/tenantcloud/icu4c"

  resource "ttf" do
    url "https://github.com/behdad/harfbuzz/raw/fc0daafab0336b847ac14682e581a8838f36a0bf/test/shaping/fonts/sha1sum/270b89df543a7e48e206a2d830c0e10e5265c630.ttf"
    sha256 "9535d35dab9e002963eef56757c46881f6b3d3b27db24eefcc80929781856c77"
  end

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --enable-introspection=yes
      --enable-static
      --with-cairo=yes
      --with-coretext=yes
      --with-freetype=yes
      --with-glib=yes
      --with-gobject=yes
      --with-graphite2=yes
      --with-icu=yes
    ]

    system "./autogen.sh" if build.head?
    system "./configure", *args
    system "make", "install"
  end

  test do
    resource("ttf").stage do
      shape = `echo 'സ്റ്റ്' | #{bin}/hb-shape 270b89df543a7e48e206a2d830c0e10e5265c630.ttf`.chomp
      assert_equal "[glyph201=0+1183|U0D4D=0+0]", shape
    end
  end
end
