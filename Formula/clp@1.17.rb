class ClpAT117 < Formula
  desc "Coin-or linear programming"
  homepage "https://github.com/coin-or/Clp"
  url "https://projects.coin-or.org/svn/Clp/stable/1.17", :using => :svn
  head "https://github.com/coin-or/Clp.git"

  def install
    system "./configure", "--prefix=#{prefix}", "-C"
    system "make"
    system "make", "test"
    system "make", "install"
  end
end
