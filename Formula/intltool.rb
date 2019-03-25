class Intltool < Formula
  desc "String tool"
  homepage "https://wiki.freedesktop.org/www/Software/intltool"
  url "http://10.10.4.242:8081/intltool-0.51.0.tar.gz"
  sha256 "67c74d94196b153b774ab9f89b2fa6c6ba79352407037c8c14d5aeb334e959cd"

  bottle do
    root_url "http://10.10.4.242:8081/bottles"
    cellar :any_skip_relocation
    sha256 "52ccb5bfce1cda123f30c84335172335cee0706973e6769ec9a5358cb160f364" => :mojave
    sha256 "7924c9c7dc7b3eee0056171df8c6b66c2e0e8888e4638232e967a5ea31ca5b86" => :high_sierra
  end

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-silent-rules"
    system "make", "install"
  end

  test do
    system bin/"intltool-extract", "--help"
  end
end
