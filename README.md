# codeql-openjdk-docker
Use docker to build various versions of openjdk codeql database(not useful for M1 Mac)



# Usage
```
chmod u+x ./run.sh
./run.sh --bj [bootjdk] --tj [targetjdk]
```

for example

- default in `bootjdk` directory，use `jdk-7u80-linux-x64` as bootjdk
- default in `targetjdk` directory , use `jdk8u-jdk8u292-b01` as targetjdk
- so we can use the command：`./run.sh --bj jdk-7u80-linux-x64 --tj jdk8u-jdk8u292-b01` 
- If the openjdk codeql database is created successfully，the database will be placed in the `database` directory with the name `jdk8u-jdk8u292-b01`(targetjdk)



