#!/bin/bash
# utils.sh

source build/ddl/ver.sh $@

packageName="$downloadPath/ddl.utils.$ddlBinVersion.zip"

echo "Building Utils"

$fullbuild $debug utils\\ddlinfo.d
$fullbuild $debug utils\\bless.d
$fullbuild $debug utils\\insitu.d

ls -alF utils/*.exe

echo "Packaging Binaries"

rm $packageName

zip -v9 $packageName utils/ddlinfo$binSuffix utils/bless$binSuffix utils/insitu$binSuffix
ls -alF $packageName

echo "Done"




