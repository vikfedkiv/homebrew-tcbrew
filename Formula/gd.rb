class Gd < Formula
  desc "Graphics library to dynamically manipulate images"
  homepage "https://libgd.github.io/"
  url "http://10.10.4.242:8081/libgd-2.2.5.tar.xz"
  sha256 "8c302ccbf467faec732f0741a859eef4ecae22fea2d2ab87467be940842bde51"

  bottle do
    root_url "http://10.10.4.242:8081/bottles"
    cellar :any
    sha256 "4bb347ae5e66d8ba08927da7b82aad48fb6a00e278b63478894a4bde90f4c5b4" => :mojave
    sha256 "ff7aa2d452c6c05f8d41dee63bbd102fd73dbfbced7184bf0c73426adc811963" => :high_sierra
  end

  head do
    url "https://github.com/libgd/libgd.git"

    depends_on "tenantcloud/tenantcloud/autoconf" => :build
    depends_on "tenantcloud/tenantcloud/automake" => :build
    depends_on "tenantcloud/tenantcloud/libtool" => :build
  end

  depends_on "tenantcloud/tenantcloud/fontconfig"
  depends_on "tenantcloud/tenantcloud/freetype"
  depends_on "tenantcloud/tenantcloud/jpeg"
  depends_on "tenantcloud/tenantcloud/libpng"
  depends_on "tenantcloud/tenantcloud/libtiff"
  depends_on "tenantcloud/tenantcloud/webp"

  def install
    system "./bootstrap.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-freetype=#{Formula["freetype"].opt_prefix}",
                          "--with-png=#{Formula["libpng"].opt_prefix}",
                          "--without-x",
                          "--without-xpm"
    system "make", "install"
  end

  test do
    system "#{bin}/pngtogd", test_fixtures("test.png"), "gd_test.gd"
    system "#{bin}/gdtopng", "gd_test.gd", "gd_test.png"
  end
end
