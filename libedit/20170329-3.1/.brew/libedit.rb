class Libedit < Formula
  desc "BSD-style licensed readline alternative"
  homepage "http://thrysoee.dk/editline/"
  url "http://thrysoee.dk/editline/libedit-20170329-3.1.tar.gz"
  version "20170329-3.1"
  sha256 "91f2d90fbd2a048ff6dad7131d9a39e690fd8a8fd982a353f1333dd4017dd4be"

  keg_only :provided_by_osx

  depends_on "ncurses" unless OS.mac?

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"

    unless OS.mac?
      # Conflicts with ncurses.
      mv man3/"history.3", man3/"history_libedit.3"
      # Symlink libedit.so.0 to libedit.so.2 for binary compatibility with Debian/Ubuntu.
      ln_s lib/"libedit.so.0", lib/"libedit.so.2"
    end
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <stdio.h>
      #include <histedit.h>
      int main(int argc, char *argv[]) {
        EditLine *el = el_init(argv[0], stdin, stdout, stderr);
        return (el == NULL);
      }
    EOS
    system ENV.cc, "test.c", "-o", "test", "-L#{lib}", "-ledit", "-I#{include}"
    system "./test"
  end
end
