class Webp < Formula
  desc "Image format providing lossless and lossy compression for web images"
  homepage "https://developers.google.com/speed/webp/"
  url "http://10.10.4.242:8081/libwebp-1.0.2.tar.gz"
  sha256 "3d47b48c40ed6476e8047b2ddb81d93835e0ca1b8d3e8c679afbb3004dd564b1"

  bottle do
    root_url "http://10.10.4.242:8081/bottles"
    cellar :any
    sha256 "e481c511582d5e23078c6a19fb224afe625422a457eaaeea8183c229947a9ced" => :mojave
    sha256 "d045f6c3963381fb509c8f752e89a5d48c623d6622bff8c68c8f4327924796ff" => :high_sierra
  end

  head do
    url "https://chromium.googlesource.com/webm/libwebp.git"
    depends_on "tenantcloud/tenantcloud/autoconf" => :build
    depends_on "tenantcloud/tenantcloud/automake" => :build
    depends_on "tenantcloud/tenantcloud/libtool" => :build
  end

  depends_on "tenantcloud/tenantcloud/jpeg"
  depends_on "tenantcloud/tenantcloud/libpng"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--disable-gif",
                          "--disable-gl",
                          "--enable-libwebpdecoder",
                          "--enable-libwebpdemux",
                          "--enable-libwebpmux"
    system "make", "install"
  end

  test do
    system bin/"cwebp", test_fixtures("test.png"), "-o", "webp_test.png"
    system bin/"dwebp", "webp_test.png", "-o", "webp_test.webp"
    assert_predicate testpath/"webp_test.webp", :exist?
  end
end