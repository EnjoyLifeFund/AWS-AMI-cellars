class UtilLinux < Formula
  desc "Collection of Linux utilities"
  homepage "https://github.com/karelzak/util-linux"
  url "https://www.kernel.org/pub/linux/utils/util-linux/v2.29/util-linux-2.29.tar.xz"
  sha256 "2c59ea67cc7b564104f60532f6e0a95fe17a91acb870ba8fd7e986f273abf9e7"
  revision 1
  head "https://github.com/karelzak/util-linux.git"
  # tag "linuxbrew"

  depends_on "ncurses" unless OS.mac?
  depends_on "linuxbrew/extra/linux-pam" => :optional

  def install
    args = [
      "--disable-dependency-tracking",
      "--disable-silent-rules",
      "--prefix=#{prefix}",
      # Fix chgrp: changing group of 'wall': Operation not permitted
      "--disable-use-tty-group",
      # Conflicts with coreutils.
      "--disable-kill",
      # Conflicts with bsdmainutils
      "--disable-cal",
      "--disable-ul",
      # Do not install systemd files
      "--without-systemd",
      "--with-bashcompletiondir=#{bash_completion}",
    ]
    args += %w[--disable-chfn-chsh --disable-login --disable-su --disable-runuser] if build.without? "linux-pam"
    system "./configure", *args
    system "make", "install"

    # Conflicts with bsdmainutils and cannot be manually disabled
    conflicts = %w[
      col*
      hexdump*
      look*
    ]
    conflicts.each do |conflict|
      rm_f Dir.glob("{#{bin},#{man1}}/#{conflict}")
    end

    # conflicts with bash-completion
    ["mount", "rtcwake"].each { |conflict| rm bash_completion/conflict }
  end

  def caveats; <<-EOS.undent
    Some commands were moved to the bsdmainutils formula.
    You may wish to install it as well.
    EOS
  end

  test do
    (testpath/"tmpfile").write("temp")
    system bin/"rename", "tmp", "temp", testpath/"tmpfile"
    assert File.exist?(testpath/"tempfile")
  end
end
