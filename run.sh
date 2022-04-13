#!/bin/bash
set -e
# Parse arguments (see https://stackoverflow.com/a/14203146)
# Checking if variable is set uses https://stackoverflow.com/a/13864829
while [[ $# -gt 0 ]]; do
  key="$1"

  case "$key" in
    --bj)
      if [ -z "${BOOT_JDK+x}" ]; then
        BOOT_JDK="$2"
      else
        echo "Duplicate 'bj' argument"
        exit 1
      fi
      shift # past parameter
      shift # past value
      ;;
    --tj)
      if [ -z "${TARGET_JDK+x}" ]; then
        TARGET_JDK="$2"
      else
        echo "Duplicate 'tj' argument"
        exit 1
      fi
      shift # past parameter
      shift # past value
      ;;
    *)
      echo "Unknown parameter '$key'"
      exit 1
      ;;
  esac
done

docker rmi -f codeql-jdk
docker build --network host --build-arg BOOT_JDK=$BOOT_JDK --build-arg TARGET_JDK=$TARGET_JDK -t codeql-jdk .
docker run --platform=linux/x86_64 --cpus=5 --name codeql-jdk codeql-jdk
docker cp codeql-jdk:/usr/lib/jvm/targetjdk/result ./database/$TARGET_JDK