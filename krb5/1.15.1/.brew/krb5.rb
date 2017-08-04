# krb5: Build a bottle for Linuxbrew
class Krb5 < Formula
  desc "Network authentication protocol"
  homepage "https://web.mit.edu/kerberos/"
  url "https://web.mit.edu/kerberos/dist/krb5/1.15/krb5-1.15.1.tar.gz"
  sha256 "437c8831ddd5fde2a993fef425dedb48468109bb3d3261ef838295045a89eb45"

  keg_only :provided_by_osx

  depends_on "openssl"
  depends_on "bison" unless OS.mac?

  def install
    cd "src" do
      system "./configure",
        "--disable-debug",
        "--disable-dependency-tracking",
        "--disable-silent-rules",
        "--prefix=#{prefix}"
      system "make"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/krb5-config", "--version"
    assert_match include.to_s,
      shell_output("#{bin}/krb5-config --cflags")
  end
end
