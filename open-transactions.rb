require 'formula'

class OpenTransactions < Formula
  homepage 'http://opentransactions.org'
  url 'https://github.com/Open-Transactions/Open-Transactions/archive/83457f2dc210d431f4ff20a3edd955f87c018b71.zip'
  version '0.90.c'
  sha1 'cf1a7edda5ced19b866fa002709573739a929d26'
  head 'https://github.com/Open-Transactions/Open-Transactions.git'

  env :std
  option :cxx11, "Enable C++11 (and disable Boost)"

  depends_on 'libtool'    => :build
  depends_on 'automake'   => :build
  depends_on 'autoconf'   => :build
  depends_on 'pkg-config' => :build
  depends_on 'openssl'

  if build.cxx11?
    depends_on 'protobuf' => 'c++11'
    depends_on 'chaiscript'
  else
    depends_on 'protobuf'
    depends_on 'chaiscript4'
  end

  depends_on 'msgpack'
  depends_on 'homebrew/versions/zeromq22'

  depends_on 'perl'   => :optional
  depends_on 'ruby'   => :optional
  depends_on 'python' => :optional
  depends_on 'tcl'    => :optional

  option 'with-java', 'SWIG support for Java (Java not managed by homebrew)'
  option 'with-php', 'SWIG support for PHP (PHP not managed by homebrew)'
  option 'with-csharp', 'SWIG support for C# (C# not managed by homebrew)'
  option 'with-d', 'SWIG support for D (D not managed by homebrew)'

  option 'enable-debug', 'Enable Configuration in Debug Mode'
  option 'enable-release', 'Enable Configuration in Release Mode'
  option "enable-warnings", 'Enable extra (noisy) warnings with compile'
  option "enable-sighandler", 'Enable the signal handling for catching segmentation faults (debug only)'
  option "with-keyring", 'Enable osx system keyring storage of OT passwords'
  option 'use-i686', "Build using an i686 (32bit) target"

  #option 'disable-boost', 'Disable using boost (Do not do the --disable-cxx11 option if you choose this)'

  #option 'disable-cxx11', 'Disable using C++11 (Do not do the --disable-boost option if you choose this)'

  def install
    i686_args = ["--build=i686-apple-darwin11", "--host=i686-apple-darwin11", "--target=i686-apple-darwin11"]
    x64_args =  ["--build=x86_64-apple-darwin11","--host=x86_64-apple-darwin11","--target=x86_64-apple-darwin11"]
    config_args = (build.include? 'use-i686') ? i686_args : x64_args

    config_args << '--enable-debug'      if build.include? 'enable-debug'
    config_args << '--enable-release'    if build.include? 'enable-release'
    config_args << '--enable-warnings'   if build.include? 'enable-warnings'
    config_args << '--enable-sighandler' if build.include? 'enable-sighandler'
    config_args << '--with-keyring=mac'  if build.include? 'with-keyring'
    config_args << '--disable-boost'     if build.include? 'disable-boost'

    if build.cxx11?
      ENV.cxx11 
      config_args << '--enable-cxx11'
      config_args << '--disable-boost'
    else
      config_args << '--disable-cxx11'
      config_args << '--enable-boost'
    end

    #SWIG Languages
    config_args << '--with-ruby'   if build.with? 'ruby'
    config_args << '--with-perl5'  if build.with? 'perl'
    config_args << '--with-python' if build.with? 'python'
    config_args << '--with-tcl'    if build.with? 'tcl'
    config_args << '--with-java'   if build.with? 'java'
    config_args << '--with-php'    if build.with? 'php'
    config_args << '--with-csharp' if build.with? 'csharp'
    config_args << '--with-d'      if build.with? 'd'

    system 'sh', 'autogen.sh'
    system "./configure", "--prefix=#{prefix}", "--with-openssl=#{Formula.factory('openssl').opt_prefix}", *config_args
    system 'make'
    system 'make', 'install'
  end

  test do
    system "false"
  end
end
