#!/bin/bash
# doc.sh

source build/ddl/ver.sh $@

packageName="../downloads/ddl.sdk.$ddlDocVersion.zip"

echo "Building DDL Documentation"

rm $packageName
		
# crawl the source tree
$nolinkbuild -o- doc/ddl/xhtml.ddoc -Dd./doc/ddl/html -full -Xmango ddl/all.d
$nolinkbuild -o- doc/ddl/xhtml.ddoc -Dd./doc/ddl/html -full -Xmango examples/host.d
$nolinkbuild -o- doc/ddl/xhtml.ddoc -Dd./doc/ddl/html -full -Xmango examples/mule.d

$nolinkbuild -o- doc/ddl/xhtml.ddoc -Dd./doc/ddl/html -full -Xmango utils/bless.d
$nolinkbuild -o- doc/ddl/xhtml.ddoc -Dd./doc/ddl/html -full -Xmango utils/ddlinfo.d
$nolinkbuild -o- doc/ddl/xhtml.ddoc -Dd./doc/ddl/html -full -Xmango utils/insitu.d
		
# create an index for the doc tree
$compile -o- doc/ddl/modules.ddoc doc/ddl/index.ddoc -Df./doc/ddl/html/index.html ddl/all.d
		
packageFiles = "$(find doc/ddl doc/meta -regex $docFiles)"	
zip -v9 $packageName $packageFiles
ls -alF $packageName;

echo "Done";


