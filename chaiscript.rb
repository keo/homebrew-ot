require 'formula'

# Devel version of ChaiScript 5.x (with C++11)
# For 4.x version (with Boost) see chaiscript4 formula

class Chaiscript < Formula
  homepage 'http://chaiscript.com/'
  url 'https://github.com/ChaiScript/ChaiScript/archive/8aedd80e1abcbe83f899d94f6aae843192b229bd.zip' #need recent commits for it to build properly for 10.9
  version '8aedd'
  sha1 '08a8d3fdb5bd75561b20a2c61e52e96705a2d67b'
  head 'https://github.com/ChaiScript/ChaiScript.git', :branch => 'ChaiScript_5_0_CPP_11' #need the 5.x branch for osx 10.9

  env :std

  depends_on :macos => :lion
  depends_on 'cmake' => :build

  def install
    ENV.cxx11
    ENV.remove_macosxsdk

    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install"
  end

  test do
    system "false"
  end
end
