require 'formula'

# Devel version of ChaiScript 5.x (with C++11)
# For 4.x version (with Boost) see chaiscript4 formula

class Chaiscript4 < Formula
  homepage 'http://chaiscript.com/'
  url 'https://github.com/ChaiScript/ChaiScript/archive/Release-4.2.0.zip'
  sha1 '08a8d3fdb5bd75561b20a2c61e52e96705a2d67b'
  head 'https://github.com/ChaiScript/ChaiScript.git'

  env :std

  depends_on 'cmake' => :build

  def install
    ENV.remove_macosxsdk

    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install"
  end

  test do
    system "false"
  end
end
