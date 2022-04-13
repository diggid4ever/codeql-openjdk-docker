FROM --platform=linux/x86_64 ubuntu:16.04

ARG BOOT_JDK=jdk-7u80-linux-x64
ARG BOOT_JDK_FILENAME=${BOOT_JDK}.tar.gz
ARG TARGET_JDK=jdk8u-jdk8u292-b01
ARG TARGET_JDK_FILENAME=${TARGET_JDK}.tar.gz

RUN mkdir /usr/lib/jvm && \
    rm /bin/sh && ln -s /bin/bash /bin/sh && \
    mv /etc/apt/sources.list /etc/apt/sources.list.bak

COPY source.list /etc/apt/sources.list 

WORKDIR /usr/lib/jvm

COPY bootjdk/${BOOT_JDK_FILENAME} bootjdk.tar.gz

COPY targetjdk/${TARGET_JDK_FILENAME} targetjdk.tar.gz

RUN mkdir bootjdk && \
    mkdir targetjdk && \
    tar --strip-components 1 -zxvf bootjdk.tar.gz -C bootjdk && \
    tar --strip-components 1 -zxvf targetjdk.tar.gz -C targetjdk && \
    echo -e "export JAVA_HOME=/usr/lib/jvm/bootjdk\nexport JRE_HOME=\${JAVA_HOME}/jre\nexport CLASSPATH=.:\${JAVA_HOME}/lib:\${JRE_HOME}/lib\nexport PATH=\${JAVA_HOME}/bin:\$PATH" >> ~/.bashrc && \
    source ~/.bashrc && \
    update-alternatives --install /usr/bin/java java /usr/lib/jvm/bootjdk/bin/java 300 && \
    update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/bootjdk/bin/javac 300 && \
    update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/bootjdk/bin/jar 300 && \
    update-alternatives --install /usr/bin/javah javah /usr/lib/jvm/bootjdk/bin/javah 300 && \ 
    update-alternatives --install /usr/bin/javap javap /usr/lib/jvm/bootjdk/bin/javap 300 && \
    update-alternatives --config java && \
    java -version

WORKDIR /usr/lib/jvm/targetjdk
RUN apt-get -y update && \
    echo "[+]apt-get update" && \
    apt-get -y upgrade && \
    echo "[+]apt-get upgrade"

RUN apt-get install -y build-essential gdb cmake cpio file unzip zip wget ccache 

RUN apt-get install -y --no-install-recommends libfontconfig1-dev libfreetype6-dev libcups2-dev libx11-dev libxext-dev libxrender-dev libxrandr-dev libxtst-dev libxt-dev libasound2-dev libffi-dev autoconf

RUN wget http://ftp.gnu.org/gnu/make/make-3.81.tar.gz && \
    tar -zxvf make-3.81.tar.gz && \
    cd make-3.81 && \
    bash configure -prefix=/usr && \
    make && \
    make install 

RUN chmod 777 configure && \
    ./configure --with-target-bits=64 --with-boot-jdk=/usr/lib/jvm/bootjdk --with-debug-level=slowdebug --enable-debug-symbols ZIP_DEBUGINFO_FILES=0 

COPY codeql-cli/codeql-linux64.zip codeql.zip
RUN unzip codeql.zip && \
    /usr/lib/jvm/targetjdk/codeql/codeql version && \
    echo "[+]codeql ok"

# COPY codeql-cli/jdk-11.0.13_linux-x64_bin.tar.gz ./codeql/tools/linux64/jdk11.tar.gz
# RUN cd codeql/tools/linux64 && \
#     tar -zxvf jdk11.tar.gz && \
#     mv java java-bak && \
#     mv jdk-11.0.13 java 

COPY create.sh create.sh

RUN chmod u+x create.sh

CMD [ "./create.sh" ]