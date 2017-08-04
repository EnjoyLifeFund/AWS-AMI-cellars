class Bzip2 < Formula
  desc "Freely available high-quality data compressor"
  homepage "http://www.bzip.org/"
  url "http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz"
  sha256 "a2848f34fcd5d6cf47def00461fcb528a0484d8edef8208d6d2e2909dc61d9cd"
  revision 1

  keg_only :provided_by_osx

  def install
    inreplace "Makefile", "$(PREFIX)/man", "$(PREFIX)/share/man"

    system "make", "install", "PREFIX=#{prefix}"

    unless OS.mac?
      # Install the shared library.
      system "make", "-f", "Makefile-libbz2_so", "clean"
      system "make", "-f", "Makefile-libbz2_so"
      lib.install "libbz2.so.1.0.6", "libbz2.so.1.0"
      lib.install_symlink "libbz2.so.1.0.6" => "libbz2.so.1"
      lib.install_symlink "libbz2.so.1.0.6" => "libbz2.so"
    end
  end

  test do
    testfilepath = testpath + "sample_in.txt"
    zipfilepath = testpath + "sample_in.txt.bz2"

    testfilepath.write "TEST CONTENT"

    system "#{bin}/bzip2", testfilepath
    system "#{bin}/bunzip2", zipfilepath

    assert_equal "TEST CONTENT", testfilepath.read
  end
end
