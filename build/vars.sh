
# if need be, change this to use your build tool of preference
fullbuild="build -full tango-user-dmd.lib zlib.lib "
nolinkbuild="build -nolink"
compile="dmd -c"

if  [ "$1" == "-debug" ]; then
    echo 'Debug Mode'
    let debug="-debug"
fi

if [ "$OS" == "Windows_NT" ]; then
	platform="win32"
	binSuffix=".exe"
else
	platform="linux.X86"
	binSuffix=""
fi
