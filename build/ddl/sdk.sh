#!/bin/bash
# sdk.sh

source build/ddl/ver.sh $@

packageName="../downloads/ddl.sdk.$ddlSrcVersion.zip";

echo "Building DDL SDK"
rm $packageName

packageFiles="$(find ddl meta utils etc test examples lib doc/ddl doc/meta build/ddl -regex $everything)"
	
zip -v9 $packageName $packageFiles 
ls -alF $packageName

echo "Done";
