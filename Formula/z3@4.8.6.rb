class Z3AT486 < Formula
  desc "High-performance theorem prover"
  homepage "https://github.com/Z3Prover/z3"
  url "https://github.com/Z3Prover/z3/archive/z3-4.8.6.tar.gz"
  sha256 "37922fa5085170cad6504498d9758fb63c61d5cb5b68689c11a6c5e84f0311b3"
  head "https://github.com/Z3Prover/z3.git"

  bottle do
    root_url "https://stonebuddha.github.io/dist"
    cellar :any
    sha256 "b42f22922098bc7506faa323c9294af920335932921cf900c28d1c7a905f1d21" => :mojave
  end

  depends_on "python"

  def install
    xy = Language::Python.major_minor_version "python3"
    system "python3", "scripts/mk_make.py",
                      "--prefix=#{prefix}",
                      "--python",
                      "--pypkgdir=#{lib}/python#{xy}/site-packages",
                      "--staticlib"

    cd "build" do
      system "make"
      system "make", "install"
    end

    system "make", "-C", "contrib/qprofdiff"
    bin.install "contrib/qprofdiff/qprofdiff"

    pkgshare.install "examples"
  end

  test do
    system ENV.cc, "-I#{include}", "-L#{lib}", "-lz3",
           pkgshare/"examples/c/test_capi.c", "-o", testpath/"test"
    system "./test"
  end
end
