class LinuxHeaders < Formula
  desc "Header files of the Linux kernel"
  homepage "http://kernel.org/"
  url "https://cdn.kernel.org/pub/linux/kernel/v3.x/linux-3.18.27.tar.gz"
  sha256 "35618751139c2ad76298dd5e2e4b80121c1a14f490375bc93a35b9f0b882d29c"
  # tag "linuxbrew"

  def install
    system "make", "headers_install", "INSTALL_HDR_PATH=#{prefix}"
    rm Dir[prefix/"**/{.install,..install.cmd}"]
  end

  test do
    system "ls", include
  end
end
