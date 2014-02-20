require 'formula'

# Devel version of ChaiScript 5.x (with C++11)
# For 4.x version (with Boost) see chaiscript4 formula

class Chaiscript4 < Formula
  homepage 'http://chaiscript.com/'
  url 'https://github.com/ChaiScript/ChaiScript/archive/Release-4.2.0.zip'
  sha1 '412976a19c9ce4d073318a9e5ef17dc09e22c4a6'
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
