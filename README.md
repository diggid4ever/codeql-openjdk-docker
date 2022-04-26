# codeql-openjdk-docker

Use docker to build various versions of openjdk codeql database(not useful for M1 Mac)



# Set Up

```
cd codeql-openjdk-docker
mkdir targetjdk bootjdk codeql-cli
```

- targetjdk: download it from [openjdk in github](https://github.com/openjdk/jdk8u/tags) and place it in the targetjdk directory
- bootjdk: need N-1 version(if targetjdk is 8u, bootjdk must be 7u), download it from [oracle](https://www.oracle.com/java/technologies/oracle-java-archive-downloads.html).**Let the jdk version on the current shell be the version of bootjdk(you can use `jenv` to manage jdk version conventiently)**
- [codeql-cli](https://github.com/github/codeql-cli-binaries)



# Usage

```
chmod u+x ./run.sh
./run.sh --bj [bootjdk] --tj [targetjdk]
```

for example

- if use `jdk-7u80-linux-x64.tar.gz` as bootjdk  in `bootjdk` directory and use `jdk8u-jdk8u292-b01.tar.gz` as targetjdk in `targetjdk` directory, so we can use the command

```
./run.sh --bj jdk-7u80-linux-x64 --tj jdk8u-jdk8u292-b01
```

- If the openjdk codeql database is created successfully，the database will be placed in the `database` directory with the name `jdk8u-jdk8u292-b01`(targetjdk)



