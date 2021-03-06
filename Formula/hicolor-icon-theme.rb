class HicolorIconTheme < Formula
  desc "Fallback theme for FreeDesktop.org icon themes"
  homepage "https://wiki.freedesktop.org/www/Software/icon-theme/"
  url "http://10.10.4.242:8081/hicolor-icon-theme-0.17.tar.xz"
  sha256 "317484352271d18cbbcfac3868eab798d67fff1b8402e740baa6ff41d588a9d8"

  bottle do
    root_url "http://10.10.4.242:8081/bottles"
    cellar :any_skip_relocation
    sha256 "5ba4bb6a7e89f5fb0d43504d68d657a536be9540d4cc72552bd5965e15a82b91" => :mojave
    sha256 "b33f58b98a6ca6bb72777eaf7b7a4bb393d5cc9ced6954dd7a7e52e18c214799" => :high_sierra
  end

  head do
    url "https://anongit.freedesktop.org/git/xdg/default-icon-theme.git"
    depends_on "tenantcloud/tenantcloud/autoconf" => :build
    depends_on "tenantcloud/tenantcloud/automake" => :build
  end

  def install
    args = %W[--prefix=#{prefix} --disable-silent-rules]
    if build.head?
      system "./autogen.sh", *args
    else
      system "./configure", *args
    end
    system "make", "install"
  end

  test do
    assert_predicate share/"icons/hicolor/index.theme", :exist?
  end
end
