require 'formula'

class Jsoncpp < Formula
  homepage 'http://jsoncpp.sourceforge.net'
#  url 'http://downloads.sourceforge.net/project/jsoncpp/jsoncpp/0.5.0/jsoncpp-src-0.5.0.tar.gz'
#  sha1 '7169a50c7615070b6190076a7b5e86c45b7440b7'
  url 'http://sourceforge.net/projects/jsoncpp/files/jsoncpp/0.6.0-rc2/jsoncpp-src-0.6.0-rc2.tar.gz/download'
  sha1 'a14eb501c44e610b8aaa2962bd1cc1775ed4fde2'

  depends_on 'scons' => :build

  def install
    # this is how the SConstruct build system creates file paths
    gccversion = `g++ -dumpversion`
    gccversion = gccversion.delete("\n");

    # run the build
    system "scons platform=linux-gcc"

    #install the libs
    lib.install "libs/linux-gcc-#{gccversion}/libjson_linux-gcc-#{gccversion}_libmt.a" => "libjson.a", 
    "libs/linux-gcc-#{gccversion}/libjson_linux-gcc-#{gccversion}_libmt.dylib" => "libjson.dylib"
    # lib.install "libs/linux-gcc-#{gccversion}/libjson_linux-gcc-#{gccversion}_libmt.a",
    # "libs/linux-gcc-#{gccversion}/libjson_linux-gcc-#{gccversion}_libmt.dylib"

    # install the headers
    include.install "include/json" => "json"

    # the fix to this is to copy libjson.dylib to libjson_linux-gcc-4.2.1_libmt.dylib
    system "echo     cp /usr/local/opt/jsoncpp/lib/libjson.a /usr/local/opt/jsoncpp/lib/libjson_linux-gcc-#{gccversion}_libmt.a"
    system "echo     cp /usr/local/opt/jsoncpp/lib/libjson.dylib /usr/local/opt/jsoncpp/lib/libjson_linux-gcc-#{gccversion}_libmt.dylib"
  end

  test do
    system "false"
  end

end
