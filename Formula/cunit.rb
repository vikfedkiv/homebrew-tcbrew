class Cunit < Formula
  desc "Lightweight unit testing framework for C"
  homepage "https://cunit.sourceforge.io/"
  url "http://10.10.4.242:8081/CUnit-2.1-3.tar.bz2"
  sha256 "f5b29137f845bb08b77ec60584fdb728b4e58f1023e6f249a464efa49a40f214"

  bottle do
    root_url "http://10.10.4.242:8081/bottles"
    cellar :any
    sha256 "561baccf9e285cd65021b70342d1ba37b456a2f35c0324dfd2a65ea427641d27" => :mojave
    sha256 "23fdc88eeb1c4cf8d58e281e046f2e45a56860c0091e5c76f757f01679d143d2" => :high_sierra
  end

  depends_on "tenantcloud/tenantcloud/autoconf" => :build
  depends_on "tenantcloud/tenantcloud/automake" => :build
  depends_on "tenantcloud/tenantcloud/libtool" => :build

  def install
    inreplace "bootstrap", "libtoolize", "glibtoolize"
    system "sh", "bootstrap", prefix
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <string.h>
      #include "CUnit/Basic.h"
      int noop(void) { return 0; }
      void test42(void) { CU_ASSERT(42 == 42); }
      int main(void)
      {
         CU_pSuite pSuite = NULL;
         if (CUE_SUCCESS != CU_initialize_registry())
            return CU_get_error();
         pSuite = CU_add_suite("Suite_1", noop, noop);
         if (NULL == pSuite) {
            CU_cleanup_registry();
            return CU_get_error();
         }
         if (NULL == CU_add_test(pSuite, "test of 42", test42)) {
            CU_cleanup_registry();
            return CU_get_error();
         }
         CU_basic_set_mode(CU_BRM_VERBOSE);
         CU_basic_run_tests();
         CU_cleanup_registry();
         return CU_get_error();
      }
    EOS

    system ENV.cc, "test.c", "-L#{lib}", "-lcunit", "-o", "test"
    assert_match "test of 42 ...passed", shell_output("./test")
  end
end
