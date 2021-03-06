class Freetds < Formula
  desc "Libraries to talk to Microsoft SQL Server and Sybase databases"
  homepage "http://www.freetds.org/"
  url "http://10.10.4.242:8081/freetds-1.00.109.tar.gz"
  sha256 "314cc6c22086dc2cc677aed5e0dec07845cf13f79273af7bb855eb447b45f906"

  bottle do
    root_url "http://10.10.4.242:8081/bottles"
    sha256 "d40f958c4e74eec54b45f6ebc977f3903edad6efb8102554ef4e6310d72f89b1" => :mojave
    sha256 "a42096e5a6d89895526be8f84dfa0e1e08b2a334ba426d537ac41620fa801ff6" => :high_sierra
  end

  head do
    url "https://github.com/FreeTDS/freetds.git"

    depends_on "tenantcloud/tenantcloud/autoconf" => :build
    depends_on "tenantcloud/tenantcloud/automake" => :build
    depends_on "tenantcloud/tenantcloud/gettext" => :build
    depends_on "tenantcloud/tenantcloud/libtool" => :build
  end

  option "with-msdblib", "Enable Microsoft behavior in the DB-Library API where it diverges from Sybase's"

  depends_on "tenantcloud/tenantcloud/pkg-config" => :build
  depends_on "tenantcloud/tenantcloud/openssl"
  depends_on "tenantcloud/tenantcloud/unixodbc"

  def install
    args = %W[
      --prefix=#{prefix}
      --with-tdsver=7.3
      --mandir=#{man}
      --sysconfdir=#{etc}
      --with-unixodbc=#{Formula["unixodbc"].opt_prefix}
      --with-openssl=#{Formula["openssl"].opt_prefix}
      --enable-sybase-compat
      --enable-krb5
      --enable-odbc-wide
    ]

    if build.with? "msdblib"
      args << "--enable-msdblib"
    end

    if build.head?
      system "./autogen.sh", *args
    else
      system "./configure", *args
    end
    system "make"
    ENV.deparallelize # Or fails to install on multi-core machines
    system "make", "install"
  end

  test do
    system "#{bin}/tsql", "-C"
  end
end
