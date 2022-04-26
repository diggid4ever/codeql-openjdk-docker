#!/bin/bash
/usr/lib/jvm/targetjdk/codeql/codeql database create result --language="java" --command="make images JOBS=4" --overwrite
