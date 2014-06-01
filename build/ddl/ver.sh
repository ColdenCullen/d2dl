#!/bin/bash
source build/vars.sh $@

ddlVersion="beta.1.3"
ddlBinVersion="$ddlVersion.$platform.bin"
ddlDocVersion="$ddlVersion.doc"
ddlSrcVersion="$ddlVersion.src"
downloadsPath="../downloads"

srcExtensions="d\\|lib\\|a\\|sh"
docExtensions="ddoc\\|html\\|pdf\\|doc\\|css\\|js\\|jpg\\|gif\\|png"

everything=".*\.\\($srcExtensions\\|$docExtensions\\)"
srcFiles=".*\.\\($srcExtensions\\)"
docFiles=".*\.\\($docExtensions\\)"