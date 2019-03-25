class Jasper < Formula
  desc "Library for manipulating JPEG-2000 images"
  homepage "https://www.ece.uvic.ca/~frodo/jasper/"
  url "http://10.10.4.242:8081/jasper-2.0.14.tar.gz"
  sha256 "85266eea728f8b14365db9eaf1edc7be4c348704e562bb05095b9a077cf1a97b"

  bottle do
    root_url "http://10.10.4.242:8081/bottles"
    sha256 "799c0986353251ad4b1d6d8cbdcfae357ef428cbc534a89ed0be5a5de3dcaf80" => :mojave
    sha256 "086de22e8e8a01299962f3bea5374c90490b66e84b7e10a4078f172e64b0079f" => :high_sierra
  end

  depends_on "tenantcloud/tenantcloud/cmake" => :build
  depends_on "tenantcloud/tenantcloud/jpeg"

  def install
    mkdir "build" do
      # Make sure macOS's GLUT.framework is used, not XQuartz or freeglut
      # Reported to CMake upstream 4 Apr 2016 https://gitlab.kitware.com/cmake/cmake/issues/16045
      glut_lib = "#{MacOS.sdk_path}/System/Library/Frameworks/GLUT.framework"
      system "cmake", "..", "-DGLUT_glut_LIBRARY=#{glut_lib}", *std_cmake_args
      system "make"
      system "make", "test"
      system "make", "install"
    end
  end

  test do
    system bin/"jasper", "--input", test_fixtures("test.jpg"),
                         "--output", "test.bmp"
    assert_predicate testpath/"test.bmp", :exist?
  end
end
