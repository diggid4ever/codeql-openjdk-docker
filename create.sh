#!/bin/bash
/usr/lib/jvm/targetjdk/codeql/codeql database create result --language="java" --command="make all DISABLE_HOTSPOT_OS_VERSION_CHECK=OK ZIP_DEBUGINFO_FILES=0" --overwrite
